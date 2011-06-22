
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "GData.h"
#import "NSString+Encode.h"
#import "Constants.h"
#import "DetailViewController.h"
#import "Entry.h"
#import "LabeledActivityIndicatorView.h"
#import "ApplicationHelper.h"

@interface SearchResultViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource> {
 @private
  IBOutlet UISegmentedControl *_filterSegment;
  IBOutlet UITableView *_entryTable;
  LabeledActivityIndicatorView *_activityIndicator;
  NSArray *_entries;
  NSString *_server;
  NSString *_keyword;
  int _tradeType;
}
@property (nonatomic, retain) UISegmentedControl *filterSegment;
@property (nonatomic, retain) UITableView *entryTable;
@property (nonatomic, retain) LabeledActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray *entries;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, assign) int tradeType;
@end
