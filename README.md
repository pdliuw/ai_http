# ai_http

![totem](https://raw.githubusercontent.com/pdliuw/pdliuw.github.io/master/images/totem_four_logo.jpg)

-----

|[English Document](https://github.com/pdliuw/ai_http/blob/master/README_EN.md)|[中文文档](https://github.com/pdliuw/ai_http)|
|:-|:-|

## 我们的宗旨是：帮助开发者更加便利开发、切身体会编程之美！

### ai_http:

[![pub package](https://img.shields.io/pub/v/ai_http.svg)](https://pub.dev/packages/ai_http)

*1、支持：RESTful 

*2、支持：拦截器

*3、....

[ai_http](https://github.com/pdliuw/ai_http) 在[项目](https://github.com/flutter-app-sample/flutter_app_sample)中的实战应用[flutter sample](https://github.com/flutter-app-sample/flutter_app_sample)


## 1.安装

使用当前包作为依赖库

### 1. 依赖此库

在文件 'pubspec.yaml' 中添加

[![pub package](https://img.shields.io/pub/v/ai_http.svg)](https://pub.dev/packages/ai_http)

```

dependencies:

  ai_http: ^version

```

或以这种方式添加

```

  # Http package.
  ai_http:
    git:
      url: https://github.com/pdliuw/ai_http.git

```

### 2. 安装此库

你可以通过下面的命令行来安装此库

```

$ flutter pub get


```

你也可以通过项目开发工具通过可视化操作来执行上述步骤

### 3. 导入此库

现在，在你的Dart编辑代码中，你可以使用：

```

import 'package:ai_http/ai_http.dart';

```

## 2.使用

### 1.全局配置

* 在你的项目入口'main.dart'中配置：


```


void main() {
  ///
  /// 配置Http
  AiHttp.globalConfig(
    baseUrl: "https://www.baidu.com/",
    requestInterceptor: RequestInterceptorWell(),
    responseInterceptor: ResponseInterceptorWell(),
  );

  runApp(
    ......
  );
}


```

### 2.拦截器：

请求拦截器

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

响应拦截器

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

### 3.请求方式：

#### 1.Get

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

#### 2.Post

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

#### 3.Delete

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

意犹未尽[点击，查看更多](https://github.com/pdliuw/ai_http/blob/master/README_DETAIL.md)


### 待办

* 1. ......
* 2. ......
* 3. ......


### 证书

```

BSD 3-Clause License

Copyright (c) 2020, pdliuw
All rights reserved.

```

[证书](https://github.com/pdliuw/ai_http/blob/master/LICENSE)