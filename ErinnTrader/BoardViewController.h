
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GData.h"
#import "BoardSettingsViewController.h"
#import "BoardViewDataManager.h"
#import "Entry.h"

@interface BoardViewController : UIViewController <UITableViewDelegate> {
 @private
  IBOutlet BoardSettingsViewController *_boardSettingsViewController;
  IBOutlet UISegmentedControl *_filterSegment;
  IBOutlet UITableView *_entryTable;
  NSArray *_entries;
}
@property (nonatomic, retain) BoardSettingsViewController *boardSettingsViewController;
@property (nonatomic, retain) UISegmentedControl *filterSegment;
@property (nonatomic, retain) UITableView *entryTable;
@property (nonatomic, copy) NSArray *entries;
@end
