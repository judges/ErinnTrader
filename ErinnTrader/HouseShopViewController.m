
#import "HouseShopViewController.h"

static NSString* const kServiceBaseURL  = @"http://kuku-api.heroku.com/";
static NSString* const kServiceEndPoint = @"erinn_trader/houseshop/";
static NSString* const kLabelMari       = @"mari/";
static NSString* const kLabelRuari      = @"ruari/";
static NSString* const kLabelTarlach    = @"tarlach/";
static NSString* const kLabelMorrighan  = @"morrighan/";
static NSString* const kLabelCichol     = @"cichol/";
static NSString* const kLabelTriona     = @"triona/";

@interface HouseShopViewController ()
- (void)reloadItemTable;
- (void)changeServerTo:(Server)server;
- (NSString *)resourcePath;
- (NSArray *)filteredEntries;
- (IBAction)backButtonTouched;
- (IBAction)searchButtonTouched;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewDataSource;
@end

@implementation HouseShopViewController

@synthesize searchBar = _searchBar;
@synthesize itemTable = _itemTable;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize reloading = _reloading;
@synthesize items = _items;
@synthesize server = _server;
@synthesize lastUpdated = _lastUpdated;

#pragma mark -
#pragma mark Private Methods

////////////////////////////////////////////////////////////////////////////////
// initializer

- (void)initCacheManager {
  [self addObserver:[CacheManager sharedManager]
         forKeyPath:@"items" 
            options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
            context:[[Constants kServerSymbol] objectAtIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]]];
  [self addObserver:[CacheManager sharedManager]
         forKeyPath:@"lastUpdated" 
            options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
            context:[[Constants kServerSymbol] objectAtIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]]];
}

- (void)initObjectManager {
  [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
  RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:kServiceBaseURL];
  objectManager.format = RKMappingFormatJSON;
}

- (void)initNavigationBar {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"launcher.png"] 
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self   
                                                                          action:@selector(backButtonTouched)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                         target:self
                                                                                         action:@selector(searchButtonTouched)];
  self.navigationController.navigationBarHidden = NO;
  self.navigationController.toolbarHidden = YES;
}

- (void)initRefreshHeaderView {
  CGRect rect = CGRectMake(0.0f, 0.0f - self.itemTable.bounds.size.height, self.view.frame.size.width, self.itemTable.bounds.size.height);
  self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:rect];
  self.refreshHeaderView.delegate = self;
  [self.itemTable addSubview:self.refreshHeaderView];
}

- (void)initSearchBar {
  self.searchBar.frame = CGRectMake(0, -44, 320, 44);
  [self.navigationController.navigationBar addSubview:self.searchBar];
}

- (void)initControllerState {
  self.items = [NSArray array];
  self.lastUpdated = [NSDate date];
  [self changeServerTo:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]];
}

////////////////////////////////////////////////////////////////////////////////
// Logic

- (void)reloadItemTable {
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
  return [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, label, @"1"];
}

- (NSArray *)filteredEntries {
  return self.items;
}

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
  [self initCacheManager];
  [self initControllerState];
  [self initObjectManager];
  [self initNavigationBar];
  [self initRefreshHeaderView];
  [self initSearchBar];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.refreshHeaderView refreshLastUpdatedDate];
  [self.itemTable reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.refreshHeaderView = nil;
  self.items = nil;
  self.lastUpdated = nil;
  [self removeObserver:[CacheManager sharedManager] forKeyPath:@"items"];
  [self removeObserver:[CacheManager sharedManager] forKeyPath:@"lastUpdated"];
  [super dealloc];
}

#pragma mark -
#pragma EventHandling Methods

- (IBAction)backButtonTouched {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey:@"transitionViewAnimation"];	
  [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)searchButtonTouched {
  [UIView animateWithDuration:0.3
                   animations:^{ self.searchBar.frame = CGRectMake(0, 0, 320, 44); }];
  
  UIView *overlay = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
  overlay.tag = 99567;
  overlay.backgroundColor = [UIColor blackColor];
  overlay.alpha = 0.7;
  [self.view addSubview:overlay];
  
  [self.searchBar becomeFirstResponder];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate Methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
  self.items = objects;
  [self doneLoadingTableViewDataSource];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
  if (self.reloading == YES) {
    [[[[UIAlertView alloc] initWithTitle:@"Error" 
                                 message:[error localizedDescription]
                                delegate:nil 
                       cancelButtonTitle:@"OK" 
                       otherButtonTitles:nil] autorelease] show];
  }
  [self doneLoadingTableViewDataSource];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  DetailViewController *detailViewController =
//    [[[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil] autorelease];
//  detailViewController.entry = [self.filteredEntries objectAtIndex:indexPath.row];
//  [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource {
	self.reloading = YES;
  [self reloadItemTable];
}

- (void)doneLoadingTableViewDataSource {
	self.reloading = NO;
  self.lastUpdated = [NSDate date];
  [self.refreshHeaderView refreshLastUpdatedDate];
	[self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.itemTable];
  [self.itemTable reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {	
	[self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return self.reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return self.lastUpdated;
}

#pragma -
#pragma UISearchBarDelegate Methods

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {  
  if ([searchBar.text length] == 0) {
    return;
  }
  
  [UIView animateWithDuration:0.3
                   animations:^{ self.searchBar.frame = CGRectMake(0, -44, 320, 44); }];
  [[self.view viewWithTag:99567] removeFromSuperview];
  [searchBar resignFirstResponder];
  
//  SearchResultViewController *searchResultViewController =
//    [[[SearchResultViewController alloc] initWithNibName:@"SearchResultView" bundle:nil] autorelease];
//  searchResultViewController.keyword = searchBar.text;
//  [self.navigationController pushViewController:searchResultViewController animated:YES];
}  

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  [UIView animateWithDuration:0.3
                   animations:^{ self.searchBar.frame = CGRectMake(0, -44, 320, 44); }];
  [[self.view viewWithTag:99567] removeFromSuperview];
  [searchBar resignFirstResponder];
}

@end
