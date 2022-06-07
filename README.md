# simple_aws_translate

A Simple implementation of the AWS Translate plugin

DISCLAIMER: This is not the AWS officialy released plugin!

## Getting Started
This plugin only supports the Android platform for now.
Ios support will come later.

To use this plugin, call init with the access key and secret key that you get from AWS translation.
You only need to call the init function once.
```
SimpleAwsTranslate.instance.init(
        accessKey: "your access key",
        secretKey: "your secret key");
```

After you finished call init. You can call the static function translateText to translate any text you want, that function would return translated text if success.
```
String? result = SimpleAwsTranslate.instance.translateText(text:"Hallo bang!",from:"id",to:"en");
if(result == null){
    print("Something went wrong");
}else{
    print("translated result is:$result");
}
```

A complete example can be found in the example.
Contributions or bug reports are welcome.

