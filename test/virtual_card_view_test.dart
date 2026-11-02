import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/home/widgets/home_services_section.dart';
import 'package:koinkard/ui/views/virtual_card/virtual_card_view.dart';

void main() {
  testGoldens('Virtual Card opens with two empty white panels', (tester) async {
    await loadAppFonts();
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Manrope'),
        home: const Scaffold(body: HomeServicesSection()),
      ),
    ));
    await tester.tap(find.text('Virtual Card'));
    await tester.pumpAndSettle();
    expect(find.byType(VirtualCardView), findsOneWidget);
    for (final panel in [
      'virtual-card-upper-panel',
      'virtual-card-lower-panel'
    ]) {
      final finder = find.byKey(ValueKey(panel));
      expect(finder, findsOneWidget);
      expect(find.descendant(of: finder, matching: find.byType(Text)),
          findsNothing);
    }
    for (final label in ['Send', 'Receive', 'Add']) {
      expect(find.text(label), findsOneWidget);
    }
    await screenMatchesGolden(tester, 'virtual_card_empty');
    tester.view.physicalSize = const Size(320, 568);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('More options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back to Home'));
    await tester.pumpAndSettle();
    expect(find.byType(VirtualCardView), findsNothing);
    expect(find.text('Virtual Card'), findsOneWidget);
  });
}
