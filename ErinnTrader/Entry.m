
#import "Entry.h"

@interface Entry ()
- (NSString *)contentWithoutNoisyString;
@end

@implementation Entry

@synthesize title = _title;
@synthesize author = _author;
@synthesize content = _content;
@synthesize published = _published;

#pragma mark -
#pragma mark Private Methods

- (NSString *)contentWithoutNoisyString {
  if (_content == nil) {
    return nil;
  }
  NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"\n------------------------------\n(.+)$"
                                                                          options:0
                                                                            error:nil];
  NSString *replaced = [regexp stringByReplacingMatchesInString:_content
                                                        options:0
                                                          range:NSMakeRange(0, [_content length])
                                                   withTemplate:@""];
  return [replaced stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)content {
  return [self contentWithoutNoisyString];
}

#pragma mark -
#pragma mark Mapping Methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
          @"title",     @"title",
          @"author",    @"author",
          @"content",   @"content",
          @"published", @"published",
          nil];
}

#pragma -
#pragma Inheritance Methods

- (id)initWithCoder:(NSCoder *)coder {
  self.title = [coder decodeObjectForKey:@"title"];
  self.author = [coder decodeObjectForKey:@"author"];
  self.content = [coder decodeObjectForKey:@"content"];
  self.published = [coder decodeIntegerForKey:@"published"];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.title forKey:@"title"];
  [encoder encodeObject:self.author forKey:@"author"];
  [encoder encodeObject:self.content forKey:@"content"];
  [encoder encodeInteger:self.published forKey:@"published"];
}

- (void)dealloc {
  self.title = nil;
  self.author = nil;
  self.content = nil;
	[super dealloc];
}

@end
