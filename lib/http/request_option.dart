part of ai_http;

///
/// RequestOption
class RequestOption {
  ///Request's url suffix
  dynamic _urlSuffix;

  ///Request's headers
  Map<String, String> _headers;

  ///Request's parameters
  Map<String, Object> _parameters;

  ///Request's body
  dynamic _body;

  Encoding _encoding;

  ///Constructor
  RequestOption(
      {dynamic urlSuffix,
      Map<String, String> headers,
      Map<String, Object> parameters,
      dynamic body,
      Encoding encoding}) {
    this._urlSuffix = urlSuffix;
    this._headers = headers;
    this._parameters = parameters;
    this._body = body;
    this._encoding = encoding;
  }

  get urlSuffix => this._urlSuffix;

  set urlSuffix(String urlSuffix) {
    this._urlSuffix = urlSuffix;
  }

  Map<String, String> get headers => this._headers;

  set headers(Map<String, String> headers) {
    this._headers = headers;
  }

  Map<String, Object> get parameters => this._parameters;

  set parameters(Map<String, Object> parameters) {
    this._parameters = parameters;
  }

  get body => this._body;

  set body(dynamic body) {
    this._body = body;
  }

  get encoding => this._encoding;

  set encoding(Encoding encoding) {
    this._encoding = encoding;
  }

  @override
  String toString() {
    return "RequestOption -> url:${urlSuffix.toString()}, headers:${headers.toString()}, parameters:${parameters.toString()}, body:${body.toString()}, encoding:${encoding.toString()}";
  }
}
