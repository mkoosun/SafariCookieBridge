//
//  SafariCookieService.m
//  Pods
//
//  Created by mkoo on 2017/1/17.
//
//

#import "SafariCookieBridge.h"
#import "KKUtil.h"

@interface SafariCookieBridge()
@property (nonatomic, assign) NSInteger taskCount;
@end


@implementation SafariCookieBridge

+ (instancetype) sharedBridge {
    static SafariCookieBridge *bridge;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bridge = [SafariCookieBridge new];
    });
    return bridge;
}

- (NSMutableArray*) tasks {
    if(_tasks == nil)
        _tasks = [NSMutableArray new];
    return _tasks;
}

+ (BOOL) openURL:(NSURL *)url {
    
    SafariCookieBridge *bridge = [SafariCookieBridge sharedBridge];
    
    for(SafariCookieTask *task in bridge.tasks) {
        if([task openURL:url])
            return YES;
    }
    return NO;
}

+ (void) getCookieWithName:(NSString*)name scheme:(NSString*)scheme url:(NSString*)url viewController:(UIViewController*)viewController timeout:(NSTimeInterval)timeout block:(SafariCookieBlock)block {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        block(NO, nil);
        return;
    }
    
    if(!name || !scheme || !url) {
        block(NO, nil);
        return;
    }
    
    SafariCookieBridge *bridge = [SafariCookieBridge sharedBridge];
    SafariCookieTask *task = [SafariCookieTask new];
    [bridge.tasks addObject:task];
    
    task.url = url;
    task.queneId = [@(bridge.taskCount ++) stringValue];
    task.scheme = scheme;
    task.name = name;
    task.hostVc = viewController;
    if(timeout>0)
        task.timeout = timeout;
    else
        task.timeout = 30;
    
    NSString *nameParam = [KKUtil urlEncode:name];
    NSString *schemeParam = [KKUtil urlEncode:scheme];
    
    task.requestUrl = [NSString stringWithFormat:@"%@?qid=%@&scheme=%@&action=get&name=%@", url, task.queneId, schemeParam, nameParam];
    task.block = block;
    task.safariVc = nil;
    
    [task performSelector:@selector(start) withObject:nil afterDelay:0.1];
}

+ (void) setCookieWithName:(NSString*)name value:(NSString*)value scheme:(NSString*)scheme url:(NSString*)url viewController:(UIViewController*)viewController timeout:(NSTimeInterval)timeout block:(SafariCookieBlock)block {

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        return;
    }
    
    if(!name || !value || !scheme || !url) {
        return;
    }
    
    SafariCookieBridge *bridge = [SafariCookieBridge sharedBridge];
    SafariCookieTask *task = [SafariCookieTask new];
    [bridge.tasks addObject:task];
    
    task.url = url;
    task.queneId = [@(bridge.taskCount ++) stringValue];
    task.scheme = scheme;
    task.name = name;
    task.hostVc = viewController;
    if(timeout>0)
        task.timeout = timeout;
    else
        task.timeout = 30;
    
    NSString *nameParam = [KKUtil urlEncode:name];
    NSString *schemeParam = [KKUtil urlEncode:scheme];
    NSString *valueParam = [KKUtil urlEncode:value];
    
    task.requestUrl = [NSString stringWithFormat:@"%@?qid=%@&scheme=%@&action=set&name=%@&value=%@", url, task.queneId, schemeParam, nameParam, valueParam];
    task.block = block;
    task.safariVc = nil;
    
    [task performSelector:@selector(start) withObject:nil afterDelay:0.1];
}


@end
