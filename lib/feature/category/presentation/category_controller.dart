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
  final RxString errorMessage = ''.obs;

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
      final result = await _useCase();
      listCategory.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCategory() async {
    try {
      final name = addCategoryText.value.trim();
      final param = CategoryAddParams(name: name);
      await _useCase.add(param);
      Get.snackbar(
        'Thêm thành công',
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
        'Thêm thất bại',
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
          'Cập nhật thành công',
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
        );
      } else {
        listCategory[index] = originalCategory;
        listCategory.refresh();
        Get.snackbar(
          'Cập nhật thất bại',
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
        'Cập nhật thất bại',
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
          'Xoá thành công',
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
        );
      } else {
        listCategory.insert(index, originalCategory);
        listCategory.refresh();
        Get.snackbar(
          'Xoá thất bại',
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
      Get.snackbar('Xoá thất bại', errorMessage.value);
    }
  }
}
