
#import "AppSettingsViewController.h"

@implementation AppSettingsViewController

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
  self.delegate = self;
  self.showDoneButton = YES;
  self.showCreditsFooter = NO;
  [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [super dealloc];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey:@"transitionViewAnimation"];	
  [self.navigationController popViewControllerAnimated:NO];
}


@end
