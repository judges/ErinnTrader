
#import "BoardViewController.h"

static NSString* const kServiceBaseURL  = @"http://www.google.com/";
static NSString* const kServiceEndPoint = @"reader/public/javascript/";
static NSString* const kUserIdentifier  = @"user/10597537711022658252/";
static NSString* const kLabelMari       = @"label/mari";
static NSString* const kLabelRuari      = @"label/ruari";
static NSString* const kLabelTarlach    = @"label/tarlach";
static NSString* const kLabelMorrighan  = @"label/morrighan";
static NSString* const kLabelCichol     = @"label/cichol";
static NSString* const kLabelTriona     = @"label/triona";

@interface BoardViewController ()
- (void)reloadEntryTable;
- (void)changeServerTo:(Server)server;
- (void)changeTradeTypeTo:(TradeType)tradeType;
- (NSString *)resourcePath;
- (NSArray *)filteredEntries;
- (IBAction)backButtonTouched;
- (IBAction)searchButtonTouched;
- (IBAction)tradeTypeChanged:(UISegmentedControl*)sender;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

@implementation BoardViewController

@synthesize searchBar = _searchBar;
@synthesize filterSegment = _filterSegment;
@synthesize entryTable = _entryTable;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize reloading = _reloading;
@synthesize entries = _entries;
@synthesize server = _server;
@synthesize tradeType = _tradeType;
@synthesize lastUpdated = _lastUpdated;

#pragma mark -
#pragma mark Private Methods

////////////////////////////////////////////////////////////////////////////////
// initializer

- (void)initCacheManager {
  [self addObserver:[CacheManager sharedManager]
         forKeyPath:@"entries" 
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
  self.navigationController.toolbarHidden = YES;
}

- (void)initRefreshHeaderView {
  CGRect rect = CGRectMake(0.0f, 0.0f - self.entryTable.bounds.size.height, self.view.frame.size.width, self.entryTable.bounds.size.height);
  self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:rect];
  self.refreshHeaderView.delegate = self;
  [self.entryTable addSubview:self.refreshHeaderView];
}

- (void)initSearchBar {
  self.searchBar.frame = CGRectMake(0, -44, 320, 44);
  [self.navigationController.navigationBar addSubview:self.searchBar];
}

- (void)initControllerState {
  self.entries = [NSArray array];
  self.lastUpdated = [NSDate date];
  [self changeServerTo:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]];
  [self changeTradeTypeTo:TradeTypeAll];
}

////////////////////////////////////////////////////////////////////////////////
// Logic

- (void)reloadEntryTable {
  RKObjectManager* objectManager = [RKObjectManager sharedManager];
  RKObjectLoader* loader = [objectManager loadObjectsAtResourcePath:self.resourcePath 
                                                        queryParams:[NSDictionary dictionaryWithObject:@"100" forKey:@"n"]
                                                           delegate:self];
  loader.objectClass = [Entry class];
  loader.keyPath = @"items";
  [loader send];
}

- (void)changeServerTo:(Server)server {
  self.server = server;
}

- (void)changeTradeTypeTo:(TradeType)tradeType {
  self.tradeType = tradeType;
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
  return [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, label];
}

- (NSArray *)filteredEntries {
  NSArray *filteredEntries = [NSArray array];
  // ---------------------------------------------------------------------------
  // Entries for TradeTypeAll
  if (self.tradeType == TradeTypeAll) {
    filteredEntries = self.entries;
  }
  // ---------------------------------------------------------------------------
  // Entries for TradeTypeSell
  else if (self.tradeType == TradeTypeSell) {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSIndexSet *indexes = [self.entries indexesOfObjectsPassingTest:^(id obj, NSUInteger index, BOOL *stop) { 
      if (([((Entry*)obj).title rangeOfString:@"売ります"]).location != NSNotFound) { 
        return YES; 
      } 
      return NO; 
    }];
    int index = [indexes firstIndex];
    while(index != NSNotFound) {
      [tempArray addObject:[self.entries objectAtIndex:index]];
      index = [indexes indexGreaterThanIndex:index];
    }
    filteredEntries = [NSArray arrayWithArray:tempArray];
  }
  // ---------------------------------------------------------------------------
  // Entries for TradeTypeBuy
  else if (self.tradeType == TradeTypeBuy) {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSIndexSet *indexes = [self.entries indexesOfObjectsPassingTest:^(id obj, NSUInteger index, BOOL *stop) { 
      if (([((Entry*)obj).title rangeOfString:@"買います"]).location != NSNotFound) { 
        return YES; 
      } 
      return NO; 
    }];
    int index = [indexes firstIndex];
    while(index != NSNotFound) {
      [tempArray addObject:[self.entries objectAtIndex:index]];
      index = [indexes indexGreaterThanIndex:index];
    }
    filteredEntries = [NSArray arrayWithArray:tempArray];
  }
  // ---------------------------------------------------------------------------
  return filteredEntries;
}

#pragma mark -
#pragma mark Inherit Methods

-(void)loadView {
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
  [self.entryTable reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.refreshHeaderView = nil;
  self.entries = nil;
  self.lastUpdated = nil;
  [self removeObserver:[CacheManager sharedManager] forKeyPath:@"entries"];
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

- (IBAction)tradeTypeChanged:(UISegmentedControl*)sender {
  [self changeTradeTypeTo:sender.selectedSegmentIndex];
  [self.entryTable reloadData];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate Methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
  self.entries = objects;
  [self doneLoadingTableViewData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                   message:[error localizedDescription] 
                                                  delegate:nil 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil] autorelease];
  [alert show];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  Entry *entry = [self.filteredEntries objectAtIndex:indexPath.row];
  CGSize ts1 = [entry.title sizeWithFont:[UIFont systemFontOfSize:13]
                       constrainedToSize:CGSizeMake(tableView.frame.size.width - 40, tableView.frame.size.height)
                           lineBreakMode:UILineBreakModeWordWrap];  
  NSString *detailText = [ApplicationHelper fuzzyTime:[NSDate dateWithTimeIntervalSince1970:entry.published]];
  CGSize ts2 = [detailText sizeWithFont:[UIFont systemFontOfSize:13]
                                               constrainedToSize:tableView.frame.size
                                                   lineBreakMode:UILineBreakModeWordWrap];  
  return ts1.height + ts2.height + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"MyIdentifer";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
  }
  Entry *entry = [self.filteredEntries objectAtIndex:indexPath.row];
  
  cell.textLabel.text = entry.title;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", 
    entry.author, [ApplicationHelper fuzzyTime:[NSDate dateWithTimeIntervalSince1970:entry.published]]];

  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  DetailViewController *detailViewController =
    [[[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil] autorelease];
  detailViewController.entry = [self.filteredEntries objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource {
	self.reloading = YES;
  [self reloadEntryTable];
}

- (void)doneLoadingTableViewData {
	self.reloading = NO;
  self.lastUpdated = [NSDate date];
	[self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.entryTable];
  [self.entryTable reloadData];
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
  [UIView animateWithDuration:0.3
                   animations:^{ self.searchBar.frame = CGRectMake(0, -44, 320, 44); }];
  [[self.view viewWithTag:99567] removeFromSuperview];
  [searchBar resignFirstResponder];

  SearchResultViewController *searchResultViewController =
    [[[SearchResultViewController alloc] initWithNibName:@"SearchResultView" bundle:nil] autorelease];
  searchResultViewController.keyword = searchBar.text;
  [self.navigationController pushViewController:searchResultViewController animated:YES];
}  

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  [UIView animateWithDuration:0.3
                   animations:^{ self.searchBar.frame = CGRectMake(0, -44, 320, 44); }];
  [[self.view viewWithTag:99567] removeFromSuperview];
  [searchBar resignFirstResponder];
}

@end
