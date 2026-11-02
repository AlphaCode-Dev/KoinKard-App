import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/paybills/airtime_view.dart';
import 'package:koinkard/ui/views/paybills/paybills_viewmodel.dart';
import 'package:koinkard/ui/views/paybills/paybills_view.dart';

void main() {
  test('validates Nigerian numbers and airtime amount limits', () {
    final model = PaybillsViewModel();
    addTearDown(model.dispose);
    expect(model.validatePhone('08012345678'), isNull);
    expect(model.validatePhone('8012345678'), isNull);
    expect(model.validatePhone('1234'), isNotNull);
    expect(model.validateAmount('50'), isNull);
    expect(model.validateAmount('500000'), isNull);
    for (final invalid in ['', '49', '500001', 'NaN', 'Infinity']) {
      expect(model.validateAmount(invalid), isNotNull);
    }
  });

  testGoldens('Airtime opens selected network and accepts top ups',
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
        home: const PaybillsView(),
      ),
    ));
    await tester.tap(find.text('Airtel'));
    await tester.pumpAndSettle();
    expect(find.byType(AirtimeView), findsOneWidget);
    final viewContext = tester.element(find.byType(AirtimeView));
    final model = tester.widget<AirtimeView>(find.byType(AirtimeView));
    expect(model.viewModel.network, AirtimeNetwork.airtel);
    expect(viewContext.mounted, isTrue);
    await screenMatchesGolden(tester, 'airtime_default');

    await tester.tap(find.text('Pay'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid Nigerian phone number.'), findsOneWidget);
    expect(find.text('Enter an amount from ₦50 to ₦500,000.'), findsOneWidget);
    await tester.enterText(
        find.byKey(const ValueKey('airtime-phone')), '08012345678');
    await tester.tap(find.text('₦500'));
    expect(
        tester
            .widget<TextFormField>(find.byKey(const ValueKey('airtime-amount')))
            .controller!
            .text,
        '500');
    await tester.tap(find.text('Popular'));
    await tester.pumpAndSettle();
    expect(find.text('₦10,000'), findsOneWidget);

    tester.view.physicalSize = const Size(320, 640);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Pay'), 150,
        scrollable: find
            .descendant(
              of: find.byType(ListView).last,
              matching: find.byType(Scrollable),
            )
            .first);
    await tester.tap(find.text('Pay'));
    await tester.pumpAndSettle();
    expect(
        find.text('Airtime payments are not available yet.'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(model.viewModel.phoneController.text, '08012345678');
    await tester.tap(find.text('MTN'));
    await tester.pumpAndSettle();
    final reopened = tester.widget<AirtimeView>(find.byType(AirtimeView));
    expect(identical(reopened.viewModel, model.viewModel), isTrue);
    expect(reopened.viewModel.network, AirtimeNetwork.mtn);
    expect(reopened.viewModel.amountController.text, '500');
    expect(tester.takeException(), isNull);
  });
}
