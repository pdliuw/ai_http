library ai_http;

///
/// export
export 'package:http/src/response.dart';

///
/// import
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

///
/// part
part 'http/content_type.dart';
part 'http/http_core.dart';
part 'http/http_builder.dart';
part 'http/request_option.dart';
part 'http/http_manager.dart';
part 'http/http_headers.dart';
part 'http/http_interceptor.dart';
part 'http/http_multipart.dart';
part 'http/multipart_body.dart';
part 'http/http_media_type.dart';
part 'http_context.dart';
part 'interceptor/interceptor.dart';
part 'interceptor/request_interceptor.dart';
part 'interceptor/response_interceptor.dart';

///
/// AiHttp
class AiHttp {
  ///
  /// global config
  static void globalConfig({
    @required String baseUrl,
    RequestInterceptor requestInterceptor,
    ResponseInterceptor responseInterceptor,
  }) {
    HttpManager.getInstance().httpBuilder.buildBaseUrl(baseUrl);
    HttpManager.getInstance()
        .addRequestInterceptor(requestInterceptor: requestInterceptor);
    HttpManager.getInstance()
        .addResponseInterceptor(responseInterceptor: responseInterceptor);
  }

  ///
  /// get method request
  static void get({
    @required RequestRule requestRule,
    @required ResponseCallback responseCallback,
  }) {
    HttpContext().get(
      requestRule: requestRule,
      responseCallback: responseCallback,
    );
  }

  ///
  /// post method request
  static void post({
    @required RequestRule requestRule,
    @required ResponseCallback responseCallback,
  }) {
    HttpContext().post(
      requestRule: requestRule,
      responseCallback: responseCallback,
    );
  }

  ///
  /// delete method request
  static void delete({
    @required RequestRule requestRule,
    @required ResponseCallback responseCallback,
  }) {
    HttpContext().delete(
      requestRule: requestRule,
      responseCallback: responseCallback,
    );
  }

  static void baseUrl(String baseUrl) {
    HttpManager.getInstance().httpBuilder.buildBaseUrl(baseUrl);
  }
}
