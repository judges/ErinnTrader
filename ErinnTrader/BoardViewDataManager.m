
#import "BoardViewDataManager.h"

static BoardViewDataManager *_instance;

static NSString* const kServiceEndPoint = @"reader/public/javascript/";
static NSString* const kUserIdentifier  = @"user/10597537711022658252/";
static NSString* const kLabelMari       = @"label/mari";
static NSString* const kLabelRuari      = @"label/ruari";
static NSString* const kLabelTarlach    = @"label/tarlach";
static NSString* const kLabelMorrighan  = @"label/morrighan";
static NSString* const kLabelCichol     = @"label/cichol";
static NSString* const kLabelTriona     = @"label/triona";

@interface BoardViewDataManager ()
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, copy) NSArray *entries;
@property (nonatomic, retain) NSString *resourcePath;
- (void)initObjectManager;
@end

@implementation BoardViewDataManager

@synthesize isLoading = _isLoading;
@synthesize entries = _entries;
@synthesize resourcePath = _resourcePath;

#pragma -
#pragma Private Methods

////////////////////////////////////////////////////////////////////////////////
// initializer

- (void)initObjectManager {
  [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
  RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://www.google.com/"];
  [objectManager setFormat:RKMappingFormatJSON];
}

#pragma -
#pragma Public Methods

- (NSArray *)filteredEntries {
  return self.entries;
}

- (void)reloadData {
  RKObjectManager* objectManager = [RKObjectManager sharedManager];
  RKObjectLoader* loader = [objectManager objectLoaderWithResourcePath:self.resourcePath delegate:self];
  loader.objectClass = [Entry class];
  loader.keyPath = @"items";
  [loader send];
  self.isLoading = YES;
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
#pragma mark RKObjectLoaderDelegate Methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
  self.entries = objects;
  self.isLoading = NO;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                   message:[error localizedDescription] 
                                                  delegate:nil 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil] autorelease];
  [alert show];
  self.isLoading = NO;
}

#pragma mark -
#pragma mark Singleton Methods

+ (BoardViewDataManager *)sharedManager {
	@synchronized(self) {
    if (_instance == nil) {
      _instance = [[self alloc] init];
      [_instance changeServerTo:ServerMari];
      [_instance initObjectManager];
    }
  }
  return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {	
  @synchronized(self) {
    if (_instance == nil) {
      _instance = [super allocWithZone:zone];			
      return _instance;
    }
  }
  return nil;
}

- (id)copyWithZone:(NSZone *)zone {
  return self;	
}

- (id)retain {	
  return self;	
}

- (unsigned)retainCount {
  return UINT_MAX;
}

- (void)release {
  //do nothing
}

- (id)autorelease {
  return self;	
}

@end
