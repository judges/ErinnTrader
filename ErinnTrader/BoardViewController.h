
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "GData.h"
#import "Entry.h"

typedef enum {
  ServerMari, ServerRuari, ServerTarlach, 
  ServerMorrighan, ServerCichol, ServerTriona
} Server;

@interface BoardViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate> {
 @private
  IBOutlet UITableView *_entryTable;
  NSString *_resourcePath;
  NSArray *_entries;
}
@property (nonatomic, retain) UITableView *entryTable;
@property (nonatomic, retain) NSString *resourcePath;
@property (nonatomic, copy) NSArray *entries;
@end
