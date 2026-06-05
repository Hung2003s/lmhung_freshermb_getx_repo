class _CacheEntry {
  final dynamic data;
  final DateTime cachedAt;
  final Duration ttl;

  _CacheEntry({
    required this.data,
    required this.cachedAt,
    required this.ttl,
  });

  bool get isValid => DateTime.now().difference(cachedAt) < ttl;
}

/// Cache in-memory đơn giản với TTL, dùng chung cho toàn ứng dụng.
///
/// - [set] : lưu data với key và TTL tùy chọn (mặc định 5 phút)
/// - [get] : lấy data; trả về null nếu hết hạn hoặc chưa có
/// - [invalidate] : xóa một key cụ thể (dùng sau khi mutation)
/// - [invalidateAll] : xóa toàn bộ cache (dùng khi logout)
class CacheManager {
  final Map<String, _CacheEntry> _store = {};

  static const defaultTtl = Duration(minutes: 5);

  void set<T>(
    String key,
    T data, {
    Duration ttl = defaultTtl,
  }) {
    _store[key] = _CacheEntry(
      data: data,
      cachedAt: DateTime.now(),
      ttl: ttl,
    );
  }

  T? get<T>(String key) {
    final entry = _store[key];
    if (entry == null || !entry.isValid) {
      _store.remove(key);
      return null;
    }
    return entry.data as T?;
  }

  void invalidate(String key) => _store.remove(key);

  void invalidateAll() => _store.clear();
}

/// Các key cache dùng trong ứng dụng — tập trung một chỗ để dễ quản lý.
abstract class CacheKeys {
  static const categoriesFirstPage = 'categories_first_page';
}
