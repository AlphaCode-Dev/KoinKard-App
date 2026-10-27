import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

import '../sell_giftcard_viewmodel.dart';
import 'sell_giftcard_card_selector.dart';
import 'inset_dropdown_field.dart';

class SellGiftcardForm extends StatelessWidget {
  const SellGiftcardForm({super.key, required this.viewModel});

  final SellGiftcardViewModel viewModel;

  InputDecoration _decoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        hintStyle: AppTextStyles.paragraphMedium
            .copyWith(color: AppColors.greetingText),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.rateTileBorder),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final model = viewModel;
    return AbsorbPointer(
      absorbing: model.isSubmitting,
      child: Form(
        key: model.formKey,
        autovalidateMode: model.hasAttemptedSubmit
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellGiftcardCardSelector(
              value: model.selectedBrand,
              brands: model.availableBrands,
              decoration: _decoration('Choose Card'),
              onChanged: model.selectBrand,
            ),
            const SizedBox(height: 12),
            InsetDropdownField<int>(
              key: ValueKey('subcategory-${model.selectedBrand}'),
              fieldKey: const ValueKey('subcategory-selector-field'),
              value: model.selectedProductId,
              decoration: _decoration(model.isLoadingProducts
                  ? 'Loading Subcategories...'
                  : 'Choose Subcategory'),
              selectedChild: Text(
                model.selectedProduct?.countryLabel ??
                    (model.isLoadingProducts
                        ? 'Loading Subcategories...'
                        : 'Choose Subcategory'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: model.selectedProduct == null
                    ? AppTextStyles.paragraphMedium
                        .copyWith(color: AppColors.greetingText)
                    : null,
              ),
              items: model.productsForSelectedBrand
                  .map((product) => PopupMenuItem<int>(
                        key: ValueKey('subcategory-option-${product.id}'),
                        value: product.id,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(product.countryLabel,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: model.isLoadingProducts ||
                      model.productsForSelectedBrand.isEmpty
                  ? null
                  : model.selectSubcategory,
              validator: (_) => model.selectedProduct == null
                  ? 'Choose an available subcategory.'
                  : null,
            ),
            if (model.isLoadingProducts) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(color: AppColors.primary),
            ] else if (model.loadError != null ||
                model.productsForSelectedBrand.isEmpty) ...[
              const SizedBox(height: 8),
              Text(
                  model.loadError ??
                      'No subcategories are available for this card yet.',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.balanceLabel)),
              TextButton(
                  onPressed: model.initialise, child: const Text('Retry')),
            ],
            const SizedBox(height: 26),
            _label('Balance'),
            const SizedBox(height: 12),
            TextFormField(
              controller: model.amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) =>
                    RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                        ? newValue
                        : oldValue)
              ],
              decoration: _decoration('Enter Card Value').copyWith(
                prefixIcon: Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.lightGradientMiddle,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(18)),
                  ),
                  child: Text(model.selectedProduct?.countryLabel ?? '--',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.paragraphMediumBold
                          .copyWith(color: AppColors.balanceLabel)),
                ),
              ),
              onChanged: model.onFieldChanged,
              validator: model.validateAmount,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (final amount in [25, 50, 100, 200, 500])
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: amount == 500 ? 0 : 8),
                      child: Material(
                        color: model.enteredAmount == amount
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : AppColors.lightGradientBottom,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => model.setAmount(amount),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('$amount',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMedium
                                    .copyWith(color: AppColors.balanceLabel)),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            _label('Card Code'),
            const SizedBox(height: 8),
            TextFormField(
              controller: model.codeController,
              autocorrect: false,
              enableSuggestions: false,
              decoration: _decoration('Enter Card Code'),
              onChanged: model.onFieldChanged,
              validator: model.validateCode,
            ),
            const SizedBox(height: 18),
            Material(
              color: AppColors.lightGradientBottom,
              borderRadius: BorderRadius.circular(18),
              child: ListTile(
                title: Text('Coupon',
                    style: AppTextStyles.paragraphMedium
                        .copyWith(color: AppColors.balanceLabel)),
                trailing: Icon(model.couponExpanded
                    ? Icons.expand_less
                    : Icons.chevron_right),
                onTap: model.toggleCoupon,
              ),
            ),
            if (model.couponExpanded) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: model.couponController,
                decoration: _decoration('Enter Coupon').copyWith(
                  helperText: 'Coupon redemption is not available yet.',
                  helperMaxLines: 2,
                ),
              ),
            ],
            const SizedBox(height: 22),
            _label('Upload Image(s)'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (var index = 0; index < model.images.length; index++)
                  SizedBox(
                    width: 88,
                    height: 88,
                    child: Stack(fit: StackFit.expand, children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(model.images[index],
                              fit: BoxFit.cover)),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton.filled(
                            onPressed: () => model.removeImage(index),
                            tooltip: 'Remove image',
                            icon: const Icon(Icons.close, size: 16),
                          )),
                    ]),
                  ),
                SizedBox(
                  width: 88,
                  height: 88,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.rateTileBorder),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: model.isPickingImages ? null : model.pickImages,
                    child: model.isPickingImages
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.add,
                            size: 32,
                            color: AppColors.primary,
                            semanticLabel: 'Add card images'),
                  ),
                ),
              ],
            ),
            if (model.images.isNotEmpty || model.imageError != null) ...[
              const SizedBox(height: 8),
              Text(
                  model.imageError ??
                      'Preview only. Image uploads are not available yet.',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.balanceLabel)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: AppTextStyles.paragraphSmall.copyWith(color: AppColors.darkText));
}
