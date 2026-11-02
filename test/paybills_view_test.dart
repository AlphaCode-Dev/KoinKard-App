import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/ui/views/home/widgets/home_services_section.dart';
import 'package:koinkard/ui/views/paybills/paybills_view.dart';

void main() {
  testWidgets('Pay Bills opens the bill list and returns home', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => const MaterialApp(
        home: Scaffold(body: HomeServicesSection()),
      ),
    ));
    await tester.tap(find.text('Pay Bills'));
    await tester.pumpAndSettle();

    expect(find.byType(PaybillsView), findsOneWidget);
    for (final label in [
      'Select bill',
      'Electricity',
      'TV',
      'MTN',
      'Airtel',
      'Glo'
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    await tester.ensureVisible(find.text('9mobile'));
    await tester.pumpAndSettle();
    expect(find.text('9mobile'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(PaybillsView), findsNothing);
    expect(find.text('Pay Bills'), findsOneWidget);
  });
}
