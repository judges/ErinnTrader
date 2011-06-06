
#import "BoardViewController.h"

static NSString* const kServiceEndPoint = @"reader/public/javascript/";
static NSString* const kUserIdentifier  = @"user/10597537711022658252/";
static NSString* const kLabelMari       = @"label/mari";
static NSString* const kLabelRuari      = @"label/ruari";
static NSString* const kLabelTarlach    = @"label/tarlach";
static NSString* const kLabelMorrighan  = @"label/morrighan";
static NSString* const kLabelCichol     = @"label/cichol";
static NSString* const kLabelTriona     = @"label/triona";

@interface BoardViewController ()
- (void)initObjectManager;
- (void)drawEntryTable;
- (void)loadEntries;
- (void)changeServerTo:(Server)server;
@end

@implementation BoardViewController

@synthesize entryTable = _entryTable;
@synthesize resourcePath = _resourcePath;
@synthesize entries = _entries;

#pragma mark -
#pragma mark Private Methods

- (void)initObjectManager {
  [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
  RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://www.google.com/"];
  [objectManager setFormat:RKMappingFormatJSON];
}

- (void)drawEntryTable {
  [self.entryTable reloadData];
}

- (void)loadEntries {
  RKObjectManager* objectManager = [RKObjectManager sharedManager];
  RKObjectLoader* loader = [objectManager objectLoaderWithResourcePath:self.resourcePath delegate:self];
  loader.objectClass = [Entry class];
  loader.keyPath = @"items";
  [loader send];
}

- (void)changeServerTo:(Server)server {
  NSString *resourcePath = nil;
  switch (server) {
    case ServerMari:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelMari];
      break;
    case ServerRuari:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelRuari];
      break;
    case ServerTarlach:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelTarlach];
      break;
    case ServerMorrighan:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelMorrighan];
      break;
    case ServerCichol:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelCichol];
      break;
    case ServerTriona:
      resourcePath = [NSString stringWithFormat:@"%@%@%@", kServiceEndPoint, kUserIdentifier, kLabelTriona];
      break;
  }
  self.resourcePath = resourcePath;
}

#pragma mark -
#pragma mark Inherit Methods

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initObjectManager];
  [self changeServerTo:ServerMari];
  [self loadEntries];
  [self drawEntryTable];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  self.entries = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate Methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
  self.entries = objects;
  [self drawEntryTable];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

#pragma mark -
#pragma mark UITableView Delegate Methods

// -----------------------------------------------------------------------------
// section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.entries count];
}

// -----------------------------------------------------------------------------
// row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"MyIdentifer";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier] autorelease];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    [cell.textLabel setNumberOfLines:0];
  }
  Entry *entry = [self.entries objectAtIndex:indexPath.row];
  [cell.textLabel setText:entry.title];
  
  NSLog(@"%@" ,entry.title);
  
  return cell;
}

@end
