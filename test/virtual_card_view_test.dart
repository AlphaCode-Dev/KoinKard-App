import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/home/widgets/home_services_section.dart';
import 'package:koinkard/ui/views/virtual_card/virtual_card_view.dart';
import 'package:koinkard/ui/views/virtual_card/widgets/virtual_card_face.dart';
import 'package:koinkard/ui/views/virtual_card/widgets/virtual_card_benefits_carousel.dart';

void main() {
  testWidgets('Benefits advance automatically and loop without indicators',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: VirtualCardBenefitsCarousel())));
    expect(find.text('Accepted by 150M+ merchants'), findsOneWidget);
    for (final message in [
      'Apple Pay and Google Pay enabled',
      'Enjoy all Visa platinum benefits',
      'Spending limit up to \$10,000 daily',
      'Accepted by 150M+ merchants',
    ]) {
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
      expect(find.text(message), findsOneWidget);
    }
    expect(find.byType(InkWell), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 5));
    expect(tester.takeException(), isNull);
  });

  testGoldens('Virtual Card shows custom artwork and an empty lower panel',
      (tester) async {
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
    }
    expect(find.byType(VirtualCardFace), findsOneWidget);
    expect(find.text('PREVIEW'), findsOneWidget);
    expect(
        find.descendant(
            of: find.byKey(const ValueKey('virtual-card-lower-panel')),
            matching: find.byType(Text)),
        findsNothing);
    for (final label in ['Send', 'Receive', 'Add']) {
      expect(find.text(label), findsOneWidget);
    }
    await screenMatchesGolden(tester, 'virtual_card_empty');
    expect(find.text('Accepted by 150M+ merchants'), findsOneWidget);
    for (final message in [
      'Apple Pay and Google Pay enabled',
      'Enjoy all Visa platinum benefits',
      'Spending limit up to \$10,000 daily',
    ]) {
      await tester.drag(
          find.byType(VirtualCardBenefitsCarousel), const Offset(-350, 0));
      await tester.pumpAndSettle();
      expect(find.text(message), findsOneWidget);
    }
    tester.view.physicalSize = const Size(320, 568);
    tester.view.padding = const FakeViewPadding(top: 44);
    addTearDown(tester.view.resetPadding);
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
