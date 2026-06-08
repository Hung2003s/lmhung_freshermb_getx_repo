import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/mixin/controller_mixins.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/string_utils.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/get_categories_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/add_category_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/update_category_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/delete_category_use_case.dart';

import '../../../core/utils/app_toast.dart';
import '../domain/params/add_category_params.dart';
import '../domain/params/update_category_params.dart';
import 'widget/category_dialogs.dart';

class CategoryController extends GetxController
    with
        PaginationMixin<CategoryEntity>,
        OptimisticDeleteMixin<CategoryEntity, int>,
        DialogButtonMixin {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final AddCategoryUseCase _addCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  CategoryController(
    this._getCategoriesUseCase,
    this._addCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
  );

  @override
  RxList<CategoryEntity> get items => listCategory;

  @override
  Future<bool> deleteItemById(int id) async {
    final result = await _deleteCategoryUseCase(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
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

  /// Pull-to-refresh: bỏ qua cache, lấy dữ liệu mới từ server.
  Future<void> forceRefresh() => _fetchPage(forceRefresh: true);

  @override
  Future<void> fetchFirstPage() => _fetchPage();

  Future<void> _fetchPage({bool forceRefresh = false}) async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMore = true;
      final result = await _getCategoriesUseCase(
        page: page.value,
        limit: limit.value,
        forceRefresh: forceRefresh,
      );
      final categories = result.fold(
        (failure) => throw Exception(failure.message),
        (list) => list,
      );
      listCategory.assignAll(categories);
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
      final result = await _getCategoriesUseCase(
        page: page.value,
        limit: limit.value,
      );
      final categories = result.fold(
        (failure) => throw Exception(failure.message),
        (list) => list,
      );
      if (categories.isEmpty) {
        page.value -= 1;
        hasMore = false;
      } else {
        final existingIds = listCategory.map((e) => e.id).toSet();
        final newItems = categories
            .where((item) => !existingIds.contains(item.id))
            .toList();
        if (newItems.isEmpty) {
          page.value -= 1;
          hasMore = false;
        } else {
          listCategory.addAll(newItems);
          _syncFiltered();
          if (categories.length < limit.value) hasMore = false;
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
      final result = await _addCategoryUseCase(AddCategoryParams(name: name));
      result.fold((failure) => throw Exception(failure.message), (id) => id);
      AppToast.showSuccess(title: LocaleKeys.addSuccess.tr);
      addCategoryText.value = '';
      addController.clear();
      fetchFirstPage();
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(
        title: LocaleKeys.addFailed.tr,
        message: errorMessage.value,
      );
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

      final result = await _updateCategoryUseCase(
        UpdateCategoryParams(name: name),
        id,
      );
      final success = result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
      );
      if (success) {
        AppToast.showSuccess(title: LocaleKeys.updateSuccess.tr);
      } else {
        listCategory[index] = originalCategory;
        listCategory.refresh();
        AppToast.showError(title: LocaleKeys.updateFailed.tr, message: '');
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
        title: LocaleKeys.updateFailed.tr,
        message: errorMessage.value,
      );
    }
  }

  /// Gọi OptimisticDeleteMixin.deleteItem
  Future<void> deleteCategory(int id) => deleteItem(id);

  void showDeleteDialog(CategoryEntity item) {
    showDeleteConfirmDialog(
      contentKey: LocaleKeys.deleteCategoryConfirm,
      onConfirm: () => deleteCategory(item.id),
    );
  }

  /// Hiển thị dialog edit (UI tách ra widget riêng)
  void showEditDialog(CategoryEntity item) {
    showEditCategoryDialog(this, item);
  }

  /// Hiển thị dialog add (UI tách ra widget riêng)
  void showAddDialog() {
    showAddCategoryDialog(this);
  }
}
