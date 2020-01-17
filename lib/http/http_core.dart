part of ai_http;

///
/// HttpCore
///
/// Head
Future<Response> head(dynamic url, {Map<String, String> headers}) =>
    http.head(url, headers: headers);

///
/// Get
Future<Response> get(dynamic url, {Map<String, String> headers}) =>
    http.get(url, headers: headers);

///
/// Post
Future<Response> post(dynamic url,
        {Map<String, String> headers, dynamic body, Encoding encoding}) =>
    http.post(url, headers: headers, body: body, encoding: encoding);

///
/// Put
Future<Response> put(dynamic url,
        {Map<String, String> headers, body, Encoding encoding}) =>
    http.put(url, headers: headers, body: body, encoding: encoding);

///
/// Patch
Future<Response> patch(dynamic url,
        {Map<String, String> headers, body, Encoding encoding}) =>
    http.patch(url, headers: headers, body: body, encoding: encoding);

///
/// Delete
Future<Response> delete(dynamic url, {Map<String, String> headers}) =>
    http.delete(url, headers: headers);

///
/// Read
Future<String> read(dynamic url, {Map<String, String> headers}) =>
    http.read(url, headers: headers);

///
/// ReadBytes
Future<Uint8List> readBytes(dynamic url, {Map<String, String> headers}) =>
    http.readBytes(url, headers: headers);

///
/// UpLoadFiles by Post
Future<Response> postUploadFiles(
  dynamic url, {
  Map<String, String> headers,
  @required Map<String, String> fields,
  @required List<MultipartBody> body,
}) {
  return HttpMultipartRequest.postUploadFiles(
    url,
    headers: headers,
    fields: fields,
    body: body,
  );
}
