#import "ViewController.h"
#import "YDNavDel.h"
#import "YDUIDel.h"

@interface WKViewController () <WKScriptMessageHandler>

@property (nonatomic) WKWebView *webView;
@property (nonatomic) YDNavDel *customNavDel;
@property (nonatomic) YDUIDel *customUIDel;
@end

@implementation WKViewController

NSString static *RequestURL = @"https://www.apple.com/";

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    NSLog(@"🍭viewDidLoad");
    [super viewDidLoad];
    [self setURL: RequestURL];
}

- (IBAction)refresh:(id)sender {
    NSLog(@"🍭refresh");
    [self.webView reload];
}

- (IBAction)localFile:(id)sender {
    NSLog(@"🍭load local file");
    NSURL *bundleURL = [[[NSBundle mainBundle]resourceURL] absoluteURL];
    NSURL *fileURL = [bundleURL URLByAppendingPathComponent:@"local.html"];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:bundleURL];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

    if([[message name]  isEqual: @"jsHandler"]) {
        NSLog(@"🍭Inside userContentController and jsHandler");
        NSLog(@"%@", [message body]);
    }
}

-(void)loadView{

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addScriptMessageHandler:self name:@"jsHandler"];
    config.userContentController = userController;

    WKPreferences *prefs = [[WKPreferences alloc] init];
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    config.websiteDataStore = dataStore;
    config.preferences = prefs;

    
    self.webView = [[WKWebView alloc] initWithFrame: CGRectZero
                                      configuration: config];

    self.webView.allowsBackForwardNavigationGestures = YES;

    self.customNavDel = [[YDNavDel alloc] init];
    self.customUIDel = [[YDUIDel alloc] init];
    
    self.webView.navigationDelegate = self.customNavDel;
    self.webView.UIDelegate = self.customUIDel;
    
    if([self.webView.navigationDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        NSLog(@"🍭navigationDelegate setup");
    }
    
    self.view = self.webView;


    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    UIBarButtonItem *fileBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(localFile:)];
    self.navigationItem.rightBarButtonItem = refreshBtn;
    self.navigationItem.leftBarButtonItem = fileBtn;
}

#pragma mark - Private Methods

- (void)setURL:(NSString *)requestURLString {
    NSURL *url = [[NSURL alloc] initWithString: requestURLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    [self.webView loadRequest: request];
}

@end
