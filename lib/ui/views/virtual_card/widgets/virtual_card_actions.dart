import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class VirtualCardActions extends StatelessWidget {
  const VirtualCardActions(
      {super.key,
      required this.onSend,
      required this.onReceive,
      required this.onAdd,
      required this.onClose});

  final VoidCallback onSend;
  final VoidCallback onReceive;
  final VoidCallback onAdd;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(children: [
        Expanded(
            child: _Action(
                label: 'Send', icon: Icons.send_outlined, onTap: onSend)),
        const SizedBox(width: 8),
        Expanded(
            child: _Action(
                label: 'Receive', icon: Icons.south_rounded, onTap: onReceive)),
        const SizedBox(width: 8),
        Expanded(
            child:
                _Action(label: 'Add', icon: Icons.add_rounded, onTap: onAdd)),
        const SizedBox(width: 8),
        SizedBox(
            width: 40,
            height: 40,
            child: PopupMenuButton<String>(
              tooltip: 'More options',
              padding: EdgeInsets.zero,
              color: AppColors.white,
              surfaceTintColor: AppColors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              icon: const Icon(Icons.more_horiz,
                  color: AppColors.white, size: 22),
              style: IconButton.styleFrom(
                  side: BorderSide(
                      color: AppColors.white.withValues(alpha: 0.20)),
                  shape: const CircleBorder()),
              onSelected: (_) => onClose(),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'close', child: Text('Back to Home'))
              ],
            )),
      ]),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            side: BorderSide(color: AppColors.white.withValues(alpha: 0.20)),
            shape: const StadiumBorder(),
          ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.30))),
                    child: Icon(icon, size: 14)),
                const SizedBox(width: 6),
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500)),
              ])),
        ));
  }
}
