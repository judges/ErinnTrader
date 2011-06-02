
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Entry : RKObject {
 @private  
  NSString *_title;
  NSString *_link;
  NSString *_author;
  NSTimeInterval _published;
}
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *link;
@property(nonatomic, retain) NSString *author;
@property(nonatomic, assign) NSTimeInterval published;
@end
