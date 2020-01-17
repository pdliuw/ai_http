part of ai_http;

///
/// HttpManager
class HttpManager {
  HttpBuilder _httpBuilder = HttpBuilder.getInstance();

  static HttpManager _httpManager;

  List<RequestInterceptor> _requestInterceptorList = [];

  List<ResponseInterceptor> _responseInterceptorList = [];

  HttpManager._();

  static HttpManager getInstance() {
    if (_httpManager == null) {
      _httpManager = HttpManager._();
    }
    return _httpManager;
  }

  HttpBuilder get httpBuilder => this._httpBuilder;
  List<RequestInterceptor> get requestInterceptorList =>
      this._requestInterceptorList;

  List<ResponseInterceptor> get responseInterceptorList =>
      this._responseInterceptorList;

  ///
  /// addRequestInterceptor
  /// [requestInterceptor]
  /// return value is [bool] whether add successful
  bool addRequestInterceptor({
    @required RequestInterceptor requestInterceptor,
  }) {
    if (requestInterceptor == null) {
      return false;
    }
    if (_requestInterceptorList.contains(requestInterceptor)) {
      //contain
      return false;
    }
    //add
    _requestInterceptorList.add(requestInterceptor);

    return true;
  }

  ///
  /// addResponseInterceptor
  /// [responseInterceptor]
  /// return value is [bool] whether add successful
  bool addResponseInterceptor({
    @required ResponseInterceptor responseInterceptor,
  }) {
    if (responseInterceptor == null) {
      return false;
    }

    if (_responseInterceptorList.contains(responseInterceptor)) {
      //contain
      return false;
    }

    //add
    _responseInterceptorList.add(responseInterceptor);

    return true;
  }

  ///
  ///
  Future<Response> executeGet({@required RequestOption requestOption}) {
    //get
    return get(_getFullUrlWithParameters(requestOption),
        headers: _getFullHeaders(requestOption));
  }

  ///
  ///
  Future<Response> executePost({@required RequestOption requestOption}) {
    return post(_getFullUrl(requestOption.urlSuffix),
        headers: _getFullHeaders(requestOption),
        body: requestOption.body,
        encoding: requestOption.encoding ?? httpBuilder.encoding);
  }

  ///
  ///
  Future<Response> executeDelete({@required RequestOption requestOption}) {
    //delete
    return delete(_getFullUrlWithParameters(requestOption),
        headers: _getFullHeaders(requestOption));
  }

  ///
  ///
  Future<Response> executeUpLoadFile(
    dynamic url, {
    Map<String, String> headers,
    @required Map<String, String> fields,
    @required List<MultipartBody> files,
  }) {
    //http_multipart
    return HttpMultipartRequest.postUploadFiles(url,
        headers: headers, fields: fields, body: files);
  }

  ///
  ///
  String _getFullUrl(dynamic urlSuffix) {
    return "${httpBuilder.baseUrl}${urlSuffix}";
  }

  ///
  ///
  Map<String, String> _getDefaultConfigHeaders() {
    Map<String, String> configHeaders = {
      HttpHeaders.contentTypeHeader: ContentType.FormUrlEncoded,
    };

    return configHeaders;
  }

  ///
  ///
  String _getFullUrlWithParameters(RequestOption requestOption) {
    /*
    url
     */
    //full url.
    String fullUrl = _getFullUrl(requestOption.urlSuffix);
    //url splice
    String splicedParameter =
        _urlSpliceWithParameters(requestOption.parameters);
    String urlSplicedParameters = "$fullUrl$splicedParameter";
    return urlSplicedParameters;
  }

  ///
  ///
  Map<String, String> _getFullHeaders(RequestOption requestOption) {
    Map<String, String> headers = _getDefaultConfigHeaders();
    Map<String, String> requestOptionHeadersLower =
        _getLowerHeaders(requestOption.headers);

    //add request headers
    headers.addAll(requestOptionHeadersLower);

    return headers;
  }

  ///
  ///
  String _urlSpliceWithParameters(Map<String, Object> parameters) {
    String urlSpliced = "";
    parameters?.forEach((String key, Object value) {
      if (urlSpliced.contains("?")) {
        //拼接非第一个参数
        urlSpliced = "$urlSpliced&$key=$value";
      } else {
        //拼接第一个参数
        urlSpliced = "$urlSpliced?$key=$value";
      }
    });
    return urlSpliced;
  }

  ///
  /// lower headers'key
  Map<String, String> _getLowerHeaders(Map<String, String> headers) {
    Map<String, String> lowerHeaders = {};
    headers?.forEach((String key, String value) {
      //lower key
      String lowerKey = key.toLowerCase();
      //put
      lowerHeaders.putIfAbsent(lowerKey, () {
        return value;
      });
    });

    return lowerHeaders;
  }
}
