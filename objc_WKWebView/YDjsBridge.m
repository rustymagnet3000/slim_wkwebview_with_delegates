#import "YDjsBridge.h"
#import "YDPrettyPrint.h"

@implementation YDJSBridge

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [YDPrettyPrint single:NSStringFromSelector(_cmd)];
    NSArray *arrayFromJS = [message.body mutableCopy];
    
    if([[message name]  isEqual: @"jsHandler"]) {
                
        if ([arrayFromJS isKindOfClass:[NSArray class]]){
            for (id i in arrayFromJS) {
                [YDPrettyPrint single:i];
            }
        } else {
            [YDPrettyPrint single:@"🐝Couldn't cast WKScriptMessage to Array. Was the J/S passing in an array?"];
            return;
        }
    }
}

@end
