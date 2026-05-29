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
      'growing_percent': '+12%',

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
      'products_count': '@s sản phẩm',

      // Product Page
      'products': 'Sản phẩm',
      'in_stock': 'Còn hàng',
      'delete_product_confirm': 'Bạn có chắc chắn muốn xóa sản phẩm này?',
      'sort_filter': 'Sắp xếp & Lọc',
      'showing_products': 'Hiển thị @s sản phẩm',
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
      'delete_success': 'Xoá thành công',
      'delete_failed': 'Xoá thất bại',
      'login_success': 'Đăng nhập thành công',
      'login_failed': 'Đăng nhập thất bại',
      'register_success': 'Đăng ký thành công',
      'register_failed': 'Đăng ký thất bại',
      'invalid_credentials': 'Vui lòng nhập thông tin đăng nhập.',
      'login_locked':
          'Tài khoản đã bị khóa tạm thời. Vui lòng thử lại sau @s giây.',
      'login_attempts_left': 'Còn @s lần đăng nhập trước khi bị khóa.',
      // Auth Validation
      'username_required': 'Vui lòng nhập tài khoản',
      'username_min_length': 'Tài khoản phải có ít nhất 3 ký tự',
      'username_max_length': 'Tài khoản không được quá 50 ký tự',
      'password_required': 'Vui lòng nhập mật khẩu',
      'password_min_length': 'Mật khẩu phải có ít nhất 6 ký tự',
      'password_max_length': 'Mật khẩu không được quá 100 ký tự',
      'login_locked_button': 'Đã khóa',
      'no_products_in_category': 'Không tìm thấy sản phẩm nào của danh mục này',
      'error_title': 'Lỗi',
      'logout_failed': 'Đăng xuất thất bại',

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
      'logout': 'Đăng xuất',
      'logout_confirm': 'Bạn có chắc chắn muốn đăng xuất?',
      // Search
      'search_hint': 'Tìm kiếm...',

      // Auth - Login
      'welcome_back': 'Chào mừng trở lại',
      'login_description': 'Đăng nhập để quản lý kho của bạn',
      'username': 'Tài khoản',
      'password': 'Mật khẩu',
      'forgot_password': 'Quên mật khẩu?',
      'login': 'Đăng nhập',
      'no_account': 'Chưa có tài khoản?',
      'register': 'Đăng ký',
      'or_login_with': 'Hoặc đăng nhập với',
      'help': 'Trợ giúp',
      'need_help': 'Cần trợ giúp?',
      'contact_support': 'Liên hệ hỗ trợ',

      // Auth - Register
      'register_title': 'Đăng ký tài khoản',
      'or_register_with': 'Hoặc đăng ký với',
      'session_expired': 'Phiên đăng nhập đã hết hạn',
      'pls_login_again': 'Vui lòng đăng nhập lại',

      // Biometric Authentication
      'biometric': 'Sinh trắc học',
      'face_id': 'Face ID',
      'fingerprint': 'Vân tay',
      'biometric_not_enrolled': 'Thiết bị chưa đăng ký sinh trắc học',
      'biometric_locked_out': 'Xác thực sinh trắc học đã bị khóa',
      'biometric_canceled': 'Đã hủy xác thực sinh trắc học',
      'biometric_error': 'Lỗi xác thực sinh trắc học',
      'biometric_login': 'Đăng nhập bằng @s',
      'biometric_login_reason': 'Xác thực để đăng nhập bằng thông tin đã lưu',
      'biometric_login_failed': 'Đăng nhập vân tay thất bại',
      'biometric_login_failed_credentials':
          'Thông tin đã lưu không hợp lệ. Vui lòng đăng nhập thủ công.',
      'biometric_save_reason': 'Xác thực để bật đăng nhập sinh trắc học',
      'biometric_enable_failed': 'Bật sinh trắc học thất bại',
      'biometric_enable_from_login':
          'Vui lòng đăng nhập trước khi bật sinh trắc học',
      'biometric_enabled': 'Đã bật đăng nhập sinh trắc học',
      'biometric_disabled': 'Đã tắt đăng nhập sinh trắc học',
      'biometric_enabled_desc': 'Đăng nhập bằng vân tay/khuôn mặt',
      'biometric_disabled_desc': 'Không sử dụng đăng nhập sinh trắc học',
      'biometric_changed_warning':
          'Phát hiện dữ liệu sinh trắc học trên thiết bị đã thay đổi. Để bảo mật, vui lòng đăng nhập bằng mật khẩu.',
      'biometric_changed_acknowledged':
          'Đã xác nhận trạng thái sinh trắc học mới. Bạn có thể sử dụng đăng nhập sinh trắc học.',
      'security': 'Bảo mật',
      'enable': 'Bật',
      'disable': 'Tắt',

      // Empty States
      'no_categories_found': 'Không tìm thấy danh mục',
      'try_adding_category': 'Hãy thử thêm một danh mục mới',
      'no_products_found': 'Không tìm thấy sản phẩm',
      'try_adding_product': 'Hãy thử thêm một sản phẩm mới',
      'retry': 'Thử lại',

      // Barcode Scan
      'barcode_scan': 'Quét mã vạch',
      'scan_with_camera': 'Quét bằng camera',
      'clear_all': 'Xoá tất cả',
      'scanning_status': 'Trạng thái quét',
      'scanned_count': 'Đã quét: @count sản phẩm',
      'scanning': 'Đang quét',
      'last_scanned': 'Mã cuối: @code',
      'scan_barcode_to_start': 'Quét mã vạch để bắt đầu',
      'added_product': 'Đã thêm @name',
      'product_already_selected': 'Sản phẩm đã được chọn',
      'scan_error': 'Lỗi quét',

      // Language names
      'vietnamese': 'Tiếng Việt',
      'english': 'English',

      // Quick actions
      'group': 'Nhóm',
    },
  };
}
