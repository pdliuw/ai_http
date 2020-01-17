part of ai_http;

///
/// MultipartBody
class MultipartBody {
  String _field;
  String _filePath;
  String _filename;
  MediaType _contentType;

  ///
  /// MultipartBody
  /// [field] field/parameter
  /// [filePath] filePath of the file.
  /// [filename] filename of the file.
  /// [contentType] contentType of the file.view[HttpMediaType.getMediaType]
  /// contentType example:
  /// MediaType.parse("mediaType");
  /// or
  /// Map<String,String> parameters = {};
  /// MediaType("type","subType", parameters);
  ///
  MultipartBody(String field, String filePath,
      {String filename, MediaType contentType}) {
    this._field = field;
    this._filePath = filePath;
    this._filename = filename;
    this._contentType = contentType;
  }

  set field(String field) {
    this._field = field;
  }

  String get field => this._field;

  set filePath(String filePath) {
    this._filePath = filePath;
  }

  String get filePath => this._filePath;

  set filename(String filename) {
    this._filename = filename;
  }

  String get filename => this._filename;

  set contentType(MediaType contentType) {
    this._contentType = contentType;
  }

  MediaType get contentType => this._contentType;

  ///
  ///
  @override
  String toString() {
    return "MultipartBody:{field=$field, filePath=$filePath, filename=$filename, contentType=$contentType}";
  }
}
