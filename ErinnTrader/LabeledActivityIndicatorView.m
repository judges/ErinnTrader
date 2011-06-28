
#import "LabeledActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

#define Size	80

@implementation LabeledActivityIndicatorView

@synthesize parentView = _parentView;

- (LabeledActivityIndicatorView *)initWithParentView:(UIView *)view andText:(NSString *)text {
  self = [super initWithFrame:CGRectMake(0, 0, Size, Size)];
	
	if (self) {
    self.parentView = view;
		shown = NO;
		
		self.center = CGPointMake(self.parentView.bounds.size.width / 2, self.parentView.bounds.size.height / 2);
		self.clipsToBounds = YES;
		self.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.9];
		if ([self.layer respondsToSelector: @selector(setCornerRadius:)]) [(id) self.layer setCornerRadius: 10];
		self.alpha = 0.7;
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Size, Size/2)] autorelease];
    label.text = text;
		label.textColor = [UIColor whiteColor];
		label.textAlignment = UITextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: [UIFont smallSystemFontSize]];
    
    UIActivityIndicatorView *activity = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)] autorelease];
		activity.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + Size/5);
		
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    
    [self addSubview:label];
    [self addSubview:activity];
	}
	
	return self;
}

- (void) show {
	if (!shown) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		shown = YES;
		[self.parentView addSubview:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [pool release];
	}
}

- (void) hide {
	if (shown) {
		shown = NO;
		[self removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
}

- (void)dealloc {
  self.parentView = nil;
  [super dealloc];
}

@end
