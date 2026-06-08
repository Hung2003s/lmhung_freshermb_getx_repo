import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../enum/locale_keys.dart';
import '../dialog/dialog_x.dart';
import '../../utils/app_toast.dart';

/// [OptimisticDeleteMixin] — Xoá item với optimistic update (rollback nếu API fail)
mixin OptimisticDeleteMixin<T, id> on GetxController {
  RxList<T> get items;
  RxString get errorMessage;

  /// Gọi API xoá thật sự, trả về `true` nếu thành công
  Future<bool> deleteItemById(id id);

  /// Lấy [id] từ item
  id getIdFromItem(T item);

  String get successMessage => LocaleKeys.deleteSuccess.tr;
  String get failMessage => LocaleKeys.deleteFailed.tr;

  /// Xoá item
  Future<void> deleteItem(id id) async {
    int? idx;
    T? original;
    try {
      idx = items.indexWhere((item) => getIdFromItem(item) == id);
      if (idx == -1) return;

      original = items[idx];
      items.removeAt(idx);
      items.refresh();

      final success = await deleteItemById(id);
      if (success) {
        AppToast.showSuccess(title: successMessage);
      } else {
        if (original != null) _rollback(idx, original);
        AppToast.showError(title: failMessage, message: '');
      }
    } catch (e) {
      if (idx != null && original != null) _rollback(idx, original);
      errorMessage.value = e.toString();
      AppToast.showError(title: failMessage, message: errorMessage.value);
    }
  }

  void _rollback(int index, T item) {
    if (index < items.length) {
      items[index] = item;
    } else {
      items.add(item);
    }
    items.refresh();
  }
}

/// [PaginationMixin] — Hỗ trợ phân trang + scroll load more
///
/// Dùng trong các controller có danh sách cần load phân trang (CategoryController, ProductController...)
mixin PaginationMixin<T> on GetxController {
  RxInt page = 1.obs;
  RxInt limit = 20.obs;
  bool hasMore = true;

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxString errorMessage = ''.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  Future<void> fetchFirstPage();
  Future<void> loadMore();
}

/// [DialogButtonMixin] — Button + dialog xác nhận xoá
mixin DialogButtonMixin on GetxController {
  Widget dialogButton(
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

  /// Dialog xác nhận xoá — dùng chung cho cả category & product
  void showDeleteConfirmDialog({
    required LocaleKeys contentKey,
    required VoidCallback onConfirm,
  }) {
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contentKey.tr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          dialogButton(
            theme,
            title: LocaleKeys.cancel.tr,
            onTap: () => Get.back(),
          ),
          const SizedBox(width: 12),
          dialogButton(
            theme,
            title: LocaleKeys.confirm.tr,
            onTap: () {
              Get.back();
              onConfirm();
            },
          ),
        ],
      ),
      title: '',
    );
  }
}
