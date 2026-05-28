import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/string_utils.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';

import '../../../core/utils/app_toast.dart';
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
  final RxString searchCategoryText = ''.obs;
  final TextEditingController addController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController updateController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final RxList<CategoryEntity> listCategory = <CategoryEntity>[].obs;
  final RxList<CategoryEntity> filteredCategory = <CategoryEntity>[].obs;

  @override
  void onInit() {
    getListCategory();
    searchController.addListener(_onSearchChanged);
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    searchLocal(searchController.text);
  }

  void _onScroll() {
    if (!hasMore || isLoadingMore.value) return;
    if (scrollController.position.maxScrollExtent <= 0) return;
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  void _syncFiltered() {
    searchLocal(searchCategoryText.value);
  }

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

  Future<void> getListCategory() async {
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
      AppToast.showSuccess(title: 'add_success'.tr);
      addCategoryText.value = '';
      addController.clear();
      getListCategory();
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
      final newCategory = originalCategory.copyWith(name: name);
      listCategory[index] = newCategory;
      listCategory.refresh();
      final param = UpdateCategoryParam(name: name);
      final result = await _useCase.update(param, id);
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

  Future<void> deleteCategory(int id) async {
    int? optimisticIndex;
    CategoryEntity? originalCategory;
    try {
      final index = listCategory.indexWhere((category) => category.id == id);
      if (index == -1) return;
      optimisticIndex = index;
      originalCategory = listCategory[index];
      listCategory.removeAt(index);
      listCategory.refresh();
      final result = await _useCase.delete(id);
      if (result.data) {
        AppToast.showSuccess(title: 'delete_success'.tr);
      } else {
        listCategory.insert(index, originalCategory);
        listCategory.refresh();
        AppToast.showError(title: 'delete_failed'.tr, message: '');
      }
    } catch (e) {
      if (optimisticIndex != null && originalCategory != null) {
        listCategory.insert(optimisticIndex, originalCategory);
        listCategory.refresh();
      }
      errorMessage.value = e.toString();
      AppToast.showError(
        title: 'delete_failed'.tr,
        message: errorMessage.value,
      );
    }
  }

  // ──────────────── Dialog Actions (moved from category_page.dart) ────────────────

  void showDeleteDialog(CategoryEntity item) {
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: _buildDeleteContent(theme),
      footer: _buildDeleteFooter(theme, item),
      title: '',
    );
  }

  Widget _buildDeleteContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'delete_category_confirm'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteFooter(ThemeData theme, CategoryEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _dialogButton(theme, title: 'cancel'.tr, onTap: () => Get.back()),
        const SizedBox(width: 12),
        _dialogButton(
          theme,
          title: 'confirm'.tr,
          onTap: () {
            Get.back();
            deleteCategory(item.id);
          },
        ),
      ],
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
      footer: _dialogButton(
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
      footer: _dialogButton(
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

  Widget _dialogButton(
    ThemeData theme, {
    required String title,
    required VoidCallback onTap,
    double verticalPadding = 8,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
