#import "ViewController.h"
#import "YDNavDel.h"


@interface WKViewController ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) YDNavDel *customDel;

@end

static NSString *const RequestURL = @"https://www.apple.com/";

@implementation WKViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {

    [super viewDidLoad];
    [self setURL: RequestURL];
}

- (IBAction)refresh:(id)sender {
    NSLog(@"🍭refresh");
    [self.webView reload];
}

-(void)loadView{

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebsiteDataStore *dataStore = [WKWebsiteDataStore defaultDataStore];
    config.websiteDataStore = dataStore;
    
    self.webView = [[WKWebView alloc] initWithFrame: CGRectZero
                                      configuration: config];

    self.webView.allowsBackForwardNavigationGestures = YES;

    self.customDel = [[YDNavDel alloc] init];
    self.webView.navigationDelegate = self.customDel;

    if([self.webView.navigationDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        NSLog(@"🍭navigationDelegate setup");
    }
    
    self.view = self.webView;


    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshBtn;
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
