//
//  SafariCookieService.h
//  Pods
//
//  Created by mkoo on 2017/1/17.
//
//

#import <Foundation/Foundation.h>
#import "SafariCookieTask.h"

@interface SafariCookieBridge : NSObject

@property (nonatomic, strong) NSMutableArray <SafariCookieTask *> *tasks;


+ (instancetype) sharedBridge;

//Should by called in AppDelegate.m `+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options`
+ (BOOL) openURL:(NSURL *)url;

+ (void) getCookieWithName:(NSString*)name scheme:(NSString*)scheme url:(NSString*)url viewController:(UIViewController*)viewController timeout:(NSTimeInterval)timeout block:(SafariCookieBlock)block;

+ (void) setCookieWithName:(NSString*)name value:(NSString*)value scheme:(NSString*)scheme url:(NSString*)url viewController:(UIViewController*)viewController timeout:(NSTimeInterval)timeout block:(SafariCookieBlock)block;

@end
