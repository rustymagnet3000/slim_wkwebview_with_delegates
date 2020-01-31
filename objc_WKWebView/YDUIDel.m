#import "YDUIDel.h"

@implementation YDUIDel

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
        NSLog(@"🐝%@", NSStringFromSelector(_cmd));
    
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
    NSLog(@"🐝in custom Handler. Invoked from UIAlertAction");
}

- (void)webViewDidClose:(WKWebView *)webView{
    NSLog(@"🐝webViewDidClose");
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
