
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HouseShopItem.h"
#import "ApplicationHelper.h"

@interface HouseShopItemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
 @private
  IBOutlet UITableView *_itemTable;
  HouseShopItem *_houseShopItem;
}
@property (nonatomic, retain) UITableView *itemTable;
@property (nonatomic, assign) HouseShopItem *houseShopItem;
@end
