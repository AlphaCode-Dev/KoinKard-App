import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/paybills/paybills_view.dart';
import 'package:koinkard/ui/views/paybills/paybills_viewmodel.dart';
import 'package:koinkard/ui/views/paybills/tv_view.dart';
import 'package:koinkard/ui/views/paybills/electricity_view.dart';

Future<void> showButton(WidgetTester tester, String label) async {
  await tester.scrollUntilVisible(find.text(label), 150,
      scrollable: find
          .descendant(
              of: find.byType(ListView).last, matching: find.byType(Scrollable))
          .first);
  await tester.pumpAndSettle();
}

void main() {
  test('utility provider changes clear incompatible account and package state',
      () {
    final model = PaybillsViewModel();
    addTearDown(model.dispose);
    final package = model.televisionPackages.first;
    model.selectTelevisionPackage(package);
    model.smartcardController.text = '1234567890';
    model.selectTelevisionProvider(TelevisionProvider.gotv);
    expect(model.selectedTelevisionPackage, isNull);
    expect(model.smartcardController.text, isEmpty);
    model.selectTelevisionPackage(package);
    expect(model.selectedTelevisionPackage, isNull);
    model.meterController.text = '12345678901';
    model.selectElectricityProvider(ElectricityProvider.eko);
    expect(model.meterController.text, isEmpty);
    model.selectElectricityAmount(5000);
    expect(model.validateElectricityAmount('5000'), isNull);
    expect(model.validateElectricityAmount('999'), isNotNull);
    expect(model.validateElectricityAmount('NaN'), isNotNull);
  });

  for (final isTv in [true, false]) {
    testGoldens(
        '${isTv ? 'TV' : 'Electricity'} opens and validates on a small phone',
        (tester) async {
      await loadAppFonts();
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
            theme: ThemeData(fontFamily: 'Manrope'),
            home: const PaybillsView()),
      ));
      await tester.tap(find.text(isTv ? 'TV' : 'Electricity'));
      await tester.pumpAndSettle();
      final model = isTv
          ? tester.widget<TvView>(find.byType(TvView)).viewModel
          : tester
              .widget<ElectricityView>(find.byType(ElectricityView))
              .viewModel;
      await screenMatchesGolden(
          tester, isTv ? 'tv_default' : 'electricity_default');
      final providerField = find.byKey(
          ValueKey(isTv ? 'tv-provider-field' : 'electricity-provider-field'));
      final providerRect = tester.getRect(providerField);
      await tester.tap(providerField);
      await tester.pumpAndSettle();
      final providerOption = find.byKey(ValueKey(
          isTv ? 'provider-option-GOtv' : 'provider-option-Eko Electric'));
      final optionRect = tester.getRect(providerOption);
      expect(optionRect.width, closeTo(providerRect.width - 60, 1));
      expect(optionRect.left, closeTo(providerRect.left + 30, 1));
      await tester.tap(providerOption);
      await tester.pumpAndSettle();
      if (isTv) {
        expect(model.televisionProvider, TelevisionProvider.gotv);
      } else {
        expect(model.electricityProvider, ElectricityProvider.eko);
      }
      tester.view.physicalSize = const Size(320, 700);
      await tester.pumpAndSettle();
      final button = isTv ? 'Pay Subscription' : 'Pay Electricity';
      await showButton(tester, button);
      await tester.tap(find.text(button));
      await tester.pumpAndSettle();
      expect(
          find.text(isTv
              ? 'Choose a TV package.'
              : 'Enter an amount from ₦1,000 to ₦500,000.'),
          findsOneWidget);
      final account =
          find.byKey(ValueKey(isTv ? 'tv-smartcard' : 'electricity-meter'));
      await tester.ensureVisible(account);
      await tester.pumpAndSettle();
      await tester.enterText(account, '12345678901');
      final phone =
          find.byKey(ValueKey(isTv ? 'tv-phone' : 'electricity-phone'));
      await tester.ensureVisible(phone);
      await tester.pumpAndSettle();
      await tester.enterText(phone, '08012345678');
      final option = find.text(isTv ? 'Basic' : '₦5,000');
      await tester.ensureVisible(option);
      await tester.pumpAndSettle();
      await tester.tap(option);
      await tester.pumpAndSettle();
      if (isTv) {
        expect(model.selectedTelevisionPackage?.name, 'Basic');
      } else {
        expect(model.electricityAmountController.text, '5000');
      }
      await showButton(tester, button);
      await tester.tap(find.text(button));
      await tester.pumpAndSettle();
      expect(
          find.text(isTv
              ? 'TV payments are not available yet.'
              : 'Electricity payments are not available yet.'),
          findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Select bill'), findsOneWidget);
      expect(model.phoneController.text, '08012345678');
      expect(tester.takeException(), isNull);
    });
  }
}
