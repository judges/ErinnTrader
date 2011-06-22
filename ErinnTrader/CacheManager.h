
#import <Foundation/Foundation.h>

@interface CacheManager : NSObject {
}
+ (CacheManager *) sharedManager;
- (void)restoreCache:(id)object keyPath:(NSString *)keyPath context:(NSString *)context defaultValue:(id)defaultValue;
- (void)storeCache:(id)object keyPath:(NSString *)keyPath context:(NSString *)context value:(id)value;
@end
