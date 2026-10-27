import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:koinkard/ui/auth/login/login_view.dart';
import 'package:koinkard/ui/views/home/home_view.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setUp(() => setupLocator());
  tearDown(() => locator.reset());

  for (final initialRoute in [Routes.loginView, Routes.registerView]) {
    testWidgets('Login from $initialRoute opens Home without authentication',
        (tester) async {
      await loadAppFonts();
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          navigatorKey: StackedService.navigatorKey,
          initialRoute: initialRoute,
          onGenerateRoute: StackedRouter().onGenerateRoute,
        ),
      ));
      await tester.pumpAndSettle();

      final loginButton = initialRoute == Routes.registerView
          ? find.text('Login Now')
          : find.byWidgetPredicate(
              (widget) =>
                  widget is KoinkardPrimaryButton && widget.text == 'Login',
            );
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      if (initialRoute == Routes.registerView) {
        expect(tester.takeException(), isNull);
        expect(find.byType(LoginView), findsOneWidget);
        expect(find.byType(HomeView), findsNothing);

        final submitButton = find.byWidgetPredicate(
          (widget) => widget is KoinkardPrimaryButton && widget.text == 'Login',
        );
        await tester.ensureVisible(submitButton);
        await tester.tap(submitButton);
        await tester.pumpAndSettle();
      }

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text('Total Balance'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
