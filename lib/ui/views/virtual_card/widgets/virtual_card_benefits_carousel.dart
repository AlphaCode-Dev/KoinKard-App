import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class VirtualCardBenefitsCarousel extends StatefulWidget {
  const VirtualCardBenefitsCarousel({super.key});

  @override
  State<VirtualCardBenefitsCarousel> createState() =>
      _VirtualCardBenefitsCarouselState();
}

class _VirtualCardBenefitsCarouselState
    extends State<VirtualCardBenefitsCarousel> {
  static const _slides = [
    (icon: Icons.storefront_outlined, text: 'Accepted by 150M+ merchants'),
    (
      icon: Icons.contactless_outlined,
      text: 'Apple Pay and Google Pay enabled'
    ),
    (
      icon: Icons.workspace_premium_outlined,
      text: 'Enjoy all Visa platinum benefits'
    ),
    (
      icon: Icons.account_balance_wallet_outlined,
      text: 'Spending limit up to \$10,000 daily'
    ),
  ];

  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 76 + MediaQuery.textScalerOf(context).scale(32),
      child: SafeArea(
          top: false,
          bottom: false,
          child: Column(children: [
            Expanded(
                child: PageView.builder(
              controller: _controller,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 4),
                child: Row(children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.white.withValues(alpha: 0.10))),
                      child: Icon(_slides[index].icon,
                          color: AppColors.primary, size: 23)),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Text(_slides[index].text,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4))),
                ]),
              ),
            )),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      _slides.length,
                      (index) => Semantics(
                            label:
                                'Card benefit ${index + 1} of ${_slides.length}',
                            selected: index == _page,
                            child: InkWell(
                              key: ValueKey('benefit-indicator-$index'),
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _controller.animateToPage(index,
                                  duration: const Duration(milliseconds: 280),
                                  curve: Curves.easeOutCubic),
                              child: SizedBox(
                                  width: 28,
                                  height: 24,
                                  child: Center(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: index == _page ? 18 : 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: index == _page
                                              ? AppColors.primary
                                              : AppColors.white
                                                  .withValues(alpha: 0.25),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  )),
                            ),
                          )),
                )),
          ])),
    );
  }
}
