
#import "CreditViewController.h"

@interface CreditViewController ()
@end

@implementation CreditViewController

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

#pragma mark -
#pragma mark Inherit Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    [self initNavigationBar];
  }
  return self;
}

- (void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBarHidden = NO;
  self.navigationController.toolbarHidden = YES;
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
  [UIView beginAnimations:nil context:NULL]; 
  [UIView setAnimationDuration:0.5]; 
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES]; 
  [UIView commitAnimations];
  [self.navigationController popViewControllerAnimated:NO];
}

@end
