
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "NSString+Encode.h"
#import "HouseShopItemViewController.h"
#import "Constants.h"
#import "HouseShopItem.h"
#import "LabeledActivityIndicatorView.h"
#import "ApplicationHelper.h"

@interface HouseShopSearchResultViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource> {
 @private
  IBOutlet UITableView *_itemTable;
  LabeledActivityIndicatorView *_activityIndicator;
  NSArray *_items;
  int _server;
  NSString *_keyword;
}
@property (nonatomic, retain) UITableView *itemTable;
@property (nonatomic, retain) LabeledActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) int server;
@property (nonatomic, copy) NSString *keyword;
@end
