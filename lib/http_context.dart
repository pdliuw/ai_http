part of ai_http;

typedef Callback = void Function(ResponseModel responseModel);

///
/// Http context:网络框架封装
/// 1、Method:
/// Http Get method:[HttpContext.get]
/// Http Post method:[HttpContext.post]
/// Http Delete method:[HttpContext.delete]
/// 2、...:
class HttpContext {
  ///
  /// interceptor
  Future<RequestRule> _interceptor(RequestRule requestRules) async {
    RequestRule newRequestRule;
    for (RequestInterceptor requestInterceptor
        in HttpManager.getInstance().requestInterceptorList) {
      RequestRule requestRuleOfInterceptor =
          await requestInterceptor.interceptor(requestRules);

      if (requestRuleOfInterceptor != null) {
        newRequestRule = requestRuleOfInterceptor;
      }
    }

    return newRequestRule;
  }

  _response({
    @required Response response,
    @required ResponseCallback responseCallback,
    OSError osError,
  }) {
    //ResponseInterceptorModel
    ResponseInterceptorModel responseInterceptorModel =
        ResponseInterceptorModel(
      response: response,
      responseCallback: responseCallback,
      osError: osError,
    );

    for (ResponseInterceptor responseInterceptor
        in HttpManager.getInstance().responseInterceptorList) {
      responseInterceptor.interceptor(responseInterceptorModel);
    }
  }

  get({
    @required RequestRule requestRule,
    ResponseCallback responseCallback,
  }) async {
    /*
    拦截器
     */
    RequestRule newRequestRule = await _interceptor(requestRule);

    print('start get request...');
    /*
    开启请求
     */
    Response response;
    OSError osError;
    try {
      response = await HttpManager.getInstance().executeGet(
          requestOption: RequestOption(
        urlSuffix: newRequestRule.url,
        headers: newRequestRule.headers,
        parameters: newRequestRule.parameters,
      ));
    } catch (e) {
      print("$e");
      if (e is SocketException) {
        osError = e.osError;
      }
    }

    /*
    处理，响应体
     */
    _response(
        response: response,
        responseCallback: responseCallback,
        osError: osError);
  }

  ///
  /// Post request method!
  post({
    @required RequestRule requestRule,
    ResponseCallback responseCallback,
  }) async {
    /*
    拦截器
     */
    RequestRule newRequestRule = await _interceptor(requestRule);
    print('start post request...');
    /*
    开启请求
     */
    Response response;
    OSError osError;
    try {
      response = await HttpManager.getInstance().executePost(
        requestOption: RequestOption(
          urlSuffix: newRequestRule.url,
          headers: newRequestRule.headers,
          body: newRequestRule.body,
        ),
      );
    } catch (e) {
      print("$e");
      if (e is SocketException) {
        osError = e.osError;
      }
    }
    /*
    处理，响应体
     */
    _response(
        response: response,
        responseCallback: responseCallback,
        osError: osError);
  }

  ///
  /// Delete request method!
  delete({
    @required RequestRule requestRule,
    ResponseCallback responseCallback,
  }) async {
    print("Delete:RequestRule:${requestRule.toString()}");
    /*
    拦截器
     */
    RequestRule newRequestRule = await _interceptor(requestRule);
    print('start delete request...');
    /*
    开启请求
     */
    Response response;
    OSError osError;
    try {
      response = await HttpManager.getInstance().executeDelete(
          requestOption: RequestOption(
        urlSuffix: newRequestRule.url,
        headers: newRequestRule.headers,
        parameters: newRequestRule.parameters,
      ));
    } catch (e) {
      print("$e");
      if (e is SocketException) {
        osError = e.osError;
      }
    }

    /*
    处理，响应体
     */
    _response(
        response: response,
        responseCallback: responseCallback,
        osError: osError);
  }
}

///
/// RequestRule:请求体（RequestMethod:GET、POST、DELETE）
class RequestRule {
  dynamic _url;
  Map<String, String> _headers;

  ///参数【GET、DELETE】
  Map<String, Object> _parameters;
  dynamic _body;

  RequestRule(
      {dynamic url,
      Map<String, String> headers,
      Map<String, Object> parameters,
      dynamic body}) {
    this._url = url;
    this._headers = headers;
    this._parameters = parameters;
    this._body = body;
  }

  get url => this._url;

  Map<String, String> get headers => this._headers;

  set headers(Map<String, String> headers) {
    this._headers = headers;
  }

  get body => this._body;

  set body(dynamic body) {
    this._body = body;
  }

  set url(String url) {
    this._url = url;
  }

  set parameters(Map<String, Object> parameters) {
    this._parameters = parameters;
  }

  Map<String, Object> get parameters => this._parameters;

  @override
  String toString() {
    return "url:$url, headers:${headers.toString()}, parameters:${parameters.toString()}, body:$body";
  }
}

///
/// ResponseCallback:响应回调对象(用于接收响应数据)
class ResponseCallback {
  Callback _successCallback;
  Callback _failCallback;

  Callback get successfulCallback => this._successCallback;
  Callback get failureCallback => this._failCallback;

  ResponseCallback({
    @required Callback successfulCallback,
    @required Callback failureCallback,
  }) {
    this._successCallback = successfulCallback;
    this._failCallback = failureCallback;
  }
}

///
/// ResponseModel:响应体(响应的数据实体)
class ResponseModel {
  String _message;
  int _statusCode;
  dynamic _data;

  ResponseModel({
    @required int statusCode,
    @required String message,
    @required dynamic data,
  }) {
    this._statusCode = statusCode;
    this._message = message;
    this._data = data;
  }

  get statusCode => this._statusCode;
  get message => this._message;
  get data => this._data;

  Map<String, Object> toObject() {
    return jsonDecode(this._data);
  }
}
