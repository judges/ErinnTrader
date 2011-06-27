
#import "InformationViewController.h"

static NSString* const kInfoURL = @"http://cohakim.github.com/ErinnTrader/m/information.html";

@interface InformationViewController ()
@end

@implementation InformationViewController

@synthesize webView;

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
  NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:url] autorelease];
  [self.webView loadRequest:request];
}

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
  [self initNavigationBar];
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

@end
