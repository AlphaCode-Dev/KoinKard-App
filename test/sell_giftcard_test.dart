import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/models/api_result.dart';
import 'package:koinkard/data/models/giftcard/giftcard_commerce_response_model.dart';
import 'package:koinkard/data/models/giftcard/giftcard_product_model.dart';
import 'package:koinkard/data/network/services/api_client.dart';
import 'package:koinkard/data/services/giftcard/giftcard_trade_service.dart';
import 'package:koinkard/ui/views/giftcard/sell/sell_giftcard_view.dart';
import 'package:koinkard/ui/views/giftcard/sell/sell_giftcard_viewmodel.dart';
import 'package:koinkard/ui/views/giftcard/sell/widgets/sell_giftcard_card_selector.dart';
import 'package:koinkard/ui/views/giftcard/sell/widgets/inset_dropdown_field.dart';
import 'package:koinkard/ui/views/giftcard/widgets/giftcard_grid.dart';
import 'package:koinkard/ui/views/home/models/popular_card.dart';
import 'package:koinkard/ui/views/home/widgets/popular_cards_section.dart';

import 'helpers/test_helpers.dart';

class _TradeService extends GiftcardTradeService {
  _TradeService() : super(ApiClient(Dio()));

  Future<ApiResult<GiftcardCommerceResponseModel>>? pendingResponse;

  @override
  Future<ApiResult<GiftcardCommerceResponseModel>> fetchCommerce() async {
    if (pendingResponse != null) return await pendingResponse!;
    return ApiResult.success(GiftcardCommerceResponseModel(
      nairaBalance: '0',
      securityCodeEnabled: false,
      products: [
        _product(1, 'Steam', 1200),
        _product(2, 'iTunes', 1100),
        _product(3, 'Steam', 900, symbol: 'GBP'),
      ],
    ));
  }
}

GiftcardProductModel _product(int id, String name, double rate,
        {String symbol = 'USD'}) =>
    GiftcardProductModel(
      id: id,
      kind: 'gift_card',
      name: name,
      symbol: symbol,
      buyRate: rate,
      sellRate: 0,
      paymentDetails: '',
      instructions: '',
      enabled: true,
    );

Widget _app(Widget child) => ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
    );

void _phoneSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  setUp(() {
    registerServices();
    locator.registerSingleton<GiftcardTradeService>(_TradeService());
  });
  tearDown(() async => locator.reset());

  test('keeps the tapped brand and estimates only the chosen product',
      () async {
    final model = SellGiftcardViewModel(initialBrand: 'Steam');
    addTearDown(model.dispose);
    await model.initialise();
    expect(model.selectedBrand, 'Steam');
    expect(model.selectedProduct, isNull);
    model.setAmount(50);
    expect(model.estimatedPayoutValue, 0);
    model.selectSubcategory(1);
    expect(model.estimatedPayoutValue, 60000);
    model.selectBrand('Apple (iTunes)');
    expect(model.selectedProduct, isNull);
    expect(model.estimatedPayoutValue, 0);
    model.selectSubcategory(2);
    expect(model.estimatedPayoutValue, 55000);
  });

  test('unavailable cards cannot fall back to another brands product',
      () async {
    final model = SellGiftcardViewModel(initialBrand: 'Chime');
    addTearDown(model.dispose);
    await model.initialise();
    model.selectSubcategory(1);
    model.setAmount(50);
    model.codeController.text = 'TEST-CODE';
    expect(model.selectedBrand, 'Chime');
    expect(model.productsForSelectedBrand, isEmpty);
    expect(model.selectedProduct, isNull);
    expect(model.canSubmit, isFalse);
  });

  test('selecting the same card keeps its subcategory', () async {
    final model = SellGiftcardViewModel(initialBrand: 'Steam');
    addTearDown(model.dispose);
    await model.initialise();
    model.selectSubcategory(3);
    model.selectBrand('Steam');
    expect(model.selectedProductId, 3);
    expect(model.selectedProduct?.countryLabel, 'GBP');
  });

  test('empty catalog keeps the selected card without inventing products',
      () async {
    (locator<GiftcardTradeService>() as _TradeService).pendingResponse =
        Future.value(ApiResult.success(const GiftcardCommerceResponseModel(
      nairaBalance: '0',
      securityCodeEnabled: false,
      products: [],
    )));
    final model = SellGiftcardViewModel(initialBrand: 'Steam');
    addTearDown(model.dispose);
    await model.initialise();
    expect(model.selectedBrand, 'Steam');
    expect(model.availableBrands, contains('Steam'));
    expect(model.selectedProduct, isNull);
  });

  testWidgets(
      'card can change during loading and is not overwritten by the response',
      (tester) async {
    _phoneSize(tester);
    final response = Completer<ApiResult<GiftcardCommerceResponseModel>>();
    (locator<GiftcardTradeService>() as _TradeService).pendingResponse =
        response.future;
    await tester
        .pumpWidget(_app(const SellGiftcardView(initialBrand: 'Steam')));
    await tester.pump();
    await tester.tap(find.byType(SellGiftcardCardSelector));
    // Catalog loading keeps its progress indicator active.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Apple (iTunes)').last);
    await tester.pump(const Duration(milliseconds: 300));
    response.complete(ApiResult.success(GiftcardCommerceResponseModel(
      nairaBalance: '0',
      securityCodeEnabled: false,
      products: [_product(1, 'Steam', 1200), _product(2, 'iTunes', 1100)],
    )));
    await tester.pumpAndSettle();
    expect(find.text('Apple (iTunes)'), findsOneWidget);
    await tester.tap(find.byType(InsetDropdownField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('USD').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('50'));
    await tester.pumpAndSettle();
    expect(find.text('\u20a655000.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('changing the card resets and reloads its subcategory options',
      (tester) async {
    _phoneSize(tester);
    await tester
        .pumpWidget(_app(const SellGiftcardView(initialBrand: 'Steam')));
    await tester.pumpAndSettle();
    final subField = tester
        .getRect(find.byKey(const ValueKey('subcategory-selector-field')));
    expect(subField.width, 350);
    await tester.tap(find.byType(InsetDropdownField<int>));
    await tester.pumpAndSettle();
    final subMenu =
        tester.getRect(find.byKey(const ValueKey('subcategory-option-3')));
    expect(subMenu.width, closeTo(subField.width - 60, 1));
    expect(subMenu.left, closeTo(subField.left + 30, 1));
    await tester.tap(find.text('GBP').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('50'));
    await tester.pumpAndSettle();
    expect(find.text('\u20a645000.00'), findsOneWidget);
    final fieldRect =
        tester.getRect(find.byKey(const ValueKey('card-selector-field')));
    expect(fieldRect.width, 350);
    await tester.tap(find.byType(SellGiftcardCardSelector));
    await tester.pumpAndSettle();
    final menuRect =
        tester.getRect(find.byKey(const ValueKey('card-option-Steam')));
    expect(menuRect.width, closeTo(fieldRect.width - 60, 1));
    expect(menuRect.left, closeTo(fieldRect.left + 30, 1));
    await tester.tap(find.text('Apple (iTunes)').last);
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<InsetDropdownField<int>>(
                find.byType(InsetDropdownField<int>))
            .initialValue,
        isNull);
    expect(find.text('\u20a60.00'), findsOneWidget);
    await tester.tap(find.byType(InsetDropdownField<int>));
    await tester.pumpAndSettle();
    expect(find.text('GBP'), findsNothing);
    await tester.tap(find.text('USD').last);
    await tester.pumpAndSettle();
    expect(find.text('\u20a655000.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('grid card opens selling form and amount shortcut updates payout',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_app(const GiftcardGrid(cards: ['Steam'])));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Steam'));
    await tester.pumpAndSettle();
    expect(find.byType(SellGiftcardView), findsOneWidget);
    expect(find.text('Sell Cards'), findsOneWidget);
    expect(find.text('Steam'), findsOneWidget);
    expect(find.byIcon(Icons.notifications), findsNothing);
    expect(find.byIcon(Icons.support_agent), findsNothing);
    await tester.tap(find.byType(InsetDropdownField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('USD').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('50'));
    await tester.pumpAndSettle();
    expect(find.text('\u20a660000.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(SellGiftcardView), findsNothing);
  });

  testWidgets(
      'home card opens its brand and empty form validates on a small screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_app(const PopularCardsSection(cards: [
      PopularCard(name: 'Apple (iTunes)', rate: '1100'),
    ])));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apple (iTunes)'));
    await tester.pumpAndSettle();
    expect(find.byType(SellGiftcardView), findsOneWidget);
    expect(find.text('Apple (iTunes)'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('Choose an available subcategory.'), findsOneWidget);
    expect(find.text('Card amount is required.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
