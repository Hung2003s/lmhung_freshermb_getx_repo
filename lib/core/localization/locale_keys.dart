import 'package:get/get.dart';

enum LocaleKeys {
  // Dashboard
  appTitle,

  // Profile AppBar
  greetingMorning,
  greetingAfternoon,
  greetingEvening,

  // Home Page
  warehouseOverview,
  updatedAt,
  quickActions,
  addProduct,
  addCategory,
  categoryName,
  save,
  totalProducts,
  growingPercent,

  // Category Page
  manage,
  category,
  searchCategory,
  growing,
  deleteCategoryConfirm,
  cancel,
  confirm,
  updateCategory,
  edit,
  delete,
  productsCount,

  // Product Page
  products,
  inStock,
  deleteProductConfirm,
  sortFilter,
  showingProducts,
  newest,
  allCategories,
  selectCategory,
  all,

  // Product Info Page
  addNewProduct,
  editProduct,
  productDetails,
  productImage,
  addImage,
  enterProductName,
  productName,
  productCategory,
  skuExample,
  skuCode,
  priceHint,
  sellingPrice,
  stockExample,
  quantity,
  productDescriptionHint,
  description,
  createNewProduct,
  saveChanges,

  // Validation Messages
  nameRequired,
  codeRequired,
  codeExists,
  priceRequired,
  priceInvalid,
  pricePositive,
  stockInvalid,
  stockNonNegative,
  categoryRequired,
  categoryInvalid,

  // Snackbar Messages
  addSuccess,
  addFailed,
  updateSuccess,
  updateFailed,
  deleteSuccess,
  deleteFailed,
  loginSuccess,
  loginFailed,
  registerSuccess,
  registerFailed,
  invalidCredentials,
  loginLocked,
  loginAttemptsLeft,

  // Auth Validation
  usernameRequired,
  usernameMinLength,
  usernameMaxLength,
  passwordRequired,
  passwordMinLength,
  passwordMaxLength,
  loginLockedButton,
  noProductsInCategory,
  errorTitle,
  logoutFailed,

  // Sort Options
  sortNameAsc,
  sortNameDesc,
  sortPriceDesc,
  sortPriceAsc,
  sortStockAsc,
  sortStockDesc,

  // Settings
  settingsTitle,
  theme,
  language,
  systemMode,
  systemModeDesc,
  lightMode,
  lightModeDesc,
  darkMode,
  darkModeDesc,
  logout,
  logoutConfirm,

  // Search
  searchHint,

  // Auth - Login
  welcomeBack,
  loginDescription,
  username,
  password,
  forgotPassword,
  login,
  noAccount,
  register,
  orLoginWith,
  help,
  needHelp,
  contactSupport,

  // Auth - Register
  registerTitle,
  orRegisterWith,
  sessionExpired,
  plsLoginAgain,

  // Biometric Authentication
  biometric,
  faceId,
  fingerprint,
  biometricNotEnrolled,
  biometricLockedOut,
  biometricCanceled,
  biometricError,
  biometricLogin,
  biometricLoginReason,
  biometricLoginFailed,
  biometricLoginFailedCredentials,
  biometricSaveReason,
  biometricEnableFailed,
  biometricEnableFromLogin,
  biometricEnabled,
  biometricDisabled,
  biometricEnabledDesc,
  biometricDisabledDesc,
  biometricChangedWarning,
  biometricChangedAcknowledged,
  security,
  enable,
  disable,

  // Empty States
  noCategoriesFound,
  tryAddingCategory,
  noProductsFound,
  tryAddingProduct,
  retry,

  // Barcode Scan
  barcodeScan,
  scanWithCamera,
  clearAll,
  scanningStatus,
  scannedCount,
  scanning,
  lastScanned,
  scanBarcodeToStart,
  addedProduct,
  productAlreadySelected,
  scanError,

  // Language names
  vietnamese,
  english,

  // Quick actions
  group,
}

extension LocaleKeysExt on LocaleKeys {
  /// Trả về chuỗi đã được dịch theo ngôn ngữ hiện tại
  String get tr => name.tr;

  /// Trả về chuỗi đã được dịch với các tham số truyền vào
  /// Ví dụ: LocaleKeys.productsCount.trArgs(['10'])
  String trArgs([List<String> args = const []]) => name.trArgs(args);

  /// Trả về chuỗi đã được dịch với các tham số named
  /// Ví dụ: LocaleKeys.scannedCount.trParams({'count': '5'})
  String trParams([Map<String, String> params = const {}]) =>
      name.trParams(params);
}
