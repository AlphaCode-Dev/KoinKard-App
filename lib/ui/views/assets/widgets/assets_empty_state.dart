import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/assets_viewmodel.dart';

class AssetsEmptyState extends StatelessWidget {
  const AssetsEmptyState({
    super.key,
    required this.activeTab,
  });

  final AssetsTabType activeTab;

  @override
  Widget build(BuildContext context) {
    final message = activeTab == AssetsTabType.asset
        ? 'No Available Data'
        : 'No Account Data';

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: 132,
            height: 132,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 18,
                  child: Container(
                    width: 38,
                    height: 64,
                    decoration: BoxDecoration(
                      color: kOrangeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 24,
                  child: Container(
                    width: 8,
                    height: 24,
                    color: kOrangeColor.withValues(alpha: 0.18),
                  ),
                ),
                Positioned(
                  top: 44,
                  right: 24,
                  child: Container(
                    width: 8,
                    height: 18,
                    color: kOrangeColor.withValues(alpha: 0.14),
                  ),
                ),
                Transform.rotate(
                  angle: 0.14,
                  child: Container(
                    width: 54,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: kWhiteColor.withValues(alpha: 0.88),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 2,
                            color: kWhiteColor.withValues(alpha: 0.92),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 18,
                            height: 2,
                            color: kWhiteColor.withValues(alpha: 0.74),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: kWhiteColor.withValues(alpha: 0.88),
                                    width: 1.3,
                                  ),
                                  bottom: BorderSide(
                                    color: kWhiteColor.withValues(alpha: 0.88),
                                    width: 1.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            message,
            style: AppTextStyles.paragraphLarge.copyWith(
              color: kWhiteColor.withValues(alpha: 0.42),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
