import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheManager {
  static final CacheOptions dioCacheoptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional to get a standard behaviour.

    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error for given status codes.
    // Defaults to `[]`.
    hitCacheOnErrorCodes: [500, 501, 502, 503, 504],
    // Allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to `false`.
    hitCacheOnNetworkFailure: true,
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to `null`.
    maxStale: const Duration(days: 1),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Assigning a [keyBuilder] is strongly recommended when `true`.
    allowPostMethod: false,
  );
}
