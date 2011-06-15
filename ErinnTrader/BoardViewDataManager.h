
#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Entry.h"

typedef enum {
  ServerMari, ServerRuari, ServerTarlach, 
  ServerMorrighan, ServerCichol, ServerTriona
} Server;

@interface BoardViewDataManager : NSObject <RKObjectLoaderDelegate> {
 @private
  BOOL _isLoading;
  NSArray *_entries;
  NSString *_resourcePath;
}
+ (BoardViewDataManager *)sharedManager;
- (BOOL)isLoading;
- (NSArray *)filteredEntries;
- (void)reloadData;
- (void)changeServerTo:(Server)server;
@end
