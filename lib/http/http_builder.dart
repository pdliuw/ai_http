part of ai_http;

///
/// Http builder
/// singleton[getInstance]
/// baseUrl[HttpBuilder.buildBaseUrl]
class HttpBuilder extends Object {
  ///
  /// default values
  static final Encoding utf_8 = Encoding.getByName("utf-8");

  static HttpBuilder _singleInstance;

  ///Base url or host address
  dynamic _baseUrl;

  Encoding _encoding = utf_8;

  ///Dart's private function with '_' decorate
  HttpBuilder._();

  static HttpBuilder getInstance() {
    if (_singleInstance == null) {
      _singleInstance = HttpBuilder._();
    }
    return _singleInstance;
  }

  get baseUrl => this._baseUrl;

  HttpBuilder buildBaseUrl(dynamic baseUrl) {
    this._baseUrl = baseUrl ?? this._baseUrl;
    return this;
  }

  HttpBuilder buildEncoding(String encodingName) {
    this._encoding = Encoding.getByName(encodingName) ?? utf_8;
    return this;
  }

  Encoding get encoding => this._encoding;
}
