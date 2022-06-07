# simple_aws_translate

A Simple implementation of the AWS Translate plugin.

DISCLAIMER: This is not the AWS officialy released plugin.

## Getting Started
For now, This plugin only supports the Android platform.
I plan to add Ios support later.

To use this plugin, call `init` function with the `access key` and `secret key` that you get from AWS translation.
You only need to call the `init` function once.
```
SimpleAwsTranslate.instance.init(
        accessKey: "your access key",
        secretKey: "your secret key");
```

After you finished call `init`. You can call the static function `translateText` to translate any text you want, that function would return translated text if success.
The `from` parameter is optional, the plugin would be using ``"auto"`` as a value if you didn't set it.
```
String? result = SimpleAwsTranslate.instance.translateText(text:"Hallo bang!",from:"id",to:"en");
//String? result = SimpleAwsTranslate.instance.translateText(text:"Hallo bang!",to:"en");

if(result == null){
    print("Something went wrong");
}else{
    print("translated result is:$result");
}
```

A complete example can be found in the example.

Contributions or bug reports are welcome.

