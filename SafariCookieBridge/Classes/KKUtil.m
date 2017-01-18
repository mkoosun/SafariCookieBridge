//
//  KKUtil.m
//  Pods
//
//  Created by mkoo on 2017/1/18.
//
//

#import "KKUtil.h"

@implementation KKUtil

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSString*) urlEncode:(NSString*)params {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return [params stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    } else {
        return [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (NSString*) urlDecode:(NSString*)params {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return [params stringByRemovingPercentEncoding];
    } else {
        return [params stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (NSMutableDictionary *)getURLParameters:(NSString*) url {
    
    NSRange range = [url rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *parametersString = [url substringFromIndex:range.location + 1];
    NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents) {
        
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        if(pairComponents.count!=2) {
            continue;
        }
        
        NSString *key = pairComponents.firstObject;
        NSString *value = pairComponents.lastObject;
        
        if (key == nil || value == nil) {
            continue;
        }
        
        value = [self urlDecode:value];
        
        id existValue = [params valueForKey:key];
        
        if (existValue != nil) {
            
            if ([existValue isKindOfClass:[NSArray class]]) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                [items addObject:value];
                
                [params setValue:items forKey:key];
            } else {
                [params setValue:@[existValue, value] forKey:key];
            }
        } else {
            [params setValue:value forKey:key];
        }
    }
    
    return params;
}


@end
