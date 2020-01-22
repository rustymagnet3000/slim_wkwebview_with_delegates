#import "ViewController.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface WKViewController () <WKUIDelegate, WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (nonatomic) WKWebView *webView;
@end

static NSString *const RequestURL = @"https://www.apple.com/";

@implementation WKViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"🍭viewDidLoad");
    [self setup];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
     NSLog(@"🍭viewDidAppear");
}

- (IBAction)refresh:(id)sender {
    NSLog(@"🍭refresh");
    [self.webView reload];
}

#pragma mark - Private Methods
- (void)setup {
    [self setupWebView];
    [self setURL: RequestURL];
}

- (void)setupWebView {
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    config.websiteDataStore = dataStore;
    
    self.webView = [[WKWebView alloc] initWithFrame: CGRectZero
                                      configuration: config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.customUserAgent = @"YDWKDemoUserAgent";
    [self.baseView addSubview: self.webView];
    [self setupViewConstraints: self.webView];
}

- (void)setURL:(NSString *)requestURLString {
    NSURL *url = [[NSURL alloc] initWithString: requestURLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    [self.webView loadRequest: request];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    NSLog(@"🍭challenge from: %@", [[challenge protectionSpace] host]);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, NULL);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"🍭decidePolicyForNavigationAction URL：%@", navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"🍭didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"🍭didFinishNavigation");
    [self.baseView bringSubviewToFront: self.toolBar];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"🍭didFailNavigation");
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (navigationAction.targetFrame != nil &&
        !navigationAction.targetFrame.mainFrame) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [[NSURL alloc] initWithString: navigationAction.request.URL.absoluteString]];
        [webView loadRequest: request];
        
        return nil;
    }
    return nil;
}

- (void)setupViewConstraints: (WKWebView *)webView {
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top =
    [NSLayoutConstraint constraintWithItem: webView
                                 attribute: NSLayoutAttributeTop
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self.baseView
                                 attribute: NSLayoutAttributeTop
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *bottom =
    [NSLayoutConstraint constraintWithItem: webView
                                 attribute: NSLayoutAttributeBottom
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self.baseView
                                 attribute: NSLayoutAttributeBottom
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *left =
    [NSLayoutConstraint constraintWithItem: webView
                                 attribute: NSLayoutAttributeLeft
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self.baseView
                                 attribute: NSLayoutAttributeLeft
                                multiplier: 1.0
                                  constant: 0];
    
    NSLayoutConstraint *right =
    [NSLayoutConstraint constraintWithItem: webView
                                 attribute: NSLayoutAttributeRight
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: self.baseView
                                 attribute: NSLayoutAttributeRight
                                multiplier: 1.0
                                  constant: 0];
    
    NSArray *constraints = @[top,bottom,left,right];
    
    [self.baseView addConstraints:constraints];
}

@end
