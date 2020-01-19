# ai_http

![totem](https://raw.githubusercontent.com/pdliuw/pdliuw.github.io/master/images/totem_four_logo.jpg)

-----

|[English Document](https://github.com/pdliuw/ai_http/blob/master/README-EN.md)|[中文文档](https://github.com/pdliuw/ai_http)|
|:-|:-|

## Our aim is to help developers make development more convenient and experience the beauty of programming!

### ai_http:

[![pub package](https://img.shields.io/pub/v/ai_http.svg)](https://pub.dev/packages/ai_http)

*1、Support：RESTful 

*2、Support：Interceptor

*3、....

[ai_http](https://github.com/pdliuw/ai_http) 在[项目](https://github.com/flutter-app-sample/flutter_app_sample)中的实战应用[flutter sample](https://github.com/flutter-app-sample/flutter_app_sample)


## 1.Installation

Use the current package as a dependent library

### 1. Rely on this library

Add in file 'pubspec.yaml'

[![pub package](https://img.shields.io/pub/v/ai_http.svg)](https://pub.dev/packages/ai_http)

```

dependencies:

  ai_http: ^version

```

or

```

  # Http package.
  ai_http:
    git:
      url: https://github.com/pdliuw/ai_http.git

```

### 2. Install this library

You can install this library via the command line below

```

$ flutter pub get


```
You can also perform the above steps through the visual operation through the project development tool


### 3. Import this library

Now, in your Dart editing code, you can use:

```

import 'package:ai_http/ai_http.dart';

```

## 2.Usage

### 1.Global configuration

Configure in your project entry 'main.dart':


```


void main() {
  ///
  /// config ai_http
  AiHttp.globalConfig(
    baseUrl: "https://www.example.com/",
    requestInterceptor: RequestInterceptorWell(),
    responseInterceptor: ResponseInterceptorWell(),
  );

  runApp(
    ......
  );
}


```

### 2.Interceptor：

Request interceptor

```

    
    ///
    /// RequestInterceptorWell
    class RequestInterceptorWell extends RequestInterceptor {
      @override
      Future<RequestRule> interceptor(RequestRule requestRule) async {
        //do something
    
        return requestRule;
      }
    }


```

Response interceptor

```
    
    
    ///
    /// ResponseInterceptorWell
    class ResponseInterceptorWell extends ResponseInterceptor {
      @override
      interceptor(ResponseInterceptorModel responseInterceptorModel) {
        Response response = responseInterceptorModel.response;
        ResponseCallback responseCallback =
            responseInterceptorModel.responseCallback;
        OSError osError = responseInterceptorModel.osError;
    
        //do something
        
        return false;
      }
    }
    

```

### 2.Get

```

              AiHttp.get(
                requestRule: RequestRule(
                  url: "",
                  headers: {},
                  parameters: {},
                ),
                responseCallback: ResponseCallback(
                  successfulCallback: (ResponseModel successfulModel) {
                    //successful
                    //do something
                  },
                  failureCallback: (ResponseModel failureModel) {
                    //failure
                    //do something
                  },
                ),
              );

```

### 3.Post

```

              AiHttp.post(
                requestRule: RequestRule(
                  url: "",
                  headers: {},
                  body: {},
                ),
                responseCallback: ResponseCallback(
                  successfulCallback: (ResponseModel successfulModel) {
                    //successful
                    //do something
                  },
                  failureCallback: (ResponseModel failureModel) {
                    //failure
                    //do something
                  },
                ),
              );

```

### 3.Delete

```

              AiHttp.delete(
                requestRule: RequestRule(
                  url: "",
                  headers: {},
                  parameters: {},
                ),
                responseCallback: ResponseCallback(
                  successfulCallback: (ResponseModel successfulModel) {
                    //successful
                    //do something
                  },
                  failureCallback: (ResponseModel failureModel) {
                    //failure
                    //do something
                  },
                ),
              );

```

[click，see more](https://github.com/pdliuw/ai_http/blob/master/README_EN_DETAIL.md)


### TODO

* 1. ......
* 2. ......
* 3. ......


### LICENSE

```

BSD 3-Clause License

Copyright (c) 2020, pdliuw
All rights reserved.

```

[证书](https://github.com/pdliuw/ai_http/blob/master/LICENSE)