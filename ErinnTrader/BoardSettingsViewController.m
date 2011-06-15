
#import "BoardSettingsViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"

@implementation BoardSettingsViewController

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
  self.showDoneButton = YES;
  self.showCreditsFooter = NO;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [super dealloc];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

//#pragma mark -
//#pragma mark IASKAppSettingsViewControllerDelegate protocol
//
//- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
//  [self dismissModalViewControllerAnimated:YES];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderForKey:(NSString*)key {
//	if ([key isEqualToString:@"IASKLogo"]) {
//		return [UIImage imageNamed:@"Icon.png"].size.height + 25;
//	}
//	return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderForKey:(NSString*)key {
//	if ([key isEqualToString:@"IASKLogo"]) {
//		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
//		imageView.contentMode = UIViewContentModeCenter;
//		return [imageView autorelease];
//	}
//	return nil;
//}
//
//- (CGFloat)tableView:(UITableView*)tableView heightForSpecifier:(IASKSpecifier*)specifier {
//	if ([specifier.key isEqualToString:@"customCell"]) {
//		return 44*3;
//	}
//	return 0;
//}
//
//- (UITableViewCell*)tableView:(UITableView*)tableView cellForSpecifier:(IASKSpecifier*)specifier {
//	CustomViewCell *cell = (CustomViewCell*)[tableView dequeueReusableCellWithIdentifier:specifier.key];
//	
//	if (!cell) {
//		cell = (CustomViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"CustomViewCell" 
//                                                           owner:self 
//                                                         options:nil] objectAtIndex:0];
//	}
//	cell.textView.text= [[NSUserDefaults standardUserDefaults] objectForKey:specifier.key] != nil ? 
//  [[NSUserDefaults standardUserDefaults] objectForKey:specifier.key] : [specifier defaultStringValue];
//	cell.textView.delegate = self;
//	[cell setNeedsLayout];
//	return cell;
//}
//
//#pragma mark UITextViewDelegate (for CustomViewCell)
//- (void)textViewDidChange:(UITextView *)textView {
//  [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"customCell"];
//  [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged object:@"customCell"];
//}
//
//#pragma mark -
//- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForKey:(NSString*)key {
//	if ([key isEqualToString:@"ButtonDemoAction1"]) {
//		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
//		[alert show];
//	} else {
//		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 2 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
//		[alert show];
//	}
//}


@end
