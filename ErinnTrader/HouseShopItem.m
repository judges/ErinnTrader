
#import "HouseShopItem.h"

@interface HouseShopItem ()
@end

@implementation HouseShopItem

@synthesize name = _name;
@synthesize area = _area;
@synthesize item = _item;
@synthesize price = _price;
@synthesize comment = _comment;
@synthesize coupon = _coupon;

#pragma mark -
#pragma mark Accessor Methods

- (NSString *)formatted_price {
  int price = [[self.price stringByReplacingOccurrencesOfString:@"," 
                                                     withString:@""] floatValue];
  NSString *formatted;
  if (price < 1000) {
    formatted = [NSString stringWithFormat:@"%d", price];
  }
  else if (price < 1000000) {
    formatted = [NSString stringWithFormat:@"%dK", price / 1000];
  }
  else {
    NSDecimalNumber *decimalPrice = 
      [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:price] decimalValue]];
    float floatPrice = 
      [[decimalPrice decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"1000000"]] floatValue];
    formatted = [NSString stringWithFormat:@"%.1fM", floatPrice];
  }
  return formatted;
}

#pragma mark -
#pragma mark Mapping Methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
          @"name",    @"name",
          @"area",    @"area",
          @"item",    @"item",
          @"price",   @"price",
          @"comment", @"comment",
          @"coupon",  @"coupon",
          nil];
}

#pragma -
#pragma Inheritance Methods

- (id)initWithCoder:(NSCoder *)coder {
  self.name = [coder decodeObjectForKey:@"name"];
  self.area = [coder decodeObjectForKey:@"area"];
  self.item = [coder decodeObjectForKey:@"item"];
  self.price = [coder decodeObjectForKey:@"price"];
  self.comment = [coder decodeObjectForKey:@"comment"];
  self.coupon = [coder decodeObjectForKey:@"coupon"];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:@"name"];
  [encoder encodeObject:self.area forKey:@"area"];
  [encoder encodeObject:self.item forKey:@"item"];
  [encoder encodeObject:self.price forKey:@"price"];
  [encoder encodeObject:self.comment forKey:@"comment"];
  [encoder encodeObject:self.coupon forKey:@"coupon"];
}

- (void)dealloc {
  self.name = nil;
  self.area = nil;
  self.item = nil;
  self.price = nil;
  self.comment = nil;
  self.coupon = nil;
	[super dealloc];
}

@end
