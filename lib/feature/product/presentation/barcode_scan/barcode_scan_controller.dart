import 'dart:async';

import 'package:barcode_scanner_plugin/barcode_scanner_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/app_toast.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';

import '../widget/product_info_bottom_sheet.dart';

class BarcodeScanController extends GetxController {
  final BarcodeScannerPlugin _scannerPlugin = BarcodeScannerPlugin();

  final RxList<ProductEntity> selectedProducts = <ProductEntity>[].obs;
  final RxBool isScanning = false.obs;
  final RxString lastScannedCode = ''.obs;

  StreamSubscription<String>? _barcodeSubscription;

  @override
  void onInit() {
    super.onInit();
    _startListeningBarcodeStream();
  }

  void _startListeningBarcodeStream() {
    _barcodeSubscription = _scannerPlugin.barcodeStream.listen(
      (barcode) {
        if (barcode.isNotEmpty) {
          handleScannedBarcode(barcode);
        }
      },
      onError: (error) {
        debugPrint('Barcode stream error: $error');
      },
    );
  }

  Future<void> handleScannedBarcode(String barcode) async {
    if (barcode.isEmpty) return;

    lastScannedCode.value = barcode;

    // Tìm sản phẩm trong danh sách hiện tại theo mã code
    final productController = Get.find<ProductController>();
    final existingProduct = productController.listProduct.firstWhereOrNull(
      (product) => product.code?.toLowerCase() == barcode.toLowerCase(),
    );

    if (existingProduct != null) {
      // Nếu mã vạch trùng với code sản phẩm -> thêm vào danh sách đã chọn
      final alreadySelected = selectedProducts.any(
        (p) => p.id == existingProduct.id,
      );
      if (!alreadySelected) {
        selectedProducts.add(existingProduct);
        AppToast.showSuccess(
          title: LocaleKeys.addedProduct.trParams({
            'name': existingProduct.name,
          }),
        );
      } else {
        AppToast.showInfo(
          title: LocaleKeys.productAlreadySelected.tr,
          message: '',
        );
      }
    } else {
      // Nếu là mã vạch mới -> mở bottom sheet thêm sản phẩm với mã vạch đã điền sẵn
      final result = await showProductInfoBottomSheet(
        initialProduct: ProductEntity(
          id: 0,
          name: '',
          code: barcode,
          price: 0.0,
          stock: 0,
        ),
      );
      if (result != null) {
        // Nếu thêm thành công, refresh lại danh sách sản phẩm
        productController.fetchListProduct(isLoadMore: false);
      }
    }
  }

  void removeProduct(int productId) {
    selectedProducts.removeWhere((p) => p.id == productId);
  }

  Future<void> startCameraScan() async {
    try {
      isScanning.value = true;
      final barcode = await _scannerPlugin.startCameraScan();
      if (barcode != null && barcode.isNotEmpty) {
        await handleScannedBarcode(barcode);
      }
    } catch (e) {
      debugPrint('Camera scan error: $e');
      AppToast.showError(title: LocaleKeys.scanError.tr, message: e.toString());
    } finally {
      isScanning.value = false;
    }
  }

  void clearAll() {
    selectedProducts.clear();
    lastScannedCode.value = '';
  }

  @override
  void onClose() {
    _barcodeSubscription?.cancel();
    super.onClose();
  }
}
