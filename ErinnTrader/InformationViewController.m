
#import "InformationViewController.h"

static NSString* const kInfoURL = @"http://cohakim.github.com/ErinnTrader/mobile-index.html";

@interface InformationViewController ()
@end

@implementation InformationViewController

@synthesize webView;
@synthesize activityIndicator = _activityIndicator;

#pragma mark -
#pragma mark Private Methods

- (void)initNavigationBar {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"launcher.png"] 
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self   
                                                                          action:@selector(backButtonTouched)];
  self.navigationController.navigationBarHidden = NO;
  self.navigationController.toolbarHidden = YES;
}

- (void)initWebView {
  NSURL *url = [[[NSURL alloc] initWithString:kInfoURL] autorelease];
  NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:url 
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                             timeoutInterval:15] autorelease];
  
  [self.webView loadRequest:request];
}

- (void)initActivityIndicator {
  self.activityIndicator = [[LabeledActivityIndicatorView alloc] initWithParentView:self.view andText:@"Loading"];
}

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
  [self initNavigationBar];
  [self initActivityIndicator];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initWebView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.webView.delegate = nil;
  self.webView = nil;
  self.activityIndicator = nil;
  [super dealloc];
}

#pragma mark -
#pragma EventHandling Methods

- (IBAction)backButtonTouched {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey:@"transitionViewAnimation"];	
  [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -
#pragma UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *compURL = @"http://itunes.apple.com/";
  if(NSOrderedSame == [[[request URL] absoluteString] compare:compURL options:NSCaseInsensitiveSearch range:NSMakeRange(0,[compURL length])]) {
    [[UIApplication sharedApplication] openURL:[request URL]];
  }
  return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [self.activityIndicator performSelectorInBackground:@selector(show) withObject:nil];
  [self.webView resignFirstResponder];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self.activityIndicator hide];
}

@end
