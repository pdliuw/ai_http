import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:ai_http/ai_http.dart';
import 'package:http/http.dart' as http;

void main() {
//  String url = "https://www.baidu.com/";
//
//  var httpClient = HttpClient();
//
//  Uri uri = Uri.parse(url);

  double temperature = 2.0;

  print(temperature.temperature());
  print(DoubleTemperature(1234567).temperature());

//  try{
//
//    HttpClientRequest response  = await httpClient.open("method",uri.host, uri.port, uri.path);
//
//
//
//
//    httpClient.close();
//  }catch(e){
//    print("request error");
//  }
}

extension DoubleTemperature on double {
  String temperature() {
    return "温度--${this}";
  }
}
