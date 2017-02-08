//
//  SafariCookieTask.m
//  Pods
//
//  Created by mkoo on 2017/1/17.
//
//

#import "SafariCookieTask.h"
#import "SafariCookieBridge.h"
#import "KKUtil.h"

@implementation SafariCookieTask

- (void) start {
    
    SFSafariViewController *safari = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:self.requestUrl]];
    //safari.delegate = self;
    safari.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    safari.view.alpha = 0.1f;
    safari.view.userInteractionEnabled = NO;
    _safariVc = safari;
    
    safari.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-1, [UIScreen mainScreen].bounds.size.height-1, 1, 1);
    safari.view.backgroundColor = [UIColor greenColor];
    
    if(_hostVc == nil) {
        _hostVc = [KKUtil getCurrentVC];
    }
    
    if(_hostVc == nil) {
        if(self.block) {
            self.block(NO, nil);
            self.block = nil;
        }
        return;
    }
    
    [_hostVc addChildViewController:safari];
    [safari didMoveToParentViewController:_hostVc];
    [_hostVc.view insertSubview:safari.view atIndex:0];
    
    if(_timeout<=0) {
        _timeout = 30;
    }
    
    __weak typeof(self) _weak_self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(_weak_self) self = _weak_self;
        
        if(self == nil) {
            return;
        }
        
        if(self.safariVc) {
            
            if(self.block) {
                self.block(NO, nil);
                self.block = nil;
            }
            [self destory];
        }
    });
}

- (void) destory {
    
    [self.safariVc willMoveToParentViewController:nil];
    [self.safariVc.view removeFromSuperview];
    [self.safariVc removeFromParentViewController];
    self.safariVc = nil;
    
    [[SafariCookieBridge sharedBridge].tasks removeObject:self];
}

- (BOOL)openURL:(NSURL *) url {
    
    if(![url.absoluteString.lowercaseString hasPrefix:self.scheme.lowercaseString]) {
        return NO;
    }
    
    NSDictionary *params = [KKUtil getURLParameters:url.absoluteString];
    NSString *queneId = [params objectForKey:@"qid"];
    if(queneId && [queneId isEqualToString:self.queneId]) {
        
        NSString *value = [params objectForKey:self.name];
        
        if(self.block) {
            self.block(YES, value);
            self.block = nil;
        }
        [self destory];
        
        return YES;
    }
    
    return NO;
}

@end
