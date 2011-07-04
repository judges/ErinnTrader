
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>
#import "EGORefreshTableHeaderView.h"
#import "HouseShopItemViewController.h"
#import "HouseShopSearchResultViewController.h"
#import "Constants.h"
#import "CacheManager.h"
#import "HouseShopItem.h"
#import "ApplicationHelper.h"

@interface HouseShopViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, UISearchDisplayDelegate, UISearchBarDelegate> {
 @private
  IBOutlet UISearchBar *_searchBar;
  IBOutlet UITableView *_itemTable;
  EGORefreshTableHeaderView *_refreshHeaderView;
 	BOOL _reloading;
  NSArray *_items;
  int _server;
  NSDate *_lastUpdated;
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *itemTable;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) int server;
@property (nonatomic, copy) NSDate *lastUpdated;
@end
