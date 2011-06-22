
#import <Foundation/Foundation.h>
#import "NSDate-Utilities.h"

@interface ApplicationHelper : NSObject {
}
+ (NSString *)fuzzyTime:(NSDate *)datetime;
+ (NSString *)fuzzyTimeFromString:(NSString *)datetime;
@end
