
#import "LauncherViewController.h"

@interface LauncherViewController ()
- (void)initNavigationBar;
@end

@implementation LauncherViewController

#pragma -
#pragma Private Methods

- (void)initNavigationBar {
  self.navigationController.navigationBarHidden = YES;
  self.navigationController.toolbarHidden = YES;
}

#pragma -
#pragma Inheritance Methods

- (void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self initNavigationBar];
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

#pragma -
#pragma Touch Event Handlers

- (IBAction)informationButtonTouched:(id)sender {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];	
  
  InformationViewController *informationViewController = 
    [[[InformationViewController alloc] initWithNibName:@"InformationView" bundle:nil] autorelease];
  [self.navigationController pushViewController:informationViewController animated:NO];
}

- (IBAction)officialButtonTouched:(id)sender {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];	
  
  BoardViewController *boardViewController = 
    [[[BoardViewController alloc] initWithNibName:@"BoardView" bundle:nil] autorelease];
  [self.navigationController pushViewController:boardViewController animated:NO];
}

- (IBAction)erinnButtonTouched:(id)sender {
}

- (IBAction)supplyButtonTouched:(id)sender {
}

- (IBAction)settingsButtonTouched:(id)sender {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];	

  AppSettingsViewController *appSettingsViewController = 
    [[[AppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil] autorelease];
  [self.navigationController pushViewController:appSettingsViewController animated:NO];
  self.navigationController.navigationBarHidden = NO;
}

- (IBAction)creditButtonTouched:(id)sender {
  CreditViewController *viewController = 
    [[[CreditViewController alloc] initWithNibName:@"CreditView" bundle:nil] autorelease];
  [UIView beginAnimations:nil context:NULL]; 
  [UIView setAnimationDuration:0.5]; 
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES]; 
  [UIView commitAnimations]; 
  [self.navigationController pushViewController:viewController animated:NO];
}

@end
