import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../../giftcard/sell/widgets/inset_dropdown_field.dart';

class BillProviderDropdown<T> extends StatelessWidget {
  const BillProviderDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.labelFor,
    required this.onChanged,
    required this.icon,
    required this.hint,
    required this.fieldKey,
    this.asset,
  });

  final T value;
  final List<T> options;
  final String Function(T) labelFor;
  final ValueChanged<T> onChanged;
  final IconData icon;
  final String hint;
  final Key fieldKey;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return InsetDropdownField<T>(
      value: value,
      fieldKey: fieldKey,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.lightIconBorder),
        ),
      ),
      selectedChild: _label(value),
      onChanged: onChanged,
      items: options
          .map((option) => PopupMenuItem<T>(
                key: ValueKey('provider-option-${labelFor(option)}'),
                value: option,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Expanded(child: _label(option)),
                  if (option == value) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.check_rounded,
                        color: AppColors.primary, size: 20),
                  ],
                ]),
              ))
          .toList(),
    );
  }

  Widget _label(T option) => Row(children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8)),
          child: asset == null
              ? Icon(icon, color: AppColors.primary, size: 19)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(asset!,
                      fit: BoxFit.cover, excludeFromSemantics: true),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Text(labelFor(option),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500))),
      ]);
}
