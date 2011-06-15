
#import "VisualEffect.h"

@interface UIView ()
- (void)growStart;
- (void)growDidEnd:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
- (void)shrinkStart;
- (void)shrinkDidEnd:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
@end

@implementation UIView (VisualEffect)

static NSMutableDictionary *_delegate = nil;

- (id)delegate {
	if (_delegate == nil){
		_delegate = [[NSMutableDictionary alloc] init];
	}
	return [_delegate objectForKey:[NSString stringWithFormat:@"%p", self]];
}

- (void)setDelegate:(id)delegate {
	if (_delegate == nil){
		_delegate = [[NSMutableDictionary alloc] init];
	}
  [_delegate setObject:delegate forKey:[NSString stringWithFormat:@"%p", self]];
}

- (void)visualEffect:(UIViewVisualEffect)effect {
  switch (effect) {
    case UIViewVisualEffectGrow:
      [self growStart];
      break;
    case UIViewVisualEffectShrink:
      [self shrinkStart];
      break;
  }
}

- (void)growStart {
	self.userInteractionEnabled = NO;
  self.transform = CGAffineTransformMakeScale(0.01, 0.01);
  [UIView beginAnimations:@"animationExpand" context:nil];
  [UIView setAnimationDuration:0.30f];
  self.transform = CGAffineTransformMakeScale(1, 1);
  
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(growDidEnd:finished:context:)];
	[UIView commitAnimations];
}

- (void)growDidEnd:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
  self.hidden = false;
	self.userInteractionEnabled = YES;
  if ([self.delegate respondsToSelector:@selector(visualEffectDidEnd:effect:)]) {
    [self.delegate visualEffectDidEnd:self effect:UIViewVisualEffectGrow];
  }
}

- (void)shrinkStart {
//	self.userInteractionEnabled = NO;
//  [UIView beginAnimations:@"animationShrink" context:nil];
//  [UIView setAnimationDuration:0.30f];
//  self.transform = CGAffineTransformMakeScale(0.01, 0.01);
//
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(shrinkDidEnd:finished:context:)];
//	[UIView commitAnimations];
  
  CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  animation.duration = 1.0f;
  animation.toValue = [NSNumber numberWithDouble:0]; 
  [self.layer addAnimation:animation forKey:@"anime"];
  
//  CATransition *animation = [CATransition animation];
//  animation.type = kCATransitionReveal;
//  animation.subtype = kCATransitionFromBottom;
//  [animation setDuration:0.8];
//  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//  [[self.navigationController.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];	
}

- (void)shrinkDidEnd:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
  self.hidden = true;
	self.userInteractionEnabled = YES;
  if ([self.delegate respondsToSelector:@selector(visualEffectDidEnd:effect:)]) {
    [self.delegate visualEffectDidEnd:self effect:UIViewVisualEffectShrink];
  }
}

@end
