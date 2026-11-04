import 'dart:async';
import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../../home/widgets/home_top_background.dart';

class VirtualCardBenefitsCarousel extends StatefulWidget {
  const VirtualCardBenefitsCarousel({super.key});

  @override
  State<VirtualCardBenefitsCarousel> createState() =>
      _VirtualCardBenefitsCarouselState();
}

class _VirtualCardBenefitsCarouselState
    extends State<VirtualCardBenefitsCarousel> with WidgetsBindingObserver {
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
  Timer? _timer;
  bool _foreground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startAutoplay();
  }

  @override
  void reassemble() {
    super.reassemble();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_controller.hasClients) {
        final currentSlide = (_controller.page ?? 0).round() % _slides.length;
        _controller.jumpToPage(currentSlide);
      }
      _startAutoplay();
    });
  }

  void _startAutoplay() {
    _timer?.cancel();
    if (!_foreground ||
        MediaQuery.disableAnimationsOf(context) ||
        !TickerMode.valuesOf(context).enabled) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted ||
          !_controller.hasClients ||
          !(ModalRoute.of(context)?.isCurrent ?? true) ||
          _controller.position.isScrollingNotifier.value) {
        return;
      }
      _controller.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    _startAutoplay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: HomeTopBackground(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: double.infinity,
          height: 56 + MediaQuery.textScalerOf(context).scale(32),
          child: SafeArea(
              top: false,
              bottom: false,
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (_, index) {
                  final slide = _slides[index % _slides.length];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                    child: Row(children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(slide.icon,
                              color: AppColors.primary, size: 23)),
                      const SizedBox(width: 14),
                      Expanded(
                          child: Text(slide.text,
                              style: const TextStyle(
                                  color: AppColors.darkText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4))),
                    ]),
                  );
                },
              )),
        ),
      ),
    );
  }
}
