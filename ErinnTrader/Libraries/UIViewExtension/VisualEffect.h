
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
  UIViewVisualEffectGrow, UIViewVisualEffectShrink
} UIViewVisualEffect;

@protocol VisualEffectDelegate <NSObject>
@optional
- (void)visualEffectDidEnd:(id)sender effect:(UIViewVisualEffect)effect;
@end

@interface UIView (VisualEffect)
- (id)delegate;
- (void)setDelegate:(id)delegate;
- (void)visualEffect:(UIViewVisualEffect)effect;
@end
