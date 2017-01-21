//
//  KKUtil.h
//  Pods
//
//  Created by mkoo on 2017/1/18.
//
//

#import <UIKit/UIKit.h>

@interface KKUtil : NSObject

+ (UIViewController *)getCurrentVC;

+ (NSString*) urlEncode:(NSString*)params;

+ (NSString*) urlDecode:(NSString*)params;

+ (NSMutableDictionary *)getURLParameters:(NSString*) url;

@end
