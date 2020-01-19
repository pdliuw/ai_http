import 'dart:convert';
import 'dart:io';

import 'package:example/business/test/TestPage.dart';
import 'package:flutter/material.dart';
import 'package:airoute/airoute.dart';
import 'package:ai_http/ai_http.dart';

void main() {
  ///
  /// 配置Http
  AiHttp.globalConfig(
    baseUrl: "https://www.baidu.com/",
    requestInterceptor: RequestInterceptorWell(),
    responseInterceptor: ResponseInterceptorWell(),
  );

  runApp(
    ///
    /// 配置Airoute
    Airoute.createMaterialApp(
      home: TestPage(),
      routes: <String, AirouteBuilder>{
        "/LaunchPage": () => MyHomePage(),
        "/SecondPage": () => MyHomePage(),
        "/TestPage": () => TestPage(),
      },
    ),
  );
}

///
/// RequestInterceptorWell
class RequestInterceptorWell extends RequestInterceptor {
  @override
  Future<RequestRule> interceptor(RequestRule requestRule) async {
    /*
    前
     */
    RequestRule oldRequestRule = requestRule;
    /*
    处理拼接地址
     */
    if (oldRequestRule.url is String) {
      String requestUrl = oldRequestRule.url;

      String newRequestUrl = requestUrl.replaceFirst("app", "sh-app");

      //更新URL
      oldRequestRule.url = newRequestUrl;
    }

    /*
    全局处理Token
     */
    //Token
    Map<String, String> tokenHeader;
    //获取
    String userInfoString = "not null value";

    if (userInfoString != null && userInfoString.isNotEmpty) {
      var userInfo = {
        "access_token": "",
        "token_type": "",
      };
      String accessToken = userInfo['access_token'];
      String tokenType = userInfo['token_type'];
      String first = tokenType.substring(0, 1);
      String firstUpper = first.toUpperCase();
      String tokenTypeFull = tokenType.replaceRange(0, 1, firstUpper);
      //access_token + "空格" + token_type
      String token = "$tokenTypeFull $accessToken";
      tokenHeader = {
        "Authorization": token,
      };
    }
    //添加
    Map<String, String> newHeaders = {};
    if (tokenHeader != null) {
      if (oldRequestRule.headers != null) {
        if (oldRequestRule.headers['access_token'] != null) {
        } else {
          newHeaders.addAll(tokenHeader);
        }
      } else {
        newHeaders.addAll(tokenHeader);
      }
    }
    if (oldRequestRule.headers != null) {
      newHeaders.addAll(oldRequestRule.headers);
    }
    RequestRule newRequestRule = RequestRule(
        url: oldRequestRule.url,
        headers: newHeaders,
        parameters: oldRequestRule.parameters,
        body: oldRequestRule.body);

    print("NewRequstRule header length:${newRequestRule.headers.length}");
    print("RequestRule:${oldRequestRule.toString()}");
    print("NewRquestRule:${newRequestRule.toString()}");

    return requestRule;
  }
}

///
/// ResponseInterceptorWell
class ResponseInterceptorWell extends ResponseInterceptor {
  @override
  interceptor(ResponseInterceptorModel responseInterceptorModel) {
    Response response = responseInterceptorModel.response;
    ResponseCallback responseCallback =
        responseInterceptorModel.responseCallback;
    OSError osError = responseInterceptorModel.osError;

    print(
        "response:statusCode=${response.statusCode}, message=${response.reasonPhrase}, isRedirect=${response.isRedirect}");
    print("response body:${jsonEncode(response.body)}");
    print("response body-origin:${response.body}");

    int statusCodeNetLevel = 0;
    int statusCodeBusinessLevel = 0;
    String messageNetLevel = "";
    String messageBusinessLevel = "";
    dynamic responseObjectOfBusiness = {};

    if (osError == null) {
      /*
        无异常
         */
      responseObjectOfBusiness = jsonDecode(response.body);
      //code.
      statusCodeNetLevel = response.statusCode;
      statusCodeBusinessLevel = responseObjectOfBusiness['status'];
      //message.
      messageNetLevel = response.reasonPhrase;
      messageBusinessLevel = responseObjectOfBusiness['message'];
    } else {
      /*
        有异常
         */
      int errorCode = osError.errorCode;
      String message = "${osError.message}";
      if (errorCode == 101) {
        message = "网络未连接";
      } else if (errorCode == HttpStatus.networkConnectTimeoutError &&
          errorCode == 110) {
        message = "网络连接超时";
      } else if (errorCode == HttpStatus.internalServerError) {
        message = "内部服务器异常";
      }
      statusCodeNetLevel = errorCode;
      messageNetLevel = message;

      responseObjectOfBusiness = {
        "message": messageNetLevel,
        "status": statusCodeNetLevel
      };
    }

    /*
    Toast
    */
    String toastInfo = "";
    if (messageNetLevel != null && messageNetLevel.isNotEmpty) {
      toastInfo = messageNetLevel;
      if (messageBusinessLevel != null && messageBusinessLevel.isNotEmpty) {
        toastInfo = messageBusinessLevel;
      }
    }
    print("toastInfo:$toastInfo");
    if (toastInfo.isNotEmpty) {
      /*
      message、reasonPhrase 都不为空的时候再提示
      */
      if (toastInfo != 'OK') {
        print("$toastInfo");
      }
    }

    /*
    Response model
    */
    ResponseModel responseModel = ResponseModel(
      statusCode: statusCodeNetLevel,
      message: toastInfo,
      data: responseObjectOfBusiness,
    );

    /*
    打印数据
     */

    /*
    Http code
    */
    if (statusCodeNetLevel == 200) {
      /*
      Business code
      */
      if (statusCodeBusinessLevel == 200) {
        /*
        Successful
        */
        responseCallback.successfulCallback(
          responseModel,
        );
      } else {
        /*
        Failure
        */
        responseCallback.failureCallback(
          responseModel,
        );
      }
    } else if (statusCodeNetLevel == 401) {
    } else {
      /*
      Failure
      */
      responseCallback.failureCallback(
        responseModel,
      );
    }

    return false;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ai_http example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
