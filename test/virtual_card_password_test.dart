import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/ui/views/virtual_card/virtual_card_view.dart';
import 'package:koinkard/ui/views/virtual_card/virtual_card_viewmodel.dart';
import 'package:koinkard/ui/views/virtual_card/widgets/card_password_sheet.dart';

void main() {
  test('password verification rejects empty, incorrect and unavailable checks',
      () async {
    final unavailable = VirtualCardViewModel();
    addTearDown(unavailable.dispose);
    expect(
        await unavailable.verifyPassword(''), 'Enter your account password.');
    expect(await unavailable.verifyPassword('anything'),
        'Password verification is not available yet.');
    final model = VirtualCardViewModel(
        passwordVerifier: (password) async =>
            password == 'test-correct-password');
    addTearDown(model.dispose);
    expect(await model.verifyPassword('wrong'),
        'Incorrect password. Please try again.');
    expect(await model.verifyPassword('test-correct-password'), isNull);
    final failing = VirtualCardViewModel(
        passwordVerifier: (_) async => throw Exception('offline'));
    addTearDown(failing.dispose);
    expect(await failing.verifyPassword('anything'),
        'Unable to verify your password. Please try again.');
  });

  for (final action in ['Card details', 'Terminate card']) {
    testWidgets('$action requires a password and cannot bypass verification',
        (tester) async {
      await loadAppFonts();
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MaterialApp(
          theme: ThemeData(fontFamily: 'Manrope'),
          home: const VirtualCardView()));
      await tester.tap(find.text(action));
      await tester.pumpAndSettle();
      expect(find.byType(CardPasswordSheet), findsOneWidget);
      await tester.tap(find.text('Verify password'));
      await tester.pumpAndSettle();
      expect(find.text('Enter your account password.'), findsOneWidget);
      final field = find.byKey(const ValueKey('card-action-password'));
      final textField =
          find.descendant(of: field, matching: find.byType(TextField));
      expect(tester.widget<TextField>(textField).obscureText, isTrue);
      await tester.enterText(field, 'not-a-verified-password');
      await tester.tap(find.text('Verify password'));
      await tester.pumpAndSettle();
      expect(find.text('Password verification is not available yet.'),
          findsOneWidget);
      expect(find.text('Terminate this card?'), findsNothing);
      expect(find.byType(CardPasswordSheet), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(CardPasswordSheet), findsNothing);
      expect(find.byType(VirtualCardView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
