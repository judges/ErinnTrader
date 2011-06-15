
#import "BoardViewController.h"

@interface BoardViewController ()
- (void)reloadEntryTable;
- (void)entryTableWillLoad;
- (void)entryTableDidLoad;
@end

@implementation BoardViewController

@synthesize boardSettingsViewController = _boardSettingsViewController;
@synthesize filterSegment = _filterSegment;
@synthesize entryTable = _entryTable;
@synthesize entries = _entries;

#pragma mark -
#pragma mark Private Methods

////////////////////////////////////////////////////////////////////////////////
// Observer

- (void)initObserver {
  [[BoardViewDataManager sharedManager] addObserver:self 
                                         forKeyPath:@"isLoading" 
                                            options:NSKeyValueObservingOptionNew 
                                            context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([keyPath isEqual:@"isLoading"] && [[change objectForKey:NSKeyValueChangeNewKey] boolValue]) {
    [self entryTableWillLoad];
  }
  else {
    [self entryTableDidLoad];
  }
}

- (void)deleteObserver {
  [[BoardViewDataManager sharedManager] removeObserver:self forKeyPath:@"isLoading"];
}

////////////////////////////////////////////////////////////////////////////////
// View

- (void)initNavigationBar {
  self.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain
                                    target:self   action:@selector(leftBarButtonItemTouched)];
  self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithTitle:@"filter" style:UIBarButtonItemStylePlain
                                    target:self     action:@selector(rightBarButtonItemTouched)];
  [self.navigationController setToolbarHidden:YES];
}

- (void)initTabBar {
  self.filterSegment.segmentedControlStyle = UISegmentedControlStyleBar;
}

#pragma mark -
#pragma mark Inherit Methods

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initObserver];
  [self initNavigationBar];
  [self initTabBar];
  
  [self reloadEntryTable];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [self deleteObserver];
  [super viewDidUnload];
}

- (void)dealloc {
  self.entries = nil;
  [super dealloc];
}

#pragma mark -
#pragma EventHandling Methods

- (void)leftBarButtonItemTouched {
  CATransition *animation = [CATransition animation];
  animation.type = kCATransitionFade;
  animation.subtype = kCATransitionFromBottom;
  [animation setDuration:0.5];
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  [[self.navigationController.view layer] addAnimation:animation forKey: @"transitionViewAnimation"];	
  [self.navigationController popViewControllerAnimated:NO];
}

- (void)rightBarButtonItemTouched {
  UINavigationController *navigationController = 
    [[[UINavigationController alloc] initWithRootViewController:self.boardSettingsViewController] autorelease];
  [self.navigationController presentModalViewController:navigationController animated:YES];
}

- (void)reloadEntryTable {
  [[BoardViewDataManager sharedManager] reloadData];
}

- (void)entryTableWillLoad {
}

- (void)entryTableDidLoad {
  self.entries = [[BoardViewDataManager sharedManager] filteredEntries];
  [self.entryTable reloadData];
}

#pragma mark -
#pragma mark UITableView Delegate Methods

////////////////////////////////////////////////////////////////////////////////
// section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.entries count];
}

////////////////////////////////////////////////////////////////////////////////
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

  return cell;
}

@end
