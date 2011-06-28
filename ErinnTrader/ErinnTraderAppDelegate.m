
#import "ErinnTraderAppDelegate.h"
#import "IASKSettingsReader.h"
#import "IASKSpecifier.h"

@interface ErinnTraderAppDelegate ()
- (void)fadeSplashScreen;
@end

@implementation ErinnTraderAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize launcherViewController = _launcherViewController;

#pragma -
#pragma Private Methods

- (void)fadeSplashScreen {
  UIImage *img = [UIImage imageNamed:@"Default.png"];	
	UIImageView *imageview = 
    [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	imageview.image = img;
	[self.window addSubview:imageview];
  
  [UIView animateWithDuration:1.0
                   animations:^{ imageview.alpha = 0.0; }];
}

#pragma -
#pragma Inheritance Methods Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [UIApplication sharedApplication].statusBarHidden = NO;
  [self fadeSplashScreen];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)dealloc {
  self.launcherViewController = nil;
  self.navigationController = nil;
  self.window = nil;
  [super dealloc];
}

@end
