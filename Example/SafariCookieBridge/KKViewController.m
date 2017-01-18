//
//  KKViewController.m
//  SafariCookieBridge
//
//  Created by wanglin.sun on 01/18/2017.
//  Copyright (c) 2017 wanglin.sun. All rights reserved.
//

#import "KKViewController.h"
#import "SafariCookieBridge.h"

@interface KKViewController ()

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SafariCookieBridge setCookieWithName:@"userid" value:@"testValue" scheme:@"myScheme" url:@"https://mkoosun.github.com/mkoosun/SafariCookieBridge/cookie.html" timeout:30 block:^(BOOL success, NSString *value) {
        
        if(success)
            NSLog(@"Set cookie success");
        else
            NSLog(@"Set cookie fail");
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SafariCookieBridge getCookieWithName:@"userid" scheme:@"myScheme" url:@"https://mkoosun.github.com/mkoosun/SafariCookieBridge/cookie.html" timeout:10 block:^(BOOL success, NSString *value) {
            
            if(success && value) {
                NSLog(@"Get cookie userid = %@", value);
            } else {
                NSLog(@"Get cookie fail");
            }
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
