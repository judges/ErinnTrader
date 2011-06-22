
#import "CacheManager.h"

static CacheManager *_instance;

@implementation CacheManager

#pragma mark -
#pragma mark Caching Methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object 
                        change:(NSDictionary *)change
                       context:(void *)context
{
  if ([change objectForKey:NSKeyValueChangeOldKey] == [NSNull null]) {
    [self restoreCache:object keyPath:keyPath context:context defaultValue:[change objectForKey:NSKeyValueChangeNewKey]];
  }
  if ([change objectForKey:NSKeyValueChangeNewKey] == [NSNull null]) {
    [self storeCache:object keyPath:keyPath context:context value:[change objectForKey:NSKeyValueChangeOldKey]];
  }
}

- (void)restoreCache:(id)object keyPath:(NSString *)keyPath context:(NSString *)context defaultValue:(id)defaultValue {
  NSString *key = [NSString stringWithFormat:@"%@.%@", context, keyPath];
  id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
  if (value == nil) {
    [object setValue:defaultValue forKey:keyPath];
    return;
  }
  [object setValue:[NSKeyedUnarchiver unarchiveObjectWithData:value] forKey:keyPath];
}

- (void)storeCache:(id)object keyPath:(NSString *)keyPath context:(NSString *)context value:(id)value {
  NSString *key = [NSString stringWithFormat:@"%@.%@", context, keyPath];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:key];
  [defaults synchronize];
}

#pragma mark -
#pragma mark Singleton Methods

+ (CacheManager *)sharedManager {
	@synchronized(self) {
    if (_instance == nil) {
      _instance = [[self alloc] init];
    }
  }
  return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {	
  @synchronized(self) {
    if (_instance == nil) {
      _instance = [super allocWithZone:zone];			
      return _instance;    
    }
  }
  return nil;
}


- (id)copyWithZone:(NSZone *)zone {
  return self;	
}

- (id)retain {	
  return self;	
}

- (unsigned)retainCount {
  return UINT_MAX;
}

- (void)release {
  //do nothing
}

- (id)autorelease {
  return self;	
}

@end
