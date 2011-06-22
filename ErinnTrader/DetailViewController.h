
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Entry.h"

@interface DetailViewController : UIViewController {
 @private
  IBOutlet UILabel *titleLabel;
  IBOutlet UITextView *detailText;
}
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextView *detailText;
@property (nonatomic, retain) Entry *entry;
@end
