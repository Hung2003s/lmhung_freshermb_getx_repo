import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../domain/usecases/category_usecase.dart';

class CategoryController extends GetxController {
  final CategoryUseCase _useCase;

  CategoryController(this._useCase);

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt page = 1.obs;
  final RxInt limit = 20.obs;
  bool hasMore = true;

  final RxString addCategoryText = ''.obs;
  final RxString updateCategoryText = ''.obs;
  final TextEditingController addController = TextEditingController();
  final TextEditingController updateController = TextEditingController();

  final RxList<CategoryEntity> listCategory = <CategoryEntity>[].obs;

  @override
  void onInit() {
    getListCategory();
    super.onInit();
  }

  Future<void> getListCategory() async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMore = true;
      final result = await _useCase(page: page.value, limit: limit.value);
      listCategory.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;
    try {
      isLoadingMore.value = true;
      page.value += 1;
      final result = await _useCase(page: page.value, limit: limit.value);
      if (result.isEmpty) {
        page.value -= 1;
        hasMore = false;
      } else {
        // Lọc bỏ các item đã tồn tại để tránh duplicate
        final existingIds = listCategory.map((e) => e.id).toSet();
        final newItems = result.where((item) => !existingIds.contains(item.id)).toList();
        if (newItems.isEmpty) {
          page.value -= 1;
          hasMore = false;
        } else {
          listCategory.addAll(newItems);
          // Nếu API trả về ít hơn limit nghĩa là đã hết dữ liệu
          if (result.length < limit.value) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      if (page.value > 1) {
        page.value -= 1;
      }
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> addCategory() async {
    try {
      final name = addCategoryText.value.trim();
      final param = CategoryAddParams(name: name);
      await _useCase.add(param);
      Get.snackbar(
        'add_success'.tr,
        '',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
      );
      addCategoryText.value = '';
      addController.clear();
      getListCategory(); // Refresh list sau khi thêm
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'add_failed'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: ColorName.error.withValues(alpha: 0.2),
      );
    }
  }

  Future<void> updateCategory(int id) async {
    int? optimisticIndex;
    CategoryEntity? originalCategory;

    try {
      final name = updateCategoryText.value.trim();

      final index = listCategory.indexWhere((category) => category.id == id);
      if (index == -1) {
        return;
      }
      optimisticIndex = index;
      originalCategory = listCategory[index];
      final newCategory = originalCategory.copyWith(name: name);
      listCategory[index] = newCategory;
      listCategory.refresh();

      final param = UpdateCategoryParam(name: name);
      final result = await _useCase.update(param, id);
      if (result.data) {
        Get.snackbar(
          'update_success'.tr,
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
        );
      } else {
        listCategory[index] = originalCategory;
        listCategory.refresh();
        Get.snackbar(
          'update_failed'.tr,
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.error.withValues(alpha: 0.2),
        );
      }
      updateCategoryText.value = '';
      updateController.clear();
    } catch (e) {
      if (optimisticIndex != null && originalCategory != null) {
        listCategory[optimisticIndex] = originalCategory;
        listCategory.refresh();
      }
      errorMessage.value = e.toString();
      Get.snackbar(
        'update_failed'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: ColorName.error.withValues(alpha: 0.2),
      );
    }
  }

  Future<void> deleteCategory(int id) async {
    int? optimisticIndex;
    CategoryEntity? originalCategory;
    try {
      final index = listCategory.indexWhere((category) => category.id == id);
      if (index == -1) {
        return;
      }
      optimisticIndex = index;
      originalCategory = listCategory[index];
      listCategory.removeAt(index);
      listCategory.refresh();
      final result = await _useCase.delete(id);
      if (result.data) {
        Get.snackbar(
          'delete_success'.tr,
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
        );
      } else {
        listCategory.insert(index, originalCategory);
        listCategory.refresh();
        Get.snackbar(
          'delete_failed'.tr,
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.error.withValues(alpha: 0.2),
        );
      }
    } catch (e) {
      if (optimisticIndex != null && originalCategory != null) {
        listCategory.insert(optimisticIndex, originalCategory);
        listCategory.refresh();
      }
      errorMessage.value = e.toString();
      Get.snackbar('delete_failed'.tr, errorMessage.value);
    }
  }
}
