#import "YDjsBridge.h"

@implementation YDJSBridge

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{


    
    if([[message name]  isEqual: @"jsHandler"]) {
        NSLog(@"🍭Inside userContentController and jsHandler");
        NSLog(@"%@", [message body]);
    }
}

@end
