#import "YDUIDelegate.h"


@implementation YDUIDel

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
        [YDPrettyPrint single:NSStringFromSelector(_cmd)];
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"FooBar title" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        [self customHandler];
    }]];
    
    UIViewController *presentedVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [presentedVC presentViewController:ac animated:TRUE completion:NULL];
    
    NSString *jscode = @"console.log('Hello World')";
    [webView evaluateJavaScript:jscode completionHandler:NULL];

    completionHandler();
}

-(void) customHandler {
    [YDPrettyPrint single:@"🐝in custom Handler. Invoked from UIAlertAction"];
}


@end
