//
//  SafariCookieTask.h
//  Pods
//
//  Created by mkoo on 2017/1/17.
//
//

#import <UIKit/UIKit.h>
#import <SafariServices/SFSafariViewController.h>

typedef void(^SafariCookieBlock)(BOOL success, NSString *value);

@interface SafariCookieTask : NSObject

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *requestUrl;

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) float timeout;

@property (nonatomic, weak) UIViewController *hostVc;

@property (nonatomic, strong) SFSafariViewController *safariVc;

@property (nonatomic, strong) NSString *queneId;

@property (nonatomic, strong) SafariCookieBlock block;


- (void) start;

- (BOOL)openURL:(NSURL *) url;

@end
