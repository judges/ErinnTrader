
#import "ApplicationHelper.h"

@implementation ApplicationHelper

+ (NSString *)fuzzyTime:(NSDate *)datetime {
  NSString *formatted;
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
  [formatter setTimeZone:gmt];
  NSDate *date = [formatter dateFromString:[formatter stringFromDate:datetime]];
  NSDate *today = [NSDate date];
  NSInteger minutes = [today minutesAfterDate:date];
  NSInteger hours = [today hoursAfterDate:date];
  NSInteger days = [today daysAfterDate:date];
  NSString *period;
  if(days >= 365){
    int years = round(days / 365) / 2.0f;
    period = (years > 1) ? @"years" : @"year";
    formatted = [NSString stringWithFormat:@"%i %@ ago", years, period];
  } else if(days < 365 && days >= 30) {
    int months = round(days / 30) / 2.0f;
    period = (months > 1) ? @"months" : @"month";
    formatted = [NSString stringWithFormat:@"%i %@ ago", months, period];
  } else if(days < 30 && days >= 2) {
    period = @"days";
    formatted = [NSString stringWithFormat:@"%i %@ ago", days, period];
  } else if(days == 1){
    period = @"day";
    formatted = [NSString stringWithFormat:@"%i %@ ago", days, period];
  } else if(days < 1 && minutes > 60) {
    period = (hours > 1) ? @"hours" : @"hour";
    formatted = [NSString stringWithFormat:@"%i %@ ago", hours, period];
  } else {
    period = (minutes < 60 && minutes > 1) ? @"minutes" : @"minute";
    formatted = [NSString stringWithFormat:@"%i %@ ago", minutes, period];
    if(minutes < 1){
      formatted = @"a moment ago";
    }
  }
  return formatted;
}

+ (NSString *)fuzzyTimeFromString:(NSString *)datetime {
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  NSDate *date = [formatter dateFromString:datetime];
  return [ApplicationHelper fuzzyTime:date];
}

@end
