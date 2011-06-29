
#import "SearchResultViewController.h"

static NSString* const kServiceBaseURL  = @"http://kuku-api.heroku.com/";
static NSString* const kServiceEndPoint = @"erinn_trader/search/";
static NSString* const kLabelMari       = @"mari/";
static NSString* const kLabelRuari      = @"ruari/";
static NSString* const kLabelTarlach    = @"tarlach/";
static NSString* const kLabelMorrighan  = @"morrighan/";
static NSString* const kLabelCichol     = @"cichol/";
static NSString* const kLabelTriona     = @"triona/";

@interface SearchResultViewController ()
- (void)reloadEntryTable;
- (void)changeServerTo:(Server)server;
- (void)changeTradeTypeTo:(TradeType)tradeType;
- (NSString *)resourcePath;
- (NSArray *)filteredEntries;
- (IBAction)tradeTypeChanged:(UISegmentedControl*)sender;
@end

@implementation SearchResultViewController

@synthesize filterSegment = _filterSegment;
@synthesize entryTable = _entryTable;
@synthesize activityIndicator = _activityIndicator;
@synthesize entries = _entries;
@synthesize server = _server;
@synthesize keyword = _keyword;
@synthesize tradeType = _tradeType;

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
  self.activityIndicator = [[LabeledActivityIndicatorView alloc] initWithParentView:self.entryTable andText:@"Loading"];
}

- (void)initControllerState {
  self.entries = [NSArray array];
  [self changeServerTo:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Server"] intValue]];
  [self changeTradeTypeTo:TradeTypeAll];
}

////////////////////////////////////////////////////////////////////////////////
// Logic

- (void)reloadEntryTable {
  [NSThread detachNewThreadSelector:@selector(show) toTarget:self.activityIndicator withObject:nil];
  RKObjectManager* objectManager = [[RKObjectManager objectManagerWithBaseURL:kServiceBaseURL] retain];
  RKObjectLoader* loader = [objectManager objectLoaderWithResourcePath:self.resourcePath delegate:self];
  loader.objectClass = [Entry class];
  [loader send];
}

- (void)changeServerTo:(Server)server {
  NSString *label = nil;
  switch (server) {
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
  self.server = label;
}

- (void)changeTradeTypeTo:(TradeType)tradeType {
  self.tradeType = tradeType;
}

- (NSString *)resourcePath {
  return [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, self.server, [[self.keyword encodeString:NSUTF8StringEncoding] autorelease]];
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
  [self initNavigationBar];
  [self initActivityIndicator];
  [self initControllerState];
  [self initObjectManager];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self reloadEntryTable];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.entries = nil;
  self.server = nil;
  self.keyword = nil;
  self.activityIndicator = nil;
  [super dealloc];
}

#pragma mark -
#pragma EventHandling Methods

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
  [self.activityIndicator hide];
  [self.entryTable reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  Entry *entry = [self.filteredEntries objectAtIndex:indexPath.row];
  CGSize ts1 = [entry.title sizeWithFont:[UIFont systemFontOfSize:13]
                       constrainedToSize:CGSizeMake(tableView.frame.size.width - 40, tableView.frame.size.height)
                           lineBreakMode:UILineBreakModeWordWrap];  
  CGSize ts2 = [[ApplicationHelper fuzzyTime:[NSDate dateWithTimeIntervalSince1970:entry.published]] sizeWithFont:[UIFont systemFontOfSize:13]
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

@end
