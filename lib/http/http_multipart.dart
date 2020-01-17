part of ai_http;

/// This request automatically sets the Content-Type header to
/// `multipart/form-data`. This value will override any value set by the user.
///
///     var uri = Uri.parse("http://pub.dartlang.org/packages/create");
///     var request = new http.MultipartRequest("POST", uri);
///     request.fields['user'] = 'nweiz@google.com';
///     request.files.add(new http.MultipartFile.fromPath(
///         'package',
///         'build/package.tar.gz',
///         contentType: new MediaType('application', 'x-tar'));
///     var response = await request.send();
///     if (response.statusCode == 200) print('Uploaded!');
///
class HttpMultipartRequest {
  ///
  ///
  static Future<Response> postUploadFiles(
    dynamic url, {
    Map<String, String> headers,
    @required Map<String, String> fields,
    @required List<MultipartBody> body,
  }) async {
    //uri
    var uri = Uri.parse(url);
    /*
    Url
    Method
    */
    http.MultipartRequest multipartRequest = http.MultipartRequest("POST", uri);

    /*
    Headers
    */
    multipartRequest.headers.addAll(headers);
    /*
    field
    */
    multipartRequest.fields.addAll(fields);
    /*
    Files/Body
    */
    body?.forEach((MultipartBody body) async {
      //add
      multipartRequest.files.add(await http.MultipartFile.fromPath(
        body.field,
        body.filePath,
        filename: body.filename,
        contentType: body.contentType,
      ));
    });

    /*
    send
    */
    http.BaseResponse baseResponse = await multipartRequest.send();

    return baseResponse;
  }
}
