import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/local/profile_image_service.dart';
import 'package:koinkard/ui/views/home/home_view.dart';
import 'package:koinkard/ui/views/transfer/transfer_view.dart';
import 'package:koinkard/ui/views/transfer/widgets/transfer_option_card.dart';

void main() {
  setUp(() =>
      locator.registerSingleton<ProfileImageService>(ProfileImageService()));
  tearDown(() async => locator.reset());

  testWidgets(
      'Home Transfer opens the three-option screen and back returns home',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => const MaterialApp(home: HomeView()),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Transfer'));
    await tester.pumpAndSettle();
    expect(find.byType(TransferView), findsOneWidget);
    expect(find.byType(TransferOptionCard), findsNWidgets(3));
    expect(find.text('KoinKard ID'), findsOneWidget);
    expect(find.text('No Fee'), findsOneWidget);
    expect(find.text('Bank Account'), findsOneWidget);
    expect(find.text('Stablecoins'), findsOneWidget);
    expect(find.text('New'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(TransferView), findsNothing);
    expect(find.byType(HomeView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
