import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/views/profile/widgets/user_center_content.dart';
import 'package:koinkard/ui/views/profile/widgets/user_center_header.dart';
import 'package:koinkard/ui/views/profile/widgets/user_center_profile_intro.dart';
import 'package:koinkard/ui/views/profile/widgets/user_center_tabs.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserCenterHeader(),
              const SizedBox(height: 26),
              const UserCenterProfileIntro(),
              const SizedBox(height: 22),
              UserCenterTabs(
                activeTab: viewModel.activeTab,
                onTabSelected: viewModel.selectTab,
              ),
              const SizedBox(height: 18),
              UserCenterContent(
                activeTab: viewModel.activeTab,
                google2FaEnabled: viewModel.google2FaEnabled,
                onGoogle2FaChanged: viewModel.setGoogle2FaEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();
}
