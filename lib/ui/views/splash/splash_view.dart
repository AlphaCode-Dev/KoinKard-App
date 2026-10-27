import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:stacked/stacked.dart';
import 'package:koinkard/common/app_colors.dart';
import 'splash_viewmodel.dart';

class SplashView extends StackedView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SplashViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FractionallySizedBox(
            widthFactor: .65,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Image.asset(
                AppAssets.kklogo,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SplashViewModel();

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => viewModel.runStartupLogic(),
    );
  }
}
