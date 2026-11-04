import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/home/widgets/home_services_section.dart';
import 'package:koinkard/ui/views/virtual_card/virtual_card_view.dart';
import 'package:koinkard/ui/views/virtual_card/widgets/virtual_card_face.dart';
import 'package:koinkard/ui/views/virtual_card/widgets/virtual_card_benefits_carousel.dart';

void main() {
  testWidgets('Benefits use tappable indicators without autoplay',
      (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: VirtualCardBenefitsCarousel())));
    expect(find.text('Accepted by 150M+ merchants'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Accepted by 150M+ merchants'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('benefit-indicator-3')));
    await tester.pumpAndSettle();
    expect(find.text('Spending limit up to \$10,000 daily'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('benefit-indicator-0')));
    await tester.pumpAndSettle();
    expect(find.text('Accepted by 150M+ merchants'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testGoldens('Virtual Card shows custom artwork and card controls',
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
    final normalCard = tester.getBottomRight(find.byType(VirtualCardFace)) -
        tester.getTopLeft(find.byType(VirtualCardFace));
    expect(normalCard.dx, closeTo(346, 0.2));
    expect(normalCard.dy, closeTo(218.2, 0.2));
    expect(find.text('Cards'), findsOneWidget);
    expect(find.byTooltip('More options'), findsNothing);
    expect(find.text('Create new card'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Create new card')).style!.fontWeight,
        FontWeight.w700);
    for (final label in [
      'Unfreeze card',
      'Card limits',
      'Linked balances',
      'View billing address'
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    for (final label in ['Card details', 'Transactions', 'Terminate card']) {
      expect(find.text(label), findsOneWidget);
    }
    await screenMatchesGolden(tester, 'virtual_card_empty');
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    await tester.tap(find.text('Card limits'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Your card limits will appear here when your virtual card is issued.'),
        findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    final carouselRect =
        tester.getRect(find.byType(VirtualCardBenefitsCarousel));
    expect(carouselRect.width, 390);
    expect(carouselRect.top, greaterThan(0));
    expect(carouselRect.bottom, lessThan(844));
    expect(
        find.text('Accepted by 150M+ merchants').hitTestable(), findsOneWidget);
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
    final smallCard = tester.getBottomRight(find.byType(VirtualCardFace)) -
        tester.getTopLeft(find.byType(VirtualCardFace));
    expect(smallCard.dx, closeTo(122.4, 0.2));
    expect(smallCard.dy, closeTo(77.3, 0.2));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(VirtualCardView), findsNothing);
    expect(find.text('Virtual Card'), findsOneWidget);
  });
}
