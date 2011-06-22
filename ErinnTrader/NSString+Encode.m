
#import "NSString+Encode.h"

@implementation NSString (encode)
- (NSString *)encodeString:(NSStringEncoding)encoding {
  return (NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                              NULL, (CFStringRef)@";/?:@&=$+{}<>,",
                                                              CFStringConvertNSStringEncodingToEncoding(encoding));
}  
@end
