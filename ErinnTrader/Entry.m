
#import "Entry.h"

@interface Entry ()
@end

@implementation Entry

@synthesize title = _title;
@synthesize link = _link;
@synthesize author = _author;
@synthesize published = _published;

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Mapping Methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
          @"title",     @"title",
//          @"link",      @"link",
//          @"author",    @"name",
          @"published", @"published",
          nil];
}

@end
