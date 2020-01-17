part of ai_http;

///
/// RequestInterceptor
abstract class RequestInterceptor {
  ///
  /// request interceptor.
  Future<RequestRule> interceptor(RequestRule requestRule) async {
    return null;
  }
}
