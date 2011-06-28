
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LabeledActivityIndicatorView.h"

@interface InformationViewController : UIViewController <UIWebViewDelegate> {
 @private
  IBOutlet UIWebView *webView;
  LabeledActivityIndicatorView *_activityIndicator;
}
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) LabeledActivityIndicatorView *activityIndicator;
@end
