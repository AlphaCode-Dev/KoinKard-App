import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserCenterHeader(),
              const SizedBox(height: 26),
              UserCenterProfileIntro(
                profileImagePath: viewModel.profileImagePath,
                onProfileImageTap: viewModel.pickProfileImage,
              ),
              const SizedBox(height: 22),
              UserCenterTabs(
                activeTab: viewModel.activeTab,
                onTabSelected: viewModel.selectTab,
              ),
              const SizedBox(height: 18),
              UserCenterContent(
                activeTab: viewModel.activeTab,
                google2FaEnabled: viewModel.google2FaEnabled,
                profileImagePath: viewModel.profileImagePath,
                onGoogle2FaChanged: viewModel.setGoogle2FaEnabled,
                onProfileImageTap: viewModel.pickProfileImage,
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
