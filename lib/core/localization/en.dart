import 'package:get/get.dart';
import '../enum/locale_keys.dart';

class En extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Dashboard
      LocaleKeys.appTitle.name: 'Warehouse Management',

      // Profile AppBar
      LocaleKeys.greetingMorning.name: 'Good morning,',
      LocaleKeys.greetingAfternoon.name: 'Good afternoon,',
      LocaleKeys.greetingEvening.name: 'Good evening,',

      // Home Page
      LocaleKeys.warehouseOverview.name: 'Warehouse Overview',
      LocaleKeys.updatedAt.name: 'Updated at: 08:30 AM, 24/10/2023',
      LocaleKeys.quickActions.name: 'Quick Actions',
      LocaleKeys.addProduct.name: 'Add Product',
      LocaleKeys.addCategory.name: 'Add Category',
      LocaleKeys.categoryName.name: 'Category name',
      LocaleKeys.save.name: 'Save',
      LocaleKeys.totalProducts.name: 'Total Products',
      LocaleKeys.growingPercent.name: '+12%',

      // Category Page
      LocaleKeys.manage.name: 'Manage',
      LocaleKeys.category.name: 'Category',
      LocaleKeys.searchCategory.name: 'Search category',
      LocaleKeys.growing.name: 'growing',
      LocaleKeys.deleteCategoryConfirm.name:
          'Are you sure you want to delete this category?',
      LocaleKeys.cancel.name: 'Cancel',
      LocaleKeys.confirm.name: 'Confirm',
      LocaleKeys.updateCategory.name: 'Update Category',
      LocaleKeys.edit.name: 'Edit',
      LocaleKeys.delete.name: 'Delete',
      LocaleKeys.productsCount.name: '@s products',

      // Product Page
      LocaleKeys.products.name: 'Products',
      LocaleKeys.inStock.name: 'In stock',
      LocaleKeys.deleteProductConfirm.name:
          'Are you sure you want to delete this product?',
      LocaleKeys.sortFilter.name: 'Sort & Filter',
      LocaleKeys.showingProducts.name: 'Showing @s products',
      LocaleKeys.newest.name: 'Newest',
      LocaleKeys.allCategories.name: 'All categories',
      LocaleKeys.selectCategory.name: 'Select category',
      LocaleKeys.all.name: 'All',

      // Product Info Page
      LocaleKeys.addNewProduct.name: 'Add New Product',
      LocaleKeys.editProduct.name: 'Edit Product',
      LocaleKeys.productDetails.name: 'Product Details',
      LocaleKeys.productImage.name: 'Product Image',
      LocaleKeys.addImage.name: 'Add Image',
      LocaleKeys.enterProductName.name: 'Enter product name',
      LocaleKeys.productName.name: 'Product Name',
      LocaleKeys.productCategory.name: 'Product Category',
      LocaleKeys.skuExample.name: 'E.g: SP-001',
      LocaleKeys.skuCode.name: 'SKU/Code',
      LocaleKeys.priceHint.name: 'Enter price',
      LocaleKeys.sellingPrice.name: 'Selling Price',
      LocaleKeys.stockExample.name: 'E.g: 100',
      LocaleKeys.quantity.name: 'Quantity',
      LocaleKeys.productDescriptionHint.name: 'Enter product description',
      LocaleKeys.description.name: 'Description',
      LocaleKeys.createNewProduct.name: 'Create New Product',
      LocaleKeys.saveChanges.name: 'Save Changes',

      // Validation Messages
      LocaleKeys.nameRequired.name: 'Name is required',
      LocaleKeys.codeRequired.name: 'Code is required',
      LocaleKeys.codeExists.name: 'Product code already exists',
      LocaleKeys.priceRequired.name: 'Price is required',
      LocaleKeys.priceInvalid.name: 'Invalid price',
      LocaleKeys.pricePositive.name: 'Price must be greater than 0',
      LocaleKeys.stockInvalid.name: 'Invalid stock quantity',
      LocaleKeys.stockNonNegative.name:
          'Stock must be greater than or equal to 0',
      LocaleKeys.categoryRequired.name: 'Category is required',
      LocaleKeys.categoryInvalid.name: 'Invalid category',

      // Snackbar Messages
      LocaleKeys.addSuccess.name: 'Add successful',
      LocaleKeys.addFailed.name: 'Add failed',
      LocaleKeys.updateSuccess.name: 'Update successful',
      LocaleKeys.updateFailed.name: 'Update failed',
      LocaleKeys.deleteSuccess.name: 'Delete successful',
      LocaleKeys.deleteFailed.name: 'Delete failed',
      LocaleKeys.loginSuccess.name: 'Login successful',
      LocaleKeys.loginFailed.name: 'Login failed',
      LocaleKeys.registerSuccess.name: 'Register successful',
      LocaleKeys.registerFailed.name: 'Register failed',
      LocaleKeys.invalidCredentials.name: 'Please enter your credentials.',
      LocaleKeys.loginLocked.name:
          'Account is temporarily locked. Please try again in @s seconds.',
      LocaleKeys.loginAttemptsLeft.name:
          '@s attempts remaining before lockout.',

      // Auth Validation
      LocaleKeys.usernameRequired.name: 'Username is required',
      LocaleKeys.usernameMinLength.name:
          'Username must be at least 3 characters',
      LocaleKeys.usernameMaxLength.name:
          'Username must not exceed 50 characters',
      LocaleKeys.passwordRequired.name: 'Password is required',
      LocaleKeys.passwordMinLength.name:
          'Password must be at least 6 characters',
      LocaleKeys.passwordMaxLength.name:
          'Password must not exceed 100 characters',
      LocaleKeys.loginLockedButton.name: 'Locked',
      LocaleKeys.noProductsInCategory.name:
          'No products found for this category',
      LocaleKeys.errorTitle.name: 'Error',
      LocaleKeys.logoutFailed.name: 'Logout failed',

      // Sort Options
      LocaleKeys.sortNameAsc.name: 'Name: A -> Z',
      LocaleKeys.sortNameDesc.name: 'Name: Z -> A',
      LocaleKeys.sortPriceDesc.name: 'Price: High -> Low',
      LocaleKeys.sortPriceAsc.name: 'Price: Low -> High',
      LocaleKeys.sortStockAsc.name: 'Quantity: Low -> High',
      LocaleKeys.sortStockDesc.name: 'Quantity: High -> Low',

      // Settings
      LocaleKeys.settingsTitle.name: 'Settings',
      LocaleKeys.theme.name: 'Theme',
      LocaleKeys.language.name: 'Language',
      LocaleKeys.systemMode.name: 'System',
      LocaleKeys.systemModeDesc.name: 'Follow device settings',
      LocaleKeys.lightMode.name: 'Light',
      LocaleKeys.lightModeDesc.name: 'Always use light theme',
      LocaleKeys.darkMode.name: 'Dark',
      LocaleKeys.darkModeDesc.name: 'Always use dark theme',
      LocaleKeys.logout.name: 'Logout',
      LocaleKeys.logoutConfirm.name: 'Are you sure you want to logout?',

      // Search
      LocaleKeys.searchHint.name: 'Search...',

      // Auth - Login
      LocaleKeys.welcomeBack.name: 'Welcome back',
      LocaleKeys.loginDescription.name: 'Log in to manage your warehouse',
      LocaleKeys.username.name: 'Username',
      LocaleKeys.password.name: 'Password',
      LocaleKeys.forgotPassword.name: 'Forgot password?',
      LocaleKeys.login.name: 'Login',
      LocaleKeys.noAccount.name: "Don't have an account?",
      LocaleKeys.register.name: 'Register',
      LocaleKeys.orLoginWith.name: 'Or login with',
      LocaleKeys.help.name: 'Help',
      LocaleKeys.needHelp.name: 'Need help?',
      LocaleKeys.contactSupport.name: 'Contact support',

      // Auth - Register
      LocaleKeys.registerTitle.name: 'Register account',
      LocaleKeys.orRegisterWith.name: 'Or register with',
      LocaleKeys.sessionExpired.name: 'Session expired',
      LocaleKeys.plsLoginAgain.name: 'Please login again',

      // Biometric Authentication
      LocaleKeys.biometric.name: 'Biometric',
      LocaleKeys.faceId.name: 'Face ID',
      LocaleKeys.fingerprint.name: 'Fingerprint',
      LocaleKeys.biometricNotEnrolled.name:
          'No biometrics enrolled on this device',
      LocaleKeys.biometricLockedOut.name:
          'Biometric authentication is locked out',
      LocaleKeys.biometricCanceled.name: 'Biometric authentication canceled',
      LocaleKeys.biometricError.name: 'Biometric authentication error',
      LocaleKeys.biometricLogin.name: 'Login with @s',
      LocaleKeys.biometricLoginReason.name:
          'Authenticate to login with saved credentials',
      LocaleKeys.biometricLoginFailed.name: 'Biometric login failed',
      LocaleKeys.biometricLoginFailedCredentials.name:
          'Saved credentials are invalid. Please login manually.',
      LocaleKeys.biometricSaveReason.name:
          'Authenticate to enable biometric login',
      LocaleKeys.biometricEnableFailed.name: 'Enable biometric failed',
      LocaleKeys.biometricEnableFromLogin.name:
          'Please login first before enabling biometric',
      LocaleKeys.biometricEnabled.name: 'Biometric login enabled',
      LocaleKeys.biometricDisabled.name: 'Biometric login disabled',
      LocaleKeys.biometricEnabledDesc.name: 'Login with fingerprint/face',
      LocaleKeys.biometricDisabledDesc.name: 'Not using biometric login',
      LocaleKeys.biometricChangedWarning.name:
          'Biometric data on this device has changed. For security, please login with your password.',
      LocaleKeys.biometricChangedAcknowledged.name:
          'New biometric status confirmed. You can now use biometric login.',
      LocaleKeys.security.name: 'Security',
      LocaleKeys.enable.name: 'Enable',
      LocaleKeys.disable.name: 'Disable',

      // Empty States
      LocaleKeys.noCategoriesFound.name: 'No categories found',
      LocaleKeys.tryAddingCategory.name: 'Try adding a new category',
      LocaleKeys.noProductsFound.name: 'No products found',
      LocaleKeys.tryAddingProduct.name: 'Try adding a new product',
      LocaleKeys.retry.name: 'Retry',

      // Barcode Scan
      LocaleKeys.barcodeScan.name: 'Barcode Scan',
      LocaleKeys.scanWithCamera.name: 'Scan with camera',
      LocaleKeys.clearAll.name: 'Clear all',
      LocaleKeys.scanningStatus.name: 'Scanning Status',
      LocaleKeys.scannedCount.name: 'Scanned: @count products',
      LocaleKeys.scanning.name: 'Scanning',
      LocaleKeys.lastScanned.name: 'Last scanned: @code',
      LocaleKeys.scanBarcodeToStart.name: 'Scan a barcode to start',
      LocaleKeys.addedProduct.name: 'Added @name',
      LocaleKeys.productAlreadySelected.name: 'Product already selected',
      LocaleKeys.scanError.name: 'Scan error',

      // Language names
      LocaleKeys.vietnamese.name: 'Vietnamese',
      LocaleKeys.english.name: 'English',

      // Quick actions
      LocaleKeys.group.name: 'Group',
    },
  };
}
