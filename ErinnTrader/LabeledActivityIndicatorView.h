
#import <Foundation/Foundation.h>

@interface LabeledActivityIndicatorView : UIView {
 @private
  UIView *_parentView;
  BOOL shown;
}
@property (nonatomic, retain) UIView *parentView;
- (LabeledActivityIndicatorView *) initWithParentView:(UIView *)view andText:(NSString *)text;
- (void) show;
- (void) hide;

@end
