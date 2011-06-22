
typedef enum {
  ServerMari, ServerRuari, ServerTarlach, 
  ServerMorrighan, ServerCichol, ServerTriona
} Server;

typedef enum {
  TradeTypeAll, TradeTypeSell, TradeTypeBuy
} TradeType;

extern NSString * const kSymbolMari;
extern NSString * const kSymbolRuari;
extern NSString * const kSymbolTarlach;
extern NSString * const kSymbolMorrighan;
extern NSString * const kSymbolCichol;
extern NSString * const kSymbolTriona;

@interface Constants : NSObject
+ (NSArray *)kServerSymbol;
@end