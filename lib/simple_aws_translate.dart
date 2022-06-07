
import 'dart:async';

import 'package:flutter/services.dart';

class SimpleAwsTranslate {
  SimpleAwsTranslate._privateConstructor();
  static final SimpleAwsTranslate _instance = SimpleAwsTranslate._privateConstructor();
  static SimpleAwsTranslate get instance => _instance;

  static const MethodChannel _channel = MethodChannel('simple_aws_translate');
  String? _accessKey;
  String? _secretKey;
  void init({required String accessKey, required String secretKey}){
    instance._accessKey = accessKey;
    instance._secretKey = secretKey;
  }

  Future<String?> translateText(String text, {required to, String from="auto"}) async{
    var args = {
      "accessKey":instance._accessKey,
      "secretKey":instance._secretKey,
      "from":from,
      "to":to,
      "text":text
    };


    String? result = await _channel.invokeMethod("translateText", args);
    return result;
  }
}


