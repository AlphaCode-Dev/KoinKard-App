import 'package:flutter/material.dart';

class RecentTransaction {
  const RecentTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.isCredit,
    required this.accentColor,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final bool isCredit;
  final Color accentColor;
  final IconData icon;
}
