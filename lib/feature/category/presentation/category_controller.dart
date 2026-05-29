import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/mixin/controller_mixins.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/string_utils.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';

import '../../../core/utils/app_toast.dart';
import '../domain/usecases/category_usecase.dart';

class CategoryController extends GetxController
    with
        PaginationMixin<CategoryEntity>,
        OptimisticDeleteMixin<CategoryEntity, int>,
        DialogButtonMixin {
  final CategoryUseCase _useCase;

  CategoryController(this._useCase);

  @override
  RxList<CategoryEntity> get items => listCategory;

  @override
  Future<bool> deleteItemById(int id) async {
    final result = await _useCase.delete(id);
    return result.data;
  }

  @override
  int getIdFromItem(CategoryEntity item) => item.id;

  final RxList<CategoryEntity> listCategory = <CategoryEntity>[].obs;
  final RxList<CategoryEntity> filteredCategory = <CategoryEntity>[].obs;

  final RxString addCategoryText = ''.obs;
  final RxString updateCategoryText = ''.obs;
  final RxString searchCategoryText = ''.obs;
  final TextEditingController addController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController updateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchFirstPage();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    updateController.dispose();
    addController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchFirstPage() async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMore = true;
      final result = await _useCase(page: page.value, limit: limit.value);
      listCategory.assignAll(result);
      _syncFiltered();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
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
        final existingIds = listCategory.map((e) => e.id).toSet();
        final newItems = result
            .where((item) => !existingIds.contains(item.id))
            .toList();
        if (newItems.isEmpty) {
          page.value -= 1;
          hasMore = false;
        } else {
          listCategory.addAll(newItems);
          _syncFiltered();
          if (result.length < limit.value) hasMore = false;
        }
      }
    } catch (e) {
      if (page.value > 1) page.value -= 1;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void _onSearchChanged() => searchLocal(searchController.text);

  void _syncFiltered() => searchLocal(searchCategoryText.value);

  void searchLocal(String query) {
    searchCategoryText.value = query;
    if (query.trim().isEmpty) {
      filteredCategory.assignAll(listCategory);
    } else {
      filteredCategory.assignAll(
        listCategory.where(
          (item) => StringUtils.containsIgnoreAccents(item.name, query.trim()),
        ),
      );
    }
  }

  Future<void> addCategory() async {
    try {
      final name = addCategoryText.value.trim();
      await _useCase.add(CategoryAddParams(name: name));
      AppToast.showSuccess(title: 'add_success'.tr);
      addCategoryText.value = '';
      addController.clear();
      fetchFirstPage();
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(title: 'add_failed'.tr, message: errorMessage.value);
    }
  }

  Future<void> updateCategory(int id) async {
    int? optimisticIndex;
    CategoryEntity? originalCategory;
    try {
      final name = updateCategoryText.value.trim();
      final index = listCategory.indexWhere((category) => category.id == id);
      if (index == -1) return;
      optimisticIndex = index;
      originalCategory = listCategory[index];
      listCategory[index] = originalCategory.copyWith(name: name);
      listCategory.refresh();

      final result = await _useCase.update(UpdateCategoryParam(name: name), id);
      if (result.data) {
        AppToast.showSuccess(title: 'update_success'.tr);
      } else {
        listCategory[index] = originalCategory;
        listCategory.refresh();
        AppToast.showError(title: 'update_failed'.tr, message: '');
      }
      updateCategoryText.value = '';
      updateController.clear();
    } catch (e) {
      if (optimisticIndex != null && originalCategory != null) {
        listCategory[optimisticIndex] = originalCategory;
        listCategory.refresh();
      }
      errorMessage.value = e.toString();
      AppToast.showError(
        title: 'update_failed'.tr,
        message: errorMessage.value,
      );
    }
  }

  /// Gọi OptimisticDeleteMixin.deleteItem, nhưng với tên rõ nghĩa hơn
  Future<void> deleteCategory(int id) => deleteItem(id);

  void showDeleteDialog(CategoryEntity item) {
    showDeleteConfirmDialog(
      contentKey: 'delete_category_confirm',
      onConfirm: () => deleteCategory(item.id),
    );
  }

  void showEditDialog(CategoryEntity item) {
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: _buildCategoryNameInput(
        theme: theme,
        controller: updateController,
        onChanged: (value) => updateCategoryText.value = value,
      ),
      title: 'update_category'.tr,
      footer: dialogButton(
        theme,
        title: 'save'.tr,
        verticalPadding: 4,
        onTap: () {
          Get.back();
          updateCategory(item.id);
        },
      ),
    );
  }

  void showAddDialog() {
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: _buildCategoryNameInput(
        theme: theme,
        controller: addController,
        onChanged: (value) => addCategoryText.value = value,
      ),
      title: 'add_category'.tr,
      footer: dialogButton(
        theme,
        title: 'save'.tr,
        verticalPadding: 4,
        onTap: () {
          Get.back();
          addCategory();
        },
      ),
    );
  }

  Widget _buildCategoryNameInput({
    required ThemeData theme,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'category_name'.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'category_name'.tr,
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
