import 'package:ai_http/ai_http.dart';
import 'package:flutter/material.dart';

///
/// TestPage
class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

///
/// _TestState
class _TestState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Column(
        children: <Widget>[
          Text("Testing..."),
          FlatButton.icon(
            onPressed: () {
              AiHttp.delete(
                requestRule: RequestRule(
                  url: "",
                  headers: {},
                  parameters: {},
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
            },
            icon: Icon(Icons.get_app),
            label: Text('Get'),
          ),
        ],
      ),
    );
  }
}
