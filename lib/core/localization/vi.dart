import 'package:get/get.dart';

class Vi extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'vi_VN': {
          // Dashboard
          'app_title': 'Quản lý kho',

          // Profile AppBar
          'greeting_morning': 'Chào buổi sáng,',
          'greeting_afternoon': 'Chào buổi chiều,',
          'greeting_evening': 'Chào buổi tối,',

          // Home Page
          'warehouse_overview': 'Tổng quan kho',
          'updated_at': 'Cập nhật lúc: 08:30 AM, 24/10/2023',
          'quick_actions': 'Lối tắt nhanh',
          'add_product': 'Thêm sản phẩm',
          'add_category': 'Thêm danh mục',
          'category_name': 'Tên danh mục',
          'save': 'Lưu',
          'total_products': 'Tổng sản phẩm',

          // Category Page
          'manage': 'Quản lý',
          'category': 'Danh mục',
          'search_category': 'Tìm kiếm danh mục',
          'growing': 'tăng trưởng',
          'delete_category_confirm': 'Bạn có chắc chắn muốn xóa danh mục này?',
          'cancel': 'Hủy',
          'confirm': 'Xác nhận',
          'update_category': 'Cập nhật danh mục',
          'edit': 'Sửa',
          'delete': 'Xoá',
          'products_count': '%s sản phẩm',

          // Product Page
          'products': 'Sản phẩm',
          'in_stock': 'Còn hàng',
          'delete_product_confirm': 'Bạn có chắc chắn muốn xóa sản phẩm này?',
          'sort_filter': 'Sắp xếp & Lọc',
          'showing_products': 'Hiển thị %s sản phẩm',
          'newest': 'Mới nhất',
          'all_categories': 'Tất cả danh mục',
          'select_category': 'Chọn danh mục',
          'all': 'Tất cả',

          // Product Info Page
          'add_new_product': 'Thêm sản phẩm',
          'edit_product': 'Sửa sản phẩm',
          'product_details': 'Chi tiết sản phẩm',
          'product_image': 'Ảnh sản phẩm',
          'add_image': 'Thêm ảnh',
          'enter_product_name': 'Nhập tên sản phẩm',
          'product_name': 'Tên sản phẩm',
          'product_category': 'Danh mục sản phẩm',
          'sku_example': 'VD: SP-001',
          'sku_code': 'SKU/Mã SP',
          'price_hint': 'Giá tiền',
          'selling_price': 'Giá bán',
          'stock_example': 'VD: 100',
          'quantity': 'Số lượng',
          'product_description_hint': 'Mô tả sản phẩm',
          'description': 'Mô tả',
          'create_new_product': 'Tạo sản phẩm mới',
          'save_changes': 'Lưu thay đổi',

          // Validation Messages
          'name_required': 'Tên bắt buộc',
          'code_required': 'Mã bắt buộc',
          'code_exists': 'Mã sản phẩm đã tồn tại',
          'price_required': 'Giá bắt buộc',
          'price_invalid': 'Giá không hợp lệ',
          'price_positive': 'Giá phải lớn hơn 0',
          'stock_invalid': 'Tồn kho không hợp lệ',
          'stock_non_negative': 'Tồn kho phải lớn hơn hoặc bằng 0',
          'category_required': 'Danh mục bắt buộc',
          'category_invalid': 'Danh mục không hợp lệ',

          // Snackbar Messages
          'add_success': 'Thêm thành công',
          'add_failed': 'Thêm thất bại',
          'update_success': 'Cập nhật thành công',
          'update_failed': 'Cập nhật thất bại',

          // Sort Options
          'sort_name_asc': 'Tên: A -> Z',
          'sort_name_desc': 'Tên: Z -> A',
          'sort_price_desc': 'Giá: Cao -> Thấp',
          'sort_price_asc': 'Giá: Thấp -> Cao',
          'sort_stock_asc': 'Số lượng: Thấp -> Cao',
          'sort_stock_desc': 'Số lượng: Cao -> Thấp',

          // Settings
          'settings_title': 'Cài đặt',
          'theme': 'Giao diện',
          'language': 'Ngôn ngữ',
          'system_mode': 'Hệ thống',
          'system_mode_desc': 'Tự động theo thiết bị',
          'light_mode': 'Sáng',
          'light_mode_desc': 'Luôn sử dụng giao diện sáng',
          'dark_mode': 'Tối',
          'dark_mode_desc': 'Luôn sử dụng giao diện tối',

          // Search
          'search_hint': 'Tìm kiếm...',
        },
      };
}