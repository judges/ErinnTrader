
#import "DetailViewController.h"

@implementation DetailViewController

@synthesize titleLabel;
@synthesize detailText;
@synthesize entry;

#pragma mark -
#pragma mark Inherit Methods

-(void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.titleLabel.text = entry.title;
  self.detailText.text = entry.content;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.entry = nil;
  [super dealloc];
}

@end
