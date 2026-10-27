import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koinkard/data/models/giftcard/giftcard_product_model.dart';

import '../giftcard_viewmodel.dart';

class SellGiftcardViewModel extends GiftcardViewModel {
  SellGiftcardViewModel({required this.initialBrand}) {
    super.selectBrand(initialBrand);
  }

  final String initialBrand;
  final couponController = TextEditingController();
  final List<Uint8List> images = [];
  int? selectedProductId;
  bool couponExpanded = false;
  bool isPickingImages = false;
  String? imageError;

  List<String> get availableBrands {
    final options = <String, String>{};
    for (final brand in [...cardBrands, ...brands, selectedBrand]) {
      if (brand.isNotEmpty) {
        options.putIfAbsent(GiftcardProductModel.brandKey(brand), () => brand);
      }
    }
    // Keep the exact selected label present for the dropdown's value.
    if (selectedBrand.isNotEmpty) {
      options[GiftcardProductModel.brandKey(selectedBrand)] = selectedBrand;
    }
    return options.values.toList();
  }

  @override
  GiftcardProductModel? get selectedProduct {
    for (final product in productsForSelectedBrand) {
      if (product.id == selectedProductId) return product;
    }
    return null;
  }

  @override
  Future<void> initialise() async {
    await super.initialise();
    if (selectedProduct == null) selectedProductId = null;
    rebuildUi();
  }

  @override
  void selectBrand(String brand) {
    if (brand == selectedBrand) return;
    selectedProductId = null;
    super.selectBrand(brand);
    rebuildUi();
  }

  void selectSubcategory(int? id) {
    selectedProductId =
        productsForSelectedBrand.any((product) => product.id == id) ? id : null;
    rebuildUi();
  }

  void setAmount(int amount) {
    amountController.text = amount.toString();
    rebuildUi();
  }

  void toggleCoupon() {
    couponExpanded = !couponExpanded;
    rebuildUi();
  }

  Future<void> pickImages() async {
    if (isPickingImages) return;
    isPickingImages = true;
    imageError = null;
    rebuildUi();
    try {
      final picked = await ImagePicker().pickMultiImage(
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      final previews =
          await Future.wait(picked.map((file) => file.readAsBytes()));
      images.addAll(previews);
    } on PlatformException {
      imageError =
          'Unable to open your photos. Please check photo permissions.';
    } catch (_) {
      imageError = 'Unable to read the selected images. Please try again.';
    } finally {
      isPickingImages = false;
      rebuildUi();
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
    rebuildUi();
  }

  String? get submissionIssue {
    if (images.isNotEmpty) {
      return 'Image uploads are not available yet. Remove the images and use a card code to continue.';
    }
    if (couponController.text.trim().isNotEmpty) {
      return 'Coupons are not available yet. Remove the coupon to continue.';
    }
    return null;
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }
}
