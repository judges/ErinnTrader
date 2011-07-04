
#import "HouseShopSearchResultViewController.h"

static NSString* const kServiceBaseURL  = @"http://kuku-api.heroku.com/";
static NSString* const kServiceEndPoint = @"erinn_trader/houseshop/";
static NSString* const kLabelMari       = @"mari/";
static NSString* const kLabelRuari      = @"ruari/";
static NSString* const kLabelTarlach    = @"tarlach/";
static NSString* const kLabelMorrighan  = @"morrighan/";
static NSString* const kLabelCichol     = @"cichol/";
static NSString* const kLabelTriona     = @"triona/";

@interface HouseShopSearchResultViewController ()
- (void)reloadItemTable;
- (void)changeServerTo:(Server)server;
- (NSString *)resourcePath;
- (NSArray *)filteredEntries;
@end

@implementation HouseShopSearchResultViewController

@synthesize itemTable = _itemTable;
@synthesize activityIndicator = _activityIndicator;
@synthesize items = _items;
@synthesize server = _server;
@synthesize keyword = _keyword;

#pragma mark -
#pragma mark Private Methods

////////////////////////////////////////////////////////////////////////////////
// initializer

- (void)initObjectManager {
  [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
  RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:kServiceBaseURL];
  objectManager.format = RKMappingFormatJSON;
}

- (void)initNavigationBar {
  self.navigationController.navigationBarHidden = NO;
  self.navigationController.toolbarHidden = YES;
}

- (void)initActivityIndicator {
  self.activityIndicator = [[LabeledActivityIndicatorView alloc] initWithParentView:self.itemTable andText:@"Loading"];
}

- (void)initControllerState {
  self.items = [NSArray array];
  [self changeServerTo:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]];
}

////////////////////////////////////////////////////////////////////////////////
// Logic

- (void)reloadItemTable {
  [NSThread detachNewThreadSelector:@selector(show) toTarget:self.activityIndicator withObject:nil];
  RKObjectManager* objectManager = [[RKObjectManager objectManagerWithBaseURL:kServiceBaseURL] retain];
  RKObjectLoader* loader = [objectManager loadObjectsAtResourcePath:self.resourcePath 
                                                           delegate:self];
  loader.objectClass = [HouseShopItem class];
  [loader send];
}

- (void)changeServerTo:(Server)server {
  self.server = server;
}

- (NSString *)resourcePath {
  NSString *label = @"";
  switch (self.server) {
    case ServerMari:
      label = kLabelMari;
      break;
    case ServerRuari:
      label = kLabelRuari;
      break;
    case ServerTarlach:
      label = kLabelTarlach;
      break;
    case ServerMorrighan:
      label = kLabelMorrighan;
      break;
    case ServerCichol:
      label = kLabelCichol;
      break;
    case ServerTriona:
      label = kLabelTriona;
      break;
  }
  return [NSString stringWithFormat:@"%@%@%@/%@", kServiceEndPoint, label, 
          [[self.keyword encodeString:NSUTF8StringEncoding] autorelease], @"1"];
}

- (NSArray *)filteredEntries {
  return self.items;
}

#pragma mark -
#pragma mark Inherit Methods

-(void)loadView {
  [super loadView];
  [self initNavigationBar];
  [self initActivityIndicator];
  [self initControllerState];
  [self initObjectManager];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self reloadItemTable];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.items = nil;
  self.keyword = nil;
  self.activityIndicator = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate Methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
  self.items = objects;
  [self.activityIndicator hide];
  [self.itemTable reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                   message:[error localizedDescription] 
                                                  delegate:nil 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil] autorelease];
  [alert show];
  [self.activityIndicator hide];
}

#pragma mark -
#pragma mark UITableView Delegate Methods

////////////////////////////////////////////////////////////////////////////////
// section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.filteredEntries count];
}

////////////////////////////////////////////////////////////////////////////////
// row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"MyIdentifer";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
  }
  HouseShopItem *item = [self.filteredEntries objectAtIndex:indexPath.row];
  
  cell.textLabel.text = item.item;
  cell.detailTextLabel.text = item.formatted_price;
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == ([self.filteredEntries count] - 1)) {
  }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  HouseShopItemViewController *houseShopItemViewController =
  [[[HouseShopItemViewController alloc] initWithNibName:@"HouseShopItemView" bundle:nil] autorelease];
  houseShopItemViewController.houseShopItem = [self.filteredEntries objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:houseShopItemViewController animated:YES];
}

@end
