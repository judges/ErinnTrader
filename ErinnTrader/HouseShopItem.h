
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface HouseShopItem : RKObject <NSCoding> {
 @private  
  NSString *_name;
  NSString *_area;
  NSString *_item;
  NSString *_price;
  NSString *_comment;
  NSString *_coupon;
}
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *area;
@property(nonatomic, copy) NSString *item;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *comment;
@property(nonatomic, copy) NSString *coupon;
- (NSString *)formatted_price;
@end
