
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Entry : RKObject <NSCoding> {
 @private  
  NSString *_title;
  NSString *_author;
  NSString *_content;
  NSTimeInterval _published;
}
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, assign) NSTimeInterval published;
@end
