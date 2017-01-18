# SafariCookieBridge
SafariCookieBridge can get data from Safari's Cookie, and also set data to Cookie. Very convenient to transfer data between App and Web, even if App is not installed. You can fetch cookie data after user install your App, and let user continue to do something that he want do in Web Page

## Installation

SafariCookieBridge is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SafariCookieBridge"
```

## Usage

1. Put `cookie.html` on your server, for example: 
> http://yourserver.com/cookie.html`

2. Add a scheme to the project, for example: 
> myScheme

3. Call `SafariCookieBridge.openURL` in `AppDelegate.m`

```
-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    
    return [SafariCookieBridge openURL:url];
}
```

### Set Cookie
```
[SafariCookieBridge setCookieWithName:@"userid" value:@"testValue" scheme:@"myScheme" url:@"http://yourserver.com/cookie.html" timeout:30 block:^(BOOL success, NSString *value) {
   
    if(success)
        NSLog(@"Set cookie success");
    else
        NSLog(@"Set cookie fail");
}];

```

### Get Cookie
```
[SafariCookieBridge getCookieWithName:@"userid" scheme:@"myScheme" url:@"http://yourserver.com/cookie.html" timeout:10 block:^(BOOL success, NSString *value) {
    
    if(success && value) {
        NSLog(@"Get cookie userid = %@", value);
    } else {
        NSLog(@"Get cookie fail");
    }
}];
```

## Author

wanglin.sun, mkoosun@gmail.com

## License

SafariCookieBridge is available under the MIT license. See the LICENSE file for more info.
