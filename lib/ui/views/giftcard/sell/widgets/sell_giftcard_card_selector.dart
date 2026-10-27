import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'inset_dropdown_field.dart';

class SellGiftcardCardSelector extends StatelessWidget {
  const SellGiftcardCardSelector({
    super.key,
    required this.value,
    required this.brands,
    required this.decoration,
    required this.onChanged,
  });

  final String value;
  final List<String> brands;
  final InputDecoration decoration;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return InsetDropdownField<String>(
      value: value,
      fieldKey: const ValueKey('card-selector-field'),
      decoration: decoration,
      selectedChild: _CardLabel(brand: value),
      onChanged: onChanged,
      items: brands
          .map((brand) => PopupMenuItem<String>(
                key: ValueKey('card-option-$brand'),
                value: brand,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _CardLabel(brand: brand),
              ))
          .toList(),
    );
  }
}

class _CardLabel extends StatelessWidget {
  const _CardLabel({required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            AppAssets.popularGiftCard,
            width: 32,
            height: 32,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Text(brand, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
