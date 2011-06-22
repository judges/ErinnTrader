
#import <UIKit/UIKit.h>
#import "LauncherViewController.h"
#import "BoardViewController.h"
#import "Entry.h"

@interface ErinnTraderAppDelegate : NSObject <UIApplicationDelegate> {
 @private
  IBOutlet LauncherViewController *_launcherViewController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) LauncherViewController *launcherViewController;
@end
