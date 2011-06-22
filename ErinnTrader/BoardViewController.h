
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>
#import "EGORefreshTableHeaderView.h"
#import "Constants.h"
#import "SearchResultViewController.h"
#import "DetailViewController.h"
#import "CacheManager.h"
#import "Entry.h"
#import "ApplicationHelper.h"

@interface BoardViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, UISearchDisplayDelegate, UISearchBarDelegate> {
 @private
  IBOutlet UISearchBar *_searchBar;
  IBOutlet UISegmentedControl *_filterSegment;
  IBOutlet UITableView *_entryTable;
  EGORefreshTableHeaderView *_refreshHeaderView;
 	BOOL _reloading;
  NSArray *_entries;
  int _server;
  int _tradeType;
  NSDate *_lastUpdated;
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISegmentedControl *filterSegment;
@property (nonatomic, retain) UITableView *entryTable;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, copy) NSArray *entries;
@property (nonatomic, assign) int server;
@property (nonatomic, assign) int tradeType;
@property (nonatomic, retain) NSDate *lastUpdated;
@end
