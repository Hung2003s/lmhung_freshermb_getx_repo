class Constants {
  static const int connectTimeout = 30;
  static const int limit = 40;
  static const int offset = 0;

  static const commonError = 'Có lỗi xảy ra, vui lòng thử lại.';
  static const noInternet = 'Không có kết nối mạng. Vui lòng thử lại sau.';
  static const timeoutError = 'Không thể kết nối tới server';

  static final taxNumberRule = RegExp(r'^([0-9]{10}-[0-9]{3}|[0-9]{12})$');
  static const accessTokenKey = 'ACCESS_TOKEN_KEY';
  static const tokenExpiryKey = 'TOKEN_EXPIRY_KEY';
}
