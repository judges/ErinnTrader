
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Entry.h"
#import "ApplicationHelper.h"

@interface DetailViewController : UIViewController {
 @private
  IBOutlet UILabel *titleLabel;
  IBOutlet UITextView *detailText;
}
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextView *detailText;
@property (nonatomic, assign) Entry *entry;
@end
