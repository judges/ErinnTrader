
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface InformationViewController : UIViewController {
 @private
  IBOutlet UIWebView *webView;
}
@property (nonatomic, retain) UIWebView *webView;
@end
