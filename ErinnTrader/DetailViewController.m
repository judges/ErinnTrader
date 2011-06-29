
#import "DetailViewController.h"

@interface DetailViewController ()
- (void)initTitleLabel;
- (void)initDetailText;
@end

@implementation DetailViewController

@synthesize titleLabel;
@synthesize detailText;
@synthesize entry;

#pragma mark -
#pragma mark Private Methods

- (void)initTitleLabel {
  CGFloat baseWidth = self.titleLabel.frame.size.width - 14;
  
  CGSize ts1 = [entry.title sizeWithFont:[UIFont systemFontOfSize:13]
                       constrainedToSize:CGSizeMake(baseWidth, [[UIFont systemFontOfSize:13] lineHeight])
                           lineBreakMode:UILineBreakModeTailTruncation];  
  CGSize ts2 = [entry.author sizeWithFont:[UIFont systemFontOfSize:11]
                        constrainedToSize:CGSizeMake(baseWidth, [[UIFont systemFontOfSize:11] lineHeight])
                            lineBreakMode:UILineBreakModeTailTruncation];
  
  UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(7, 7, baseWidth, ts1.height)] autorelease];
  textLabel.font = [UIFont systemFontOfSize:13];
  textLabel.text = entry.title;
  textLabel.lineBreakMode = UILineBreakModeTailTruncation;

  UILabel *detailTextLabel = [[[UILabel alloc] initWithFrame:CGRectMake(7, ts1.height + 7, baseWidth, ts2.height)] autorelease];
  detailTextLabel.font = [UIFont systemFontOfSize:11];
  detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
  detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", 
                          entry.author, [ApplicationHelper fuzzyTime:[NSDate dateWithTimeIntervalSince1970:entry.published]]];
  detailTextLabel.textColor = [UIColor lightGrayColor];

  [self.titleLabel addSubview:textLabel];
  [self.titleLabel addSubview:detailTextLabel];
}

- (void)initDetailText {
  self.detailText.text = entry.content;
}

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initTitleLabel];
  [self initDetailText];
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

@end
