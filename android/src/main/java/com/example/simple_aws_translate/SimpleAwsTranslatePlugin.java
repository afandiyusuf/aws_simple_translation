package com.example.simple_aws_translate;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.handlers.AsyncHandler;
import com.amazonaws.services.translate.AmazonTranslateAsyncClient;
import com.amazonaws.services.translate.model.TranslateTextRequest;
import com.amazonaws.services.translate.model.TranslateTextResult;

/** SimpleAwsTranslatePlugin */
public class SimpleAwsTranslatePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "simple_aws_translate");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("translateText")) {
      String accessKey = call.argument("accessKey");
      String secretKey = call.argument("secretKey");
      AWSCredentials awsCredentials = new AWSCredentials() {
        @Override
        public String getAWSAccessKeyId() {
          return accessKey;
        }

        @Override
        public String getAWSSecretKey() {
          return secretKey;
        }
      };
      AmazonTranslateAsyncClient translateAsyncClient = new AmazonTranslateAsyncClient(awsCredentials);
      TranslateTextRequest translateTextRequest = new TranslateTextRequest()
              .withText(call.argument("text"))
              .withSourceLanguageCode(call.argument("from"))
              .withTargetLanguageCode(call.argument("to"));
      translateAsyncClient.translateTextAsync(translateTextRequest,new AsyncHandler<TranslateTextRequest,TranslateTextResult>(){

        @Override
        public void onError(Exception exception) {
          result.error(exception.getMessage(),"",null);
        }

        @Override
        public void onSuccess(TranslateTextRequest request, TranslateTextResult translateTextResult) {
          result.success(translateTextResult.getTranslatedText());
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
