#import "YDNavDelegate.h"

@implementation YDNavDel

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [YDPrettyPrint single:NSStringFromSelector(_cmd)];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    [YDPrettyPrint single:navigationAction.request.URL.absoluteString];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    
    if ([response respondsToSelector:@selector(statusCode)]){ // required for local content
        [YDPrettyPrint multiple:@"HTTP Status: %ld", (long)response.statusCode];
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    [YDPrettyPrint multiple:@"challenge from: %@", [[challenge protectionSpace] host] ];
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, NULL);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if ([webView hasOnlySecureContent]) {
        [YDPrettyPrint single:@"OnlySecureContent loaded!"];
    } else {
        [YDPrettyPrint single:@"Mixed content mode"];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [YDPrettyPrint single:NSStringFromSelector(_cmd)];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [YDPrettyPrint single:NSStringFromSelector(_cmd)];
}

@end
