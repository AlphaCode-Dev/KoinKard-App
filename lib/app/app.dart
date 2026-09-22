import 'package:koinkard/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:koinkard/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:koinkard/ui/views/home/home_view.dart';
import 'package:koinkard/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:koinkard/ui/views/splash/splash_view.dart';
import 'package:koinkard/ui/views/onboarding/onboarding_view.dart';
import 'package:koinkard/ui/auth/register/register_view.dart';
import 'package:koinkard/ui/views/bottomnavbar/bottomnavbar_view.dart';
import 'package:koinkard/ui/views/assets/assets_view.dart';
import 'package:koinkard/ui/views/giftcard/giftcard_view.dart';
import 'package:koinkard/ui/views/trade/trade_view.dart';
import 'package:koinkard/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SplashView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: RegisterView),
MaterialRoute(page: BottomnavbarView),
MaterialRoute(page: AssetsView),
MaterialRoute(page: GiftcardView),
MaterialRoute(page: TradeView),
MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
