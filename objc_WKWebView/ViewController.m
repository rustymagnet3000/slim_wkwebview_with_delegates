#import "ViewController.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface WKViewController () <WKUIDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (nonatomic) WKWebView *webView;
@end

static NSString *const RequestURL = @"https://www.apple.com/";

@implementation WKViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    NSLog(@"🍭viewDidLoad");
    [super viewDidLoad];
    [self setURL: RequestURL];
    NSLog(@"🍭viewDidLoad finished");
}

- (IBAction)refresh:(id)sender {
    NSLog(@"🍭refresh");
    [self.webView reload];
}

-(void)loadView{
    NSLog(@"🍭loadView");
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    config.websiteDataStore = dataStore;
    
    self.webView = [[WKWebView alloc] initWithFrame: CGRectZero
                                      configuration: config];
    self.webView.UIDelegate = self;
    self.view = self.webView;
    // self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.customUserAgent = @"YDWKDemoUserAgent";
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
