part of ai_http;

///
/// ResponseInterceptor
abstract class ResponseInterceptor {
  bool interceptor(ResponseInterceptorModel responseInterceptorModel) {
    return false;
  }
}

///
/// ResponseInterceptorModel
class ResponseInterceptorModel {
  Response _response;
  ResponseCallback _responseCallback;
  OSError _osError;

  ResponseInterceptorModel({
    @required Response response,
    @required ResponseCallback responseCallback,
    @required OSError osError,
  }) {
    this._response = response;
    this._responseCallback = responseCallback;
    this._osError = osError;
  }

  Response get response => this._response;
  ResponseCallback get responseCallback => this._responseCallback;
  OSError get osError => this._osError;
}
