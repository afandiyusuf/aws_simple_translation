import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_aws_translate/simple_aws_translate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    SimpleAwsTranslate.instance.init(
        accessKey: "your access key",
        secretKey: "your secret key");
  }

  TextEditingController textController = TextEditingController();
  String resultText = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(labelText: "Input"),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        resultText = "Translating...";
                      });
                      String? result = await SimpleAwsTranslate.instance.translateText(textController.text, to: "id");
                      if(result != null){
                        resultText = result;
                      }else{
                        resultText = "Something went wrong";
                      }
                      setState(() {
                      });
                    },
                    child: Text(
                      "Translate",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),

                  Text("Translated Text: $resultText")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
