import 'package:get/get.dart';
import 'locale_keys.dart';

class Vi extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': {
      // Dashboard
      LocaleKeys.appTitle.name: 'Quản lý kho',

      // Profile AppBar
      LocaleKeys.greetingMorning.name: 'Chào buổi sáng,',
      LocaleKeys.greetingAfternoon.name: 'Chào buổi chiều,',
      LocaleKeys.greetingEvening.name: 'Chào buổi tối,',

      // Home Page
      LocaleKeys.warehouseOverview.name: 'Tổng quan kho',
      LocaleKeys.updatedAt.name: 'Cập nhật lúc: 08:30 AM, 24/10/2023',
      LocaleKeys.quickActions.name: 'Lối tắt nhanh',
      LocaleKeys.addProduct.name: 'Thêm sản phẩm',
      LocaleKeys.addCategory.name: 'Thêm danh mục',
      LocaleKeys.categoryName.name: 'Tên danh mục',
      LocaleKeys.save.name: 'Lưu',
      LocaleKeys.totalProducts.name: 'Tổng sản phẩm',
      LocaleKeys.growingPercent.name: '+12%',

      // Category Page
      LocaleKeys.manage.name: 'Quản lý',
      LocaleKeys.category.name: 'Danh mục',
      LocaleKeys.searchCategory.name: 'Tìm kiếm danh mục',
      LocaleKeys.growing.name: 'tăng trưởng',
      LocaleKeys.deleteCategoryConfirm.name:
          'Bạn có chắc chắn muốn xóa danh mục này?',
      LocaleKeys.cancel.name: 'Hủy',
      LocaleKeys.confirm.name: 'Xác nhận',
      LocaleKeys.updateCategory.name: 'Cập nhật danh mục',
      LocaleKeys.edit.name: 'Sửa',
      LocaleKeys.delete.name: 'Xoá',
      LocaleKeys.productsCount.name: '@s sản phẩm',

      // Product Page
      LocaleKeys.products.name: 'Sản phẩm',
      LocaleKeys.inStock.name: 'Còn hàng',
      LocaleKeys.deleteProductConfirm.name:
          'Bạn có chắc chắn muốn xóa sản phẩm này?',
      LocaleKeys.sortFilter.name: 'Sắp xếp & Lọc',
      LocaleKeys.showingProducts.name: 'Hiển thị @s sản phẩm',
      LocaleKeys.newest.name: 'Mới nhất',
      LocaleKeys.allCategories.name: 'Tất cả danh mục',
      LocaleKeys.selectCategory.name: 'Chọn danh mục',
      LocaleKeys.all.name: 'Tất cả',

      // Product Info Page
      LocaleKeys.addNewProduct.name: 'Thêm sản phẩm',
      LocaleKeys.editProduct.name: 'Sửa sản phẩm',
      LocaleKeys.productDetails.name: 'Chi tiết sản phẩm',
      LocaleKeys.productImage.name: 'Ảnh sản phẩm',
      LocaleKeys.addImage.name: 'Thêm ảnh',
      LocaleKeys.enterProductName.name: 'Nhập tên sản phẩm',
      LocaleKeys.productName.name: 'Tên sản phẩm',
      LocaleKeys.productCategory.name: 'Danh mục sản phẩm',
      LocaleKeys.skuExample.name: 'VD: SP-001',
      LocaleKeys.skuCode.name: 'SKU/Mã SP',
      LocaleKeys.priceHint.name: 'Giá tiền',
      LocaleKeys.sellingPrice.name: 'Giá bán',
      LocaleKeys.stockExample.name: 'VD: 100',
      LocaleKeys.quantity.name: 'Số lượng',
      LocaleKeys.productDescriptionHint.name: 'Mô tả sản phẩm',
      LocaleKeys.description.name: 'Mô tả',
      LocaleKeys.createNewProduct.name: 'Tạo sản phẩm mới',
      LocaleKeys.saveChanges.name: 'Lưu thay đổi',

      // Validation Messages
      LocaleKeys.nameRequired.name: 'Tên bắt buộc',
      LocaleKeys.codeRequired.name: 'Mã bắt buộc',
      LocaleKeys.codeExists.name: 'Mã sản phẩm đã tồn tại',
      LocaleKeys.priceRequired.name: 'Giá bắt buộc',
      LocaleKeys.priceInvalid.name: 'Giá không hợp lệ',
      LocaleKeys.pricePositive.name: 'Giá phải lớn hơn 0',
      LocaleKeys.stockInvalid.name: 'Tồn kho không hợp lệ',
      LocaleKeys.stockNonNegative.name: 'Tồn kho phải lớn hơn hoặc bằng 0',
      LocaleKeys.categoryRequired.name: 'Danh mục bắt buộc',
      LocaleKeys.categoryInvalid.name: 'Danh mục không hợp lệ',

      // Snackbar Messages
      LocaleKeys.addSuccess.name: 'Thêm thành công',
      LocaleKeys.addFailed.name: 'Thêm thất bại',
      LocaleKeys.updateSuccess.name: 'Cập nhật thành công',
      LocaleKeys.updateFailed.name: 'Cập nhật thất bại',
      LocaleKeys.deleteSuccess.name: 'Xoá thành công',
      LocaleKeys.deleteFailed.name: 'Xoá thất bại',
      LocaleKeys.loginSuccess.name: 'Đăng nhập thành công',
      LocaleKeys.loginFailed.name: 'Đăng nhập thất bại',
      LocaleKeys.registerSuccess.name: 'Đăng ký thành công',
      LocaleKeys.registerFailed.name: 'Đăng ký thất bại',
      LocaleKeys.invalidCredentials.name: 'Vui lòng nhập thông tin đăng nhập.',
      LocaleKeys.loginLocked.name:
          'Tài khoản đã bị khóa tạm thời. Vui lòng thử lại sau @s giây.',
      LocaleKeys.loginAttemptsLeft.name:
          'Còn @s lần đăng nhập trước khi bị khóa.',

      // Auth Validation
      LocaleKeys.usernameRequired.name: 'Vui lòng nhập tài khoản',
      LocaleKeys.usernameMinLength.name: 'Tài khoản phải có ít nhất 3 ký tự',
      LocaleKeys.usernameMaxLength.name: 'Tài khoản không được quá 50 ký tự',
      LocaleKeys.passwordRequired.name: 'Vui lòng nhập mật khẩu',
      LocaleKeys.passwordMinLength.name: 'Mật khẩu phải có ít nhất 6 ký tự',
      LocaleKeys.passwordMaxLength.name: 'Mật khẩu không được quá 100 ký tự',
      LocaleKeys.loginLockedButton.name: 'Đã khóa',
      LocaleKeys.noProductsInCategory.name:
          'Không tìm thấy sản phẩm nào của danh mục này',
      LocaleKeys.errorTitle.name: 'Lỗi',
      LocaleKeys.logoutFailed.name: 'Đăng xuất thất bại',

      // Sort Options
      LocaleKeys.sortNameAsc.name: 'Tên: A -> Z',
      LocaleKeys.sortNameDesc.name: 'Tên: Z -> A',
      LocaleKeys.sortPriceDesc.name: 'Giá: Cao -> Thấp',
      LocaleKeys.sortPriceAsc.name: 'Giá: Thấp -> Cao',
      LocaleKeys.sortStockAsc.name: 'Số lượng: Thấp -> Cao',
      LocaleKeys.sortStockDesc.name: 'Số lượng: Cao -> Thấp',

      // Settings
      LocaleKeys.settingsTitle.name: 'Cài đặt',
      LocaleKeys.theme.name: 'Giao diện',
      LocaleKeys.language.name: 'Ngôn ngữ',
      LocaleKeys.systemMode.name: 'Hệ thống',
      LocaleKeys.systemModeDesc.name: 'Tự động theo thiết bị',
      LocaleKeys.lightMode.name: 'Sáng',
      LocaleKeys.lightModeDesc.name: 'Luôn sử dụng giao diện sáng',
      LocaleKeys.darkMode.name: 'Tối',
      LocaleKeys.darkModeDesc.name: 'Luôn sử dụng giao diện tối',
      LocaleKeys.logout.name: 'Đăng xuất',
      LocaleKeys.logoutConfirm.name: 'Bạn có chắc chắn muốn đăng xuất?',

      // Search
      LocaleKeys.searchHint.name: 'Tìm kiếm...',

      // Auth - Login
      LocaleKeys.welcomeBack.name: 'Chào mừng trở lại',
      LocaleKeys.loginDescription.name: 'Đăng nhập để quản lý kho của bạn',
      LocaleKeys.username.name: 'Tài khoản',
      LocaleKeys.password.name: 'Mật khẩu',
      LocaleKeys.forgotPassword.name: 'Quên mật khẩu?',
      LocaleKeys.login.name: 'Đăng nhập',
      LocaleKeys.noAccount.name: 'Chưa có tài khoản?',
      LocaleKeys.register.name: 'Đăng ký',
      LocaleKeys.orLoginWith.name: 'Hoặc đăng nhập với',
      LocaleKeys.help.name: 'Trợ giúp',
      LocaleKeys.needHelp.name: 'Cần trợ giúp?',
      LocaleKeys.contactSupport.name: 'Liên hệ hỗ trợ',

      // Auth - Register
      LocaleKeys.registerTitle.name: 'Đăng ký tài khoản',
      LocaleKeys.orRegisterWith.name: 'Hoặc đăng ký với',
      LocaleKeys.sessionExpired.name: 'Phiên đăng nhập đã hết hạn',
      LocaleKeys.plsLoginAgain.name: 'Vui lòng đăng nhập lại',

      // Biometric Authentication
      LocaleKeys.biometric.name: 'Sinh trắc học',
      LocaleKeys.faceId.name: 'Face ID',
      LocaleKeys.fingerprint.name: 'Vân tay',
      LocaleKeys.biometricNotEnrolled.name:
          'Thiết bị chưa đăng ký sinh trắc học',
      LocaleKeys.biometricLockedOut.name: 'Xác thực sinh trắc học đã bị khóa',
      LocaleKeys.biometricCanceled.name: 'Đã hủy xác thực sinh trắc học',
      LocaleKeys.biometricError.name: 'Lỗi xác thực sinh trắc học',
      LocaleKeys.biometricLogin.name: 'Đăng nhập bằng @s',
      LocaleKeys.biometricLoginReason.name:
          'Xác thực để đăng nhập bằng thông tin đã lưu',
      LocaleKeys.biometricLoginFailed.name: 'Đăng nhập vân tay thất bại',
      LocaleKeys.biometricLoginFailedCredentials.name:
          'Thông tin đã lưu không hợp lệ. Vui lòng đăng nhập thủ công.',
      LocaleKeys.biometricSaveReason.name:
          'Xác thực để bật đăng nhập sinh trắc học',
      LocaleKeys.biometricEnableFailed.name: 'Bật sinh trắc học thất bại',
      LocaleKeys.biometricEnableFromLogin.name:
          'Vui lòng đăng nhập trước khi bật sinh trắc học',
      LocaleKeys.biometricEnabled.name: 'Đã bật đăng nhập sinh trắc học',
      LocaleKeys.biometricDisabled.name: 'Đã tắt đăng nhập sinh trắc học',
      LocaleKeys.biometricEnabledDesc.name: 'Đăng nhập bằng vân tay/khuôn mặt',
      LocaleKeys.biometricDisabledDesc.name:
          'Không sử dụng đăng nhập sinh trắc học',
      LocaleKeys.biometricChangedWarning.name:
          'Phát hiện dữ liệu sinh trắc học trên thiết bị đã thay đổi. Để bảo mật, vui lòng đăng nhập bằng mật khẩu.',
      LocaleKeys.biometricChangedAcknowledged.name:
          'Đã xác nhận trạng thái sinh trắc học mới. Bạn có thể sử dụng đăng nhập sinh trắc học.',
      LocaleKeys.security.name: 'Bảo mật',
      LocaleKeys.enable.name: 'Bật',
      LocaleKeys.disable.name: 'Tắt',

      // Empty States
      LocaleKeys.noCategoriesFound.name: 'Không tìm thấy danh mục',
      LocaleKeys.tryAddingCategory.name: 'Hãy thử thêm một danh mục mới',
      LocaleKeys.noProductsFound.name: 'Không tìm thấy sản phẩm',
      LocaleKeys.tryAddingProduct.name: 'Hãy thử thêm một sản phẩm mới',
      LocaleKeys.retry.name: 'Thử lại',

      // Barcode Scan
      LocaleKeys.barcodeScan.name: 'Quét mã vạch',
      LocaleKeys.scanWithCamera.name: 'Quét bằng camera',
      LocaleKeys.clearAll.name: 'Xoá tất cả',
      LocaleKeys.scanningStatus.name: 'Trạng thái quét',
      LocaleKeys.scannedCount.name: 'Đã quét: @count sản phẩm',
      LocaleKeys.scanning.name: 'Đang quét',
      LocaleKeys.lastScanned.name: 'Mã cuối: @code',
      LocaleKeys.scanBarcodeToStart.name: 'Quét mã vạch để bắt đầu',
      LocaleKeys.addedProduct.name: 'Đã thêm @name',
      LocaleKeys.productAlreadySelected.name: 'Sản phẩm đã được chọn',
      LocaleKeys.scanError.name: 'Lỗi quét',

      // Language names
      LocaleKeys.vietnamese.name: 'Tiếng Việt',
      LocaleKeys.english.name: 'English',

      // Quick actions
      LocaleKeys.group.name: 'Nhóm',
    },
  };
}
