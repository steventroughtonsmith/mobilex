@class NSString;

@interface CAFilter : NSObject <NSCopying, NSMutableCopying> {
@private
	unsigned _type;
	NSString* _name;
	unsigned _flags;
	void* _cache;
}
@property(assign) BOOL cachesInputImage;
@property(assign, getter=isEnabled) BOOL enabled;
@property(copy) NSString* name;
@property(readonly, assign) NSString* type;
// ["multiplyColor","multiplyGradient","gaussianBlur","pageCurl","fog","lighting","clear","copy",
//  "sourceOver","sourceIn","sourceOut","sourceAtop","destOver","destIn","destOut","destAtop","xor","plusL","multiply"]
+(NSArray*)filterTypes;
+(CAFilter*)filterWithType:(NSString*)type;
+(CAFilter*)filterWithName:(NSString*)name;
-(id)initWithType:(NSString*)type;
-(id)initWithName:(NSString*)name;
-(BOOL)enabled;
-(void)setValue:(id)value forKey:(id)key;
-(id)valueForKey:(id)key;
-(void)setDefaults;
// inherited: -(void)dealloc;
// in a protocol: -(id)copyWithZone:(NSZone*)zone;
// in a protocol: -(id)mutableCopyWithZone:(NSZone*)zone;
-(void)willChangeValueForKey:(id)key;
-(void)didChangeValueForKey:(id)key;
@end

extern NSString* const kCAFilterClear;
extern NSString* const kCAFilterCopy;
extern NSString* const kCAFilterDestAtop;
extern NSString* const kCAFilterDestIn;
extern NSString* const kCAFilterDestOut;
extern NSString* const kCAFilterDestOver;
extern NSString* const kCAFilterFog;
extern NSString* const kCAFilterGaussianBlur;
extern NSString* const kCAFilterLanczos;
extern NSString* const kCAFilterLighting;
extern NSString* const kCAFilterLinear;
extern NSString* const kCAFilterMultiply;
extern NSString* const kCAFilterMultiplyColor;
extern NSString* const kCAFilterMultiplyGradient;
extern NSString* const kCAFilterNearest;
extern NSString* const kCAFilterPageCurl;
extern NSString* const kCAFilterPlusL;
extern NSString* const kCAFilterSourceAtop;
extern NSString* const kCAFilterSourceIn;
extern NSString* const kCAFilterSourceOut;
extern NSString* const kCAFilterSourceOver;
extern NSString* const kCAFilterTrilinear;
extern NSString* const kCAFilterXor;
