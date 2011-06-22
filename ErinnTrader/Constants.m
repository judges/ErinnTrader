
#import "Constants.h"

NSString * const kSymbolMari      = @"Mari";
NSString * const kSymbolRuari     = @"Ruari";
NSString * const kSymbolTarlach   = @"Tarlach";
NSString * const kSymbolMorrighan = @"Morrighan";
NSString * const kSymbolCichol    = @"Cichol";
NSString * const kSymbolTriona    = @"Triona";

@implementation Constants

+ (NSArray *)kServerSymbol {
  return [NSArray arrayWithObjects:
          kSymbolMari, kSymbolRuari, kSymbolTarlach,
          kSymbolMorrighan, kSymbolCichol, kSymbolTriona,
          nil];
}

@end
