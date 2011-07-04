
#import "HouseShopItemViewController.h"

@implementation HouseShopItemViewController

@synthesize itemTable = _itemTable;
@synthesize houseShopItem = _houseShopItem;

#pragma mark -
#pragma mark Inherit Methods

- (void)loadView {
  [super loadView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark -
#pragma mark UITableView Delegate Methods

////////////////////////////////////////////////////////////////////////////////
// section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return self.houseShopItem.item;
}

////////////////////////////////////////////////////////////////////////////////
// row

//NSString *_name;
//NSString *_area;
//NSString *_price;
//NSString *_comment;
//NSString *_coupon;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *CellIdentifier = @"MyIdentifer";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                   reuseIdentifier:CellIdentifier] autorelease];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
  }
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = @"オーナー";
      cell.detailTextLabel.text = self.houseShopItem.name;
      break;
    case 1:
      cell.textLabel.text = @"エリア";
      cell.detailTextLabel.text = self.houseShopItem.area;
      break;
    case 2:
      cell.textLabel.text = @"価格";
      cell.detailTextLabel.text = self.houseShopItem.price;
      break;
    case 3:
      cell.textLabel.text = @"クーポン";
      cell.detailTextLabel.text = self.houseShopItem.coupon;
      break;
    case 4:
      cell.textLabel.text = @"コメント";
      cell.detailTextLabel.text = self.houseShopItem.comment;
      break;
  }
  return cell;
}

@end
