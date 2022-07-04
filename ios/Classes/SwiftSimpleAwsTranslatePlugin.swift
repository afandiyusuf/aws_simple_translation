import Flutter
import UIKit
import AWSTranslate

public class SwiftSimpleAwsTranslatePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "simple_aws_translate", binaryMessenger: registrar.messenger())
    let instance = SwiftSimpleAwsTranslatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    self.translateText(result:result, args:call.arguments);
  }

  public func translateText(result: @escaping FlutterResult, args: Any?) {
      let argsMap = args as! [String: Any]
    let accessKey = argsMap["accessKey"] as? String
    let secretKey = argsMap["secretKey"] as? String
    var credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey!, secretKey: secretKey!)

      var configuration = AWSServiceConfiguration(region: AWSRegionType.APSoutheast1, credentialsProvider: credentialsProvider)

    AWSServiceManager.default().defaultServiceConfiguration = configuration

    let translateClient = AWSTranslate.default()
    let translateRequest = AWSTranslateTranslateTextRequest()
    translateRequest?.sourceLanguageCode = argsMap["from"] as? String
    translateRequest?.targetLanguageCode = argsMap["to"] as? String
    translateRequest?.text = argsMap["text"] as? String

    let callback: (AWSTranslateTranslateTextResponse?, Error?) -> Void = { (response, error) in
      guard let response = response else {
          result(nil)
          return
      }
                
      if let translatedText = response.translatedText {
          result(translatedText)
      }
    }
            
    translateClient.translateText(translateRequest!, completionHandler: callback)
  }
}
