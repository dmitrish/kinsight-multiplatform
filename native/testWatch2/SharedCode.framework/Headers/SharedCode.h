#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSError.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>

@class SharedCodeIdeaModel, SharedCodePriceKind, SharedCodeKotlinEnum, SharedCodeTickModel, SharedCodeGraphModel, SharedCodeNotificationMessage, SharedCodeTickerModel, SharedCodeTickerPriceModel, SharedCodeKotlinArray, SharedCodeKotlinx_serialization_runtimeSerialKind, SharedCodeKotlinNothing, SharedCodeKotlinx_serialization_runtimeUpdateMode;

@protocol SharedCodeKotlinComparable, SharedCodeKotlinx_serialization_runtimeKSerializer, SharedCodeParcelable, SharedCodeKotlinx_serialization_runtimeEncoder, SharedCodeKotlinx_serialization_runtimeSerialDescriptor, SharedCodeKotlinx_serialization_runtimeSerializationStrategy, SharedCodeKotlinx_serialization_runtimeDecoder, SharedCodeKotlinx_serialization_runtimeDeserializationStrategy, SharedCodeKotlinx_serialization_runtimeCompositeEncoder, SharedCodeKotlinx_serialization_runtimeSerialModule, SharedCodeKotlinAnnotation, SharedCodeKotlinx_serialization_runtimeCompositeDecoder, SharedCodeKotlinIterator, SharedCodeKotlinx_serialization_runtimeSerialModuleCollector, SharedCodeKotlinKClass, SharedCodeKotlinKDeclarationContainer, SharedCodeKotlinKAnnotatedElement, SharedCodeKotlinKClassifier;

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-warning-option"
#pragma clang diagnostic ignored "-Wnullability"

@interface KotlinBase : NSObject
- (instancetype)init __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
+ (void)initialize __attribute__((objc_requires_super));
@end;

@interface KotlinBase (KotlinBaseCopying) <NSCopying>
@end;

__attribute__((objc_runtime_name("KotlinMutableSet")))
__attribute__((swift_name("KotlinMutableSet")))
@interface SharedCodeMutableSet<ObjectType> : NSMutableSet<ObjectType>
@end;

__attribute__((objc_runtime_name("KotlinMutableDictionary")))
__attribute__((swift_name("KotlinMutableDictionary")))
@interface SharedCodeMutableDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>
@end;

@interface NSError (NSErrorKotlinException)
@property (readonly) id _Nullable kotlinException;
@end;

__attribute__((objc_runtime_name("KotlinNumber")))
__attribute__((swift_name("KotlinNumber")))
@interface SharedCodeNumber : NSNumber
- (instancetype)initWithChar:(char)value __attribute__((unavailable));
- (instancetype)initWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
- (instancetype)initWithShort:(short)value __attribute__((unavailable));
- (instancetype)initWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
- (instancetype)initWithInt:(int)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
- (instancetype)initWithLong:(long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
- (instancetype)initWithLongLong:(long long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
- (instancetype)initWithFloat:(float)value __attribute__((unavailable));
- (instancetype)initWithDouble:(double)value __attribute__((unavailable));
- (instancetype)initWithBool:(BOOL)value __attribute__((unavailable));
- (instancetype)initWithInteger:(NSInteger)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
+ (instancetype)numberWithChar:(char)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
+ (instancetype)numberWithShort:(short)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
+ (instancetype)numberWithInt:(int)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
+ (instancetype)numberWithLong:(long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
+ (instancetype)numberWithLongLong:(long long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
+ (instancetype)numberWithFloat:(float)value __attribute__((unavailable));
+ (instancetype)numberWithDouble:(double)value __attribute__((unavailable));
+ (instancetype)numberWithBool:(BOOL)value __attribute__((unavailable));
+ (instancetype)numberWithInteger:(NSInteger)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
@end;

__attribute__((objc_runtime_name("KotlinByte")))
__attribute__((swift_name("KotlinByte")))
@interface SharedCodeByte : SharedCodeNumber
- (instancetype)initWithChar:(char)value;
+ (instancetype)numberWithChar:(char)value;
@end;

__attribute__((objc_runtime_name("KotlinUByte")))
__attribute__((swift_name("KotlinUByte")))
@interface SharedCodeUByte : SharedCodeNumber
- (instancetype)initWithUnsignedChar:(unsigned char)value;
+ (instancetype)numberWithUnsignedChar:(unsigned char)value;
@end;

__attribute__((objc_runtime_name("KotlinShort")))
__attribute__((swift_name("KotlinShort")))
@interface SharedCodeShort : SharedCodeNumber
- (instancetype)initWithShort:(short)value;
+ (instancetype)numberWithShort:(short)value;
@end;

__attribute__((objc_runtime_name("KotlinUShort")))
__attribute__((swift_name("KotlinUShort")))
@interface SharedCodeUShort : SharedCodeNumber
- (instancetype)initWithUnsignedShort:(unsigned short)value;
+ (instancetype)numberWithUnsignedShort:(unsigned short)value;
@end;

__attribute__((objc_runtime_name("KotlinInt")))
__attribute__((swift_name("KotlinInt")))
@interface SharedCodeInt : SharedCodeNumber
- (instancetype)initWithInt:(int)value;
+ (instancetype)numberWithInt:(int)value;
@end;

__attribute__((objc_runtime_name("KotlinUInt")))
__attribute__((swift_name("KotlinUInt")))
@interface SharedCodeUInt : SharedCodeNumber
- (instancetype)initWithUnsignedInt:(unsigned int)value;
+ (instancetype)numberWithUnsignedInt:(unsigned int)value;
@end;

__attribute__((objc_runtime_name("KotlinLong")))
__attribute__((swift_name("KotlinLong")))
@interface SharedCodeLong : SharedCodeNumber
- (instancetype)initWithLongLong:(long long)value;
+ (instancetype)numberWithLongLong:(long long)value;
@end;

__attribute__((objc_runtime_name("KotlinULong")))
__attribute__((swift_name("KotlinULong")))
@interface SharedCodeULong : SharedCodeNumber
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value;
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value;
@end;

__attribute__((objc_runtime_name("KotlinFloat")))
__attribute__((swift_name("KotlinFloat")))
@interface SharedCodeFloat : SharedCodeNumber
- (instancetype)initWithFloat:(float)value;
+ (instancetype)numberWithFloat:(float)value;
@end;

__attribute__((objc_runtime_name("KotlinDouble")))
__attribute__((swift_name("KotlinDouble")))
@interface SharedCodeDouble : SharedCodeNumber
- (instancetype)initWithDouble:(double)value;
+ (instancetype)numberWithDouble:(double)value;
@end;

__attribute__((objc_runtime_name("KotlinBoolean")))
__attribute__((swift_name("KotlinBoolean")))
@interface SharedCodeBoolean : SharedCodeNumber
- (instancetype)initWithBool:(BOOL)value;
+ (instancetype)numberWithBool:(BOOL)value;
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IdeaModelLogicDecorator")))
@interface SharedCodeIdeaModelLogicDecorator : KotlinBase
- (instancetype)initWithIdeaModel:(SharedCodeIdeaModel *)ideaModel __attribute__((swift_name("init(ideaModel:)"))) __attribute__((objc_designated_initializer));
- (NSString *)getConviction __attribute__((swift_name("getConviction()")));
- (NSString *)getDisplayValueForAlpha __attribute__((swift_name("getDisplayValueForAlpha()")));
- (NSString *)getDisplayValueForPricePriceKind:(SharedCodePriceKind *)priceKind __attribute__((swift_name("getDisplayValueForPrice(priceKind:)")));
@end;

__attribute__((swift_name("Parcelable")))
@protocol SharedCodeParcelable
@required
@end;

__attribute__((swift_name("KotlinComparable")))
@protocol SharedCodeKotlinComparable
@required
- (int32_t)compareToOther:(id _Nullable)other __attribute__((swift_name("compareTo(other:)")));
@end;

__attribute__((swift_name("KotlinEnum")))
@interface SharedCodeKotlinEnum : KotlinBase <SharedCodeKotlinComparable>
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer));
- (int32_t)compareToOther:(SharedCodeKotlinEnum *)other __attribute__((swift_name("compareTo(other:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) int32_t ordinal __attribute__((swift_name("ordinal")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("PriceKind")))
@interface SharedCodePriceKind : SharedCodeKotlinEnum
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) SharedCodePriceKind *target __attribute__((swift_name("target")));
@property (class, readonly) SharedCodePriceKind *current __attribute__((swift_name("current")));
@property (class, readonly) SharedCodePriceKind *previous __attribute__((swift_name("previous")));
- (int32_t)compareToOther:(SharedCodePriceKind *)other __attribute__((swift_name("compareTo(other:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IdeaApi")))
@interface SharedCodeIdeaApi : KotlinBase
- (instancetype)initWithBaseUrl:(NSString *)baseUrl __attribute__((swift_name("init(baseUrl:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *baseUrl __attribute__((swift_name("baseUrl")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Colors")))
@interface SharedCodeColors : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)colors __attribute__((swift_name("init()")));
@property (readonly) NSString *backgrounddarkest __attribute__((swift_name("backgrounddarkest")));
@property (readonly) NSString *black_overlay __attribute__((swift_name("black_overlay")));
@property (readonly) NSString *circleFill __attribute__((swift_name("circleFill")));
@property (readonly) NSString *colorAccent __attribute__((swift_name("colorAccent")));
@property (readonly) NSString *colorGradientCenter __attribute__((swift_name("colorGradientCenter")));
@property (readonly) NSString *colorGradientEnd __attribute__((swift_name("colorGradientEnd")));
@property (readonly) NSString *colorGradientStart __attribute__((swift_name("colorGradientStart")));
@property (readonly) NSString *colorGreen __attribute__((swift_name("colorGreen")));
@property (readonly) NSString *colorPrimary __attribute__((swift_name("colorPrimary")));
@property (readonly) NSString *colorPrimaryDark __attribute__((swift_name("colorPrimaryDark")));
@property (readonly) NSString *colorRed __attribute__((swift_name("colorRed")));
@property (readonly) NSString *colorRegText __attribute__((swift_name("colorRegText")));
@property (readonly) NSString *colorTransparent __attribute__((swift_name("colorTransparent")));
@property (readonly) NSString *colorViewBackground __attribute__((swift_name("colorViewBackground")));
@property (readonly) NSString *colorWhite __attribute__((swift_name("colorWhite")));
@property (readonly) NSString *colorbackground __attribute__((swift_name("colorbackground")));
@property (readonly) NSString *colorbackgroundDark __attribute__((swift_name("colorbackgroundDark")));
@property (readonly) NSString *colorbackgroundDarker __attribute__((swift_name("colorbackgroundDarker")));
@property (readonly) NSString *colorlabelText __attribute__((swift_name("colorlabelText")));
@property (readonly) NSString *missingData __attribute__((swift_name("missingData")));
@property (readonly) NSString *primaryblue __attribute__((swift_name("primaryblue")));
@property (readonly) NSString *radio_button_selected_color __attribute__((swift_name("radio_button_selected_color")));
@property (readonly) NSString *radio_button_unselected_color __attribute__((swift_name("radio_button_unselected_color")));
@property (readonly) NSString *separator_color __attribute__((swift_name("separator_color")));
@property (readonly) NSString *yellow __attribute__((swift_name("yellow")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Strings")))
@interface SharedCodeStrings : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)strings __attribute__((swift_name("init()")));
@property (readonly) NSString *PORT __attribute__((swift_name("PORT")));
@property (readonly) NSString *SERVER_URL_LOCAL_BASE_FOR_EMULATOR __attribute__((swift_name("SERVER_URL_LOCAL_BASE_FOR_EMULATOR")));
@property (readonly) NSString *SERVER_URL_REMOTE_BASE __attribute__((swift_name("SERVER_URL_REMOTE_BASE")));
@property (readonly) NSString *action_settings __attribute__((swift_name("action_settings")));
@property (readonly) NSString *alpha __attribute__((swift_name("alpha")));
@property (readonly) NSString *app_name __attribute__((swift_name("app_name")));
@property (readonly) NSString *conviction_high __attribute__((swift_name("conviction_high")));
@property (readonly) NSString *conviction_low __attribute__((swift_name("conviction_low")));
@property (readonly) NSString *conviction_medium __attribute__((swift_name("conviction_medium")));
@property (readonly) NSString *direction_long __attribute__((swift_name("direction_long")));
@property (readonly) NSString *direction_short __attribute__((swift_name("direction_short")));
@property (readonly) NSString *dummy_button __attribute__((swift_name("dummy_button")));
@property (readonly) NSString *dummy_content __attribute__((swift_name("dummy_content")));
@property (readonly) NSString *hello_blank_fragment __attribute__((swift_name("hello_blank_fragment")));
@property (readonly) NSString *menu_gallery __attribute__((swift_name("menu_gallery")));
@property (readonly) NSString *menu_home __attribute__((swift_name("menu_home")));
@property (readonly) NSString *menu_send __attribute__((swift_name("menu_send")));
@property (readonly) NSString *menu_share __attribute__((swift_name("menu_share")));
@property (readonly) NSString *menu_slideshow __attribute__((swift_name("menu_slideshow")));
@property (readonly) NSString *menu_tools __attribute__((swift_name("menu_tools")));
@property (readonly) NSString *nav_header_desc __attribute__((swift_name("nav_header_desc")));
@property (readonly) NSString *nav_header_subtitle __attribute__((swift_name("nav_header_subtitle")));
@property (readonly) NSString *nav_header_title __attribute__((swift_name("nav_header_title")));
@property (readonly) NSString *navigation_drawer_close __attribute__((swift_name("navigation_drawer_close")));
@property (readonly) NSString *navigation_drawer_open __attribute__((swift_name("navigation_drawer_open")));
@property (readonly) NSString *psi __attribute__((swift_name("psi")));
@property (readonly) NSString *time_horizon_one_month __attribute__((swift_name("time_horizon_one_month")));
@property (readonly) NSString *time_horizon_one_week __attribute__((swift_name("time_horizon_one_week")));
@property (readonly) NSString *time_horizon_three_months __attribute__((swift_name("time_horizon_three_months")));
@property (readonly) NSString *title_activity_create_new_idea __attribute__((swift_name("title_activity_create_new_idea")));
@property (readonly) NSString *title_activity_idea_detail __attribute__((swift_name("title_activity_idea_detail")));
@property (readonly) NSString *welcomeMessage __attribute__((swift_name("welcomeMessage")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GraphModel")))
@interface SharedCodeGraphModel : KotlinBase
- (instancetype)initWithBenchmark:(NSArray<SharedCodeTickModel *> *)benchmark ticker:(NSArray<SharedCodeTickModel *> *)ticker ideaAge:(int32_t)ideaAge intervalOption:(NSString *)intervalOption __attribute__((swift_name("init(benchmark:ticker:ideaAge:intervalOption:)"))) __attribute__((objc_designated_initializer));
- (NSArray<SharedCodeTickModel *> *)component1 __attribute__((swift_name("component1()")));
- (NSArray<SharedCodeTickModel *> *)component2 __attribute__((swift_name("component2()")));
- (int32_t)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (SharedCodeGraphModel *)doCopyBenchmark:(NSArray<SharedCodeTickModel *> *)benchmark ticker:(NSArray<SharedCodeTickModel *> *)ticker ideaAge:(int32_t)ideaAge intervalOption:(NSString *)intervalOption __attribute__((swift_name("doCopy(benchmark:ticker:ideaAge:intervalOption:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSArray<SharedCodeTickModel *> *benchmark __attribute__((swift_name("benchmark")));
@property (readonly) int32_t ideaAge __attribute__((swift_name("ideaAge")));
@property (readonly) NSString *intervalOption __attribute__((swift_name("intervalOption")));
@property (readonly) NSArray<SharedCodeTickModel *> *ticker __attribute__((swift_name("ticker")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GraphModel.Companion")))
@interface SharedCodeGraphModelCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("serializer()")));
@end;

__attribute__((swift_name("Idea")))
@protocol SharedCodeIdea
@required
@property (readonly) double alpha __attribute__((swift_name("alpha")));
@property (readonly) int32_t id __attribute__((swift_name("id")));
@property (readonly) NSString *securityName __attribute__((swift_name("securityName")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IdeaModel")))
@interface SharedCodeIdeaModel : KotlinBase <SharedCodeParcelable>
- (instancetype)initWithId:(int32_t)id securityName:(NSString *)securityName securityTicker:(NSString *)securityTicker alpha:(double)alpha benchMarkTicker:(NSString *)benchMarkTicker benchMarkCurrentPrice:(double)benchMarkCurrentPrice benchMarkPerformance:(double)benchMarkPerformance convictionId:(int32_t)convictionId currentPrice:(double)currentPrice direction:(NSString *)direction directionId:(int32_t)directionId entryPrice:(double)entryPrice reason:(NSString *)reason stockCurrency:(NSString *)stockCurrency stopLoss:(int32_t)stopLoss stopLossValue:(double)stopLossValue targetPrice:(double)targetPrice targetPricePercentage:(double)targetPricePercentage timeHorizon:(NSString *)timeHorizon createdBy:(NSString *)createdBy createdFrom:(NSString *)createdFrom previousCurrentPrice:(double)previousCurrentPrice isActive:(BOOL)isActive isPOAchieved:(BOOL)isPOAchieved isNewIdea:(BOOL)isNewIdea __attribute__((swift_name("init(id:securityName:securityTicker:alpha:benchMarkTicker:benchMarkCurrentPrice:benchMarkPerformance:convictionId:currentPrice:direction:directionId:entryPrice:reason:stockCurrency:stopLoss:stopLossValue:targetPrice:targetPricePercentage:timeHorizon:createdBy:createdFrom:previousCurrentPrice:isActive:isPOAchieved:isNewIdea:)"))) __attribute__((objc_designated_initializer));
- (int32_t)component1 __attribute__((swift_name("component1()")));
- (NSString *)component10 __attribute__((swift_name("component10()")));
- (int32_t)component11 __attribute__((swift_name("component11()")));
- (double)component12 __attribute__((swift_name("component12()")));
- (NSString *)component13 __attribute__((swift_name("component13()")));
- (NSString *)component14 __attribute__((swift_name("component14()")));
- (int32_t)component15 __attribute__((swift_name("component15()")));
- (double)component16 __attribute__((swift_name("component16()")));
- (double)component17 __attribute__((swift_name("component17()")));
- (double)component18 __attribute__((swift_name("component18()")));
- (NSString *)component19 __attribute__((swift_name("component19()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component20 __attribute__((swift_name("component20()")));
- (NSString *)component21 __attribute__((swift_name("component21()")));
- (double)component22 __attribute__((swift_name("component22()")));
- (BOOL)component23 __attribute__((swift_name("component23()")));
- (BOOL)component24 __attribute__((swift_name("component24()")));
- (BOOL)component25 __attribute__((swift_name("component25()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (double)component4 __attribute__((swift_name("component4()")));
- (NSString *)component5 __attribute__((swift_name("component5()")));
- (double)component6 __attribute__((swift_name("component6()")));
- (double)component7 __attribute__((swift_name("component7()")));
- (int32_t)component8 __attribute__((swift_name("component8()")));
- (double)component9 __attribute__((swift_name("component9()")));
- (SharedCodeIdeaModel *)doCopyId:(int32_t)id securityName:(NSString *)securityName securityTicker:(NSString *)securityTicker alpha:(double)alpha benchMarkTicker:(NSString *)benchMarkTicker benchMarkCurrentPrice:(double)benchMarkCurrentPrice benchMarkPerformance:(double)benchMarkPerformance convictionId:(int32_t)convictionId currentPrice:(double)currentPrice direction:(NSString *)direction directionId:(int32_t)directionId entryPrice:(double)entryPrice reason:(NSString *)reason stockCurrency:(NSString *)stockCurrency stopLoss:(int32_t)stopLoss stopLossValue:(double)stopLossValue targetPrice:(double)targetPrice targetPricePercentage:(double)targetPricePercentage timeHorizon:(NSString *)timeHorizon createdBy:(NSString *)createdBy createdFrom:(NSString *)createdFrom previousCurrentPrice:(double)previousCurrentPrice isActive:(BOOL)isActive isPOAchieved:(BOOL)isPOAchieved isNewIdea:(BOOL)isNewIdea __attribute__((swift_name("doCopy(id:securityName:securityTicker:alpha:benchMarkTicker:benchMarkCurrentPrice:benchMarkPerformance:convictionId:currentPrice:direction:directionId:entryPrice:reason:stockCurrency:stopLoss:stopLossValue:targetPrice:targetPricePercentage:timeHorizon:createdBy:createdFrom:previousCurrentPrice:isActive:isPOAchieved:isNewIdea:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property double alpha __attribute__((swift_name("alpha")));
@property double benchMarkCurrentPrice __attribute__((swift_name("benchMarkCurrentPrice")));
@property double benchMarkPerformance __attribute__((swift_name("benchMarkPerformance")));
@property NSString *benchMarkTicker __attribute__((swift_name("benchMarkTicker")));
@property int32_t convictionId __attribute__((swift_name("convictionId")));
@property NSString *createdBy __attribute__((swift_name("createdBy")));
@property NSString *createdFrom __attribute__((swift_name("createdFrom")));
@property double currentPrice __attribute__((swift_name("currentPrice")));
@property NSString *direction __attribute__((swift_name("direction")));
@property int32_t directionId __attribute__((swift_name("directionId")));
@property double entryPrice __attribute__((swift_name("entryPrice")));
@property (readonly) int32_t id __attribute__((swift_name("id")));
@property BOOL isActive __attribute__((swift_name("isActive")));
@property BOOL isNewIdea __attribute__((swift_name("isNewIdea")));
@property BOOL isPOAchieved __attribute__((swift_name("isPOAchieved")));
@property double previousCurrentPrice __attribute__((swift_name("previousCurrentPrice")));
@property NSString *reason __attribute__((swift_name("reason")));
@property (readonly) NSString *securityName __attribute__((swift_name("securityName")));
@property (readonly) NSString *securityTicker __attribute__((swift_name("securityTicker")));
@property NSString *stockCurrency __attribute__((swift_name("stockCurrency")));
@property int32_t stopLoss __attribute__((swift_name("stopLoss")));
@property double stopLossValue __attribute__((swift_name("stopLossValue")));
@property double targetPrice __attribute__((swift_name("targetPrice")));
@property double targetPricePercentage __attribute__((swift_name("targetPricePercentage")));
@property NSString *timeHorizon __attribute__((swift_name("timeHorizon")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IdeaModel.Companion")))
@interface SharedCodeIdeaModelCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("serializer()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("NotificationMessage")))
@interface SharedCodeNotificationMessage : KotlinBase
- (instancetype)initWithMessageHeader:(NSString *)messageHeader message:(NSString *)message by:(NSString *)by from:(NSString *)from ideaId:(int32_t)ideaId __attribute__((swift_name("init(messageHeader:message:by:from:ideaId:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (int32_t)component5 __attribute__((swift_name("component5()")));
- (SharedCodeNotificationMessage *)doCopyMessageHeader:(NSString *)messageHeader message:(NSString *)message by:(NSString *)by from:(NSString *)from ideaId:(int32_t)ideaId __attribute__((swift_name("doCopy(messageHeader:message:by:from:ideaId:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *by __attribute__((swift_name("by")));
@property (readonly) NSString *from __attribute__((swift_name("from")));
@property (readonly) int32_t ideaId __attribute__((swift_name("ideaId")));
@property (readonly) NSString *message __attribute__((swift_name("message")));
@property (readonly) NSString *messageHeader __attribute__((swift_name("messageHeader")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickModel")))
@interface SharedCodeTickModel : KotlinBase
- (instancetype)initWithSourceDate:(NSString *)sourceDate x:(double)x y:(double)y __attribute__((swift_name("init(sourceDate:x:y:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (double)component2 __attribute__((swift_name("component2()")));
- (double)component3 __attribute__((swift_name("component3()")));
- (SharedCodeTickModel *)doCopySourceDate:(NSString *)sourceDate x:(double)x y:(double)y __attribute__((swift_name("doCopy(sourceDate:x:y:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *sourceDate __attribute__((swift_name("sourceDate")));
@property (readonly) double x __attribute__((swift_name("x")));
@property (readonly) double y __attribute__((swift_name("y")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickModel.Companion")))
@interface SharedCodeTickModelCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("serializer()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickerModel")))
@interface SharedCodeTickerModel : KotlinBase
- (instancetype)initWithSymbol:(NSString *)symbol exchange:(NSString *)exchange name:(NSString *)name type:(NSString *)type region:(NSString *)region currency:(NSString *)currency isEnabled:(BOOL)isEnabled __attribute__((swift_name("init(symbol:exchange:name:type:region:currency:isEnabled:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (NSString *)component5 __attribute__((swift_name("component5()")));
- (NSString *)component6 __attribute__((swift_name("component6()")));
- (BOOL)component7 __attribute__((swift_name("component7()")));
- (SharedCodeTickerModel *)doCopySymbol:(NSString *)symbol exchange:(NSString *)exchange name:(NSString *)name type:(NSString *)type region:(NSString *)region currency:(NSString *)currency isEnabled:(BOOL)isEnabled __attribute__((swift_name("doCopy(symbol:exchange:name:type:region:currency:isEnabled:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *currency __attribute__((swift_name("currency")));
@property (readonly) NSString *exchange __attribute__((swift_name("exchange")));
@property (readonly) BOOL isEnabled __attribute__((swift_name("isEnabled")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) NSString *region __attribute__((swift_name("region")));
@property (readonly) NSString *symbol __attribute__((swift_name("symbol")));
@property (readonly) NSString *type __attribute__((swift_name("type")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickerModel.Companion")))
@interface SharedCodeTickerModelCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("serializer()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickerPriceModel")))
@interface SharedCodeTickerPriceModel : KotlinBase
- (instancetype)initWithSymbol:(NSString *)symbol companyName:(NSString *)companyName latestPrice:(double)latestPrice lastTradeTime:(int64_t)lastTradeTime __attribute__((swift_name("init(symbol:companyName:latestPrice:lastTradeTime:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (double)component3 __attribute__((swift_name("component3()")));
- (int64_t)component4 __attribute__((swift_name("component4()")));
- (SharedCodeTickerPriceModel *)doCopySymbol:(NSString *)symbol companyName:(NSString *)companyName latestPrice:(double)latestPrice lastTradeTime:(int64_t)lastTradeTime __attribute__((swift_name("doCopy(symbol:companyName:latestPrice:lastTradeTime:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *companyName __attribute__((swift_name("companyName")));
@property (readonly) int64_t lastTradeTime __attribute__((swift_name("lastTradeTime")));
@property (readonly) double latestPrice __attribute__((swift_name("latestPrice")));
@property (readonly) NSString *symbol __attribute__((swift_name("symbol")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("TickerPriceModel.Companion")))
@interface SharedCodeTickerPriceModelCompanion : KotlinBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("serializer()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IdeaRepository")))
@interface SharedCodeIdeaRepository : KotlinBase
- (instancetype)initWithBaseUrl:(NSString *)baseUrl __attribute__((swift_name("init(baseUrl:)"))) __attribute__((objc_designated_initializer));
- (void)closeIdeaIdeaModel:(SharedCodeIdeaModel *)ideaModel success:(void (^)(void))success __attribute__((swift_name("closeIdea(ideaModel:success:)")));
- (void)fetchGraphIdeaId:(int32_t)ideaId success:(void (^)(SharedCodeGraphModel *))success __attribute__((swift_name("fetchGraph(ideaId:success:)")));
- (void)fetchIdeasSuccess:(void (^)(NSArray<SharedCodeIdeaModel *> *))success __attribute__((swift_name("fetchIdeas(success:)")));
- (void)fetchTickerPriceTicker:(NSString *)ticker success:(void (^)(SharedCodeTickerPriceModel *))success __attribute__((swift_name("fetchTickerPrice(ticker:success:)")));
- (void)fetchTickersTickerFilter:(NSString *)tickerFilter success:(void (^)(NSArray<SharedCodeTickerModel *> *))success __attribute__((swift_name("fetchTickers(tickerFilter:success:)")));
- (void)saveIdeaIdeaModel:(SharedCodeIdeaModel *)ideaModel success:(void (^)(void))success __attribute__((swift_name("saveIdea(ideaModel:success:)")));
@property (readonly) NSString *baseUrl __attribute__((swift_name("baseUrl")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CommonKt")))
@interface SharedCodeCommonKt : KotlinBase
+ (NSString *)createApplicationScreenMessage __attribute__((swift_name("createApplicationScreenMessage()")));
+ (void)inspect __attribute__((swift_name("inspect()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ActualKt")))
@interface SharedCodeActualKt : KotlinBase
+ (NSString *)platformName __attribute__((swift_name("platformName()")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeSerializationStrategy")))
@protocol SharedCodeKotlinx_serialization_runtimeSerializationStrategy
@required
- (void)serializeEncoder:(id<SharedCodeKotlinx_serialization_runtimeEncoder>)encoder obj:(id _Nullable)obj __attribute__((swift_name("serialize(encoder:obj:)")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor> descriptor __attribute__((swift_name("descriptor")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeDeserializationStrategy")))
@protocol SharedCodeKotlinx_serialization_runtimeDeserializationStrategy
@required
- (id _Nullable)deserializeDecoder:(id<SharedCodeKotlinx_serialization_runtimeDecoder>)decoder __attribute__((swift_name("deserialize(decoder:)")));
- (id _Nullable)patchDecoder:(id<SharedCodeKotlinx_serialization_runtimeDecoder>)decoder old:(id _Nullable)old __attribute__((swift_name("patch(decoder:old:)")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor> descriptor __attribute__((swift_name("descriptor")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeKSerializer")))
@protocol SharedCodeKotlinx_serialization_runtimeKSerializer <SharedCodeKotlinx_serialization_runtimeSerializationStrategy, SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>
@required
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeEncoder")))
@protocol SharedCodeKotlinx_serialization_runtimeEncoder
@required
- (id<SharedCodeKotlinx_serialization_runtimeCompositeEncoder>)beginCollectionDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc collectionSize:(int32_t)collectionSize typeParams:(SharedCodeKotlinArray *)typeParams __attribute__((swift_name("beginCollection(desc:collectionSize:typeParams:)")));
- (id<SharedCodeKotlinx_serialization_runtimeCompositeEncoder>)beginStructureDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc typeParams:(SharedCodeKotlinArray *)typeParams __attribute__((swift_name("beginStructure(desc:typeParams:)")));
- (void)encodeBooleanValue:(BOOL)value __attribute__((swift_name("encodeBoolean(value:)")));
- (void)encodeByteValue:(int8_t)value __attribute__((swift_name("encodeByte(value:)")));
- (void)encodeCharValue:(unichar)value __attribute__((swift_name("encodeChar(value:)")));
- (void)encodeDoubleValue:(double)value __attribute__((swift_name("encodeDouble(value:)")));
- (void)encodeEnumEnumDescription:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)enumDescription ordinal:(int32_t)ordinal __attribute__((swift_name("encodeEnum(enumDescription:ordinal:)")));
- (void)encodeFloatValue:(float)value __attribute__((swift_name("encodeFloat(value:)")));
- (void)encodeIntValue:(int32_t)value __attribute__((swift_name("encodeInt(value:)")));
- (void)encodeLongValue:(int64_t)value __attribute__((swift_name("encodeLong(value:)")));
- (void)encodeNotNullMark __attribute__((swift_name("encodeNotNullMark()")));
- (void)encodeNull __attribute__((swift_name("encodeNull()")));
- (void)encodeNullableSerializableValueSerializer:(id<SharedCodeKotlinx_serialization_runtimeSerializationStrategy>)serializer value:(id _Nullable)value __attribute__((swift_name("encodeNullableSerializableValue(serializer:value:)")));
- (void)encodeSerializableValueSerializer:(id<SharedCodeKotlinx_serialization_runtimeSerializationStrategy>)serializer value:(id _Nullable)value __attribute__((swift_name("encodeSerializableValue(serializer:value:)")));
- (void)encodeShortValue:(int16_t)value __attribute__((swift_name("encodeShort(value:)")));
- (void)encodeStringValue:(NSString *)value __attribute__((swift_name("encodeString(value:)")));
- (void)encodeUnit __attribute__((swift_name("encodeUnit()")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialModule> context __attribute__((swift_name("context")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeSerialDescriptor")))
@protocol SharedCodeKotlinx_serialization_runtimeSerialDescriptor
@required
- (NSArray<id<SharedCodeKotlinAnnotation>> *)getElementAnnotationsIndex:(int32_t)index __attribute__((swift_name("getElementAnnotations(index:)")));
- (id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)getElementDescriptorIndex:(int32_t)index __attribute__((swift_name("getElementDescriptor(index:)")));
- (int32_t)getElementIndexName:(NSString *)name __attribute__((swift_name("getElementIndex(name:)")));
- (NSString *)getElementNameIndex:(int32_t)index __attribute__((swift_name("getElementName(index:)")));
- (NSArray<id<SharedCodeKotlinAnnotation>> *)getEntityAnnotations __attribute__((swift_name("getEntityAnnotations()")));
- (BOOL)isElementOptionalIndex:(int32_t)index __attribute__((swift_name("isElementOptional(index:)")));
@property (readonly) int32_t elementsCount __attribute__((swift_name("elementsCount")));
@property (readonly) BOOL isNullable __attribute__((swift_name("isNullable")));
@property (readonly) SharedCodeKotlinx_serialization_runtimeSerialKind *kind __attribute__((swift_name("kind")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeDecoder")))
@protocol SharedCodeKotlinx_serialization_runtimeDecoder
@required
- (id<SharedCodeKotlinx_serialization_runtimeCompositeDecoder>)beginStructureDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc typeParams:(SharedCodeKotlinArray *)typeParams __attribute__((swift_name("beginStructure(desc:typeParams:)")));
- (BOOL)decodeBoolean __attribute__((swift_name("decodeBoolean()")));
- (int8_t)decodeByte __attribute__((swift_name("decodeByte()")));
- (unichar)decodeChar __attribute__((swift_name("decodeChar()")));
- (double)decodeDouble __attribute__((swift_name("decodeDouble()")));
- (int32_t)decodeEnumEnumDescription:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)enumDescription __attribute__((swift_name("decodeEnum(enumDescription:)")));
- (float)decodeFloat __attribute__((swift_name("decodeFloat()")));
- (int32_t)decodeInt __attribute__((swift_name("decodeInt()")));
- (int64_t)decodeLong __attribute__((swift_name("decodeLong()")));
- (BOOL)decodeNotNullMark __attribute__((swift_name("decodeNotNullMark()")));
- (SharedCodeKotlinNothing * _Nullable)decodeNull __attribute__((swift_name("decodeNull()")));
- (id _Nullable)decodeNullableSerializableValueDeserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer __attribute__((swift_name("decodeNullableSerializableValue(deserializer:)")));
- (id _Nullable)decodeSerializableValueDeserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer __attribute__((swift_name("decodeSerializableValue(deserializer:)")));
- (int16_t)decodeShort __attribute__((swift_name("decodeShort()")));
- (NSString *)decodeString __attribute__((swift_name("decodeString()")));
- (void)decodeUnit __attribute__((swift_name("decodeUnit()")));
- (id _Nullable)updateNullableSerializableValueDeserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer old:(id _Nullable)old __attribute__((swift_name("updateNullableSerializableValue(deserializer:old:)")));
- (id _Nullable)updateSerializableValueDeserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer old:(id _Nullable)old __attribute__((swift_name("updateSerializableValue(deserializer:old:)")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialModule> context __attribute__((swift_name("context")));
@property (readonly) SharedCodeKotlinx_serialization_runtimeUpdateMode *updateMode __attribute__((swift_name("updateMode")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeCompositeEncoder")))
@protocol SharedCodeKotlinx_serialization_runtimeCompositeEncoder
@required
- (void)encodeBooleanElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(BOOL)value __attribute__((swift_name("encodeBooleanElement(desc:index:value:)")));
- (void)encodeByteElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(int8_t)value __attribute__((swift_name("encodeByteElement(desc:index:value:)")));
- (void)encodeCharElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(unichar)value __attribute__((swift_name("encodeCharElement(desc:index:value:)")));
- (void)encodeDoubleElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(double)value __attribute__((swift_name("encodeDoubleElement(desc:index:value:)")));
- (void)encodeFloatElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(float)value __attribute__((swift_name("encodeFloatElement(desc:index:value:)")));
- (void)encodeIntElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(int32_t)value __attribute__((swift_name("encodeIntElement(desc:index:value:)")));
- (void)encodeLongElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(int64_t)value __attribute__((swift_name("encodeLongElement(desc:index:value:)")));
- (void)encodeNonSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(id)value __attribute__((swift_name("encodeNonSerializableElement(desc:index:value:)")));
- (void)encodeNullableSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index serializer:(id<SharedCodeKotlinx_serialization_runtimeSerializationStrategy>)serializer value:(id _Nullable)value __attribute__((swift_name("encodeNullableSerializableElement(desc:index:serializer:value:)")));
- (void)encodeSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index serializer:(id<SharedCodeKotlinx_serialization_runtimeSerializationStrategy>)serializer value:(id _Nullable)value __attribute__((swift_name("encodeSerializableElement(desc:index:serializer:value:)")));
- (void)encodeShortElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(int16_t)value __attribute__((swift_name("encodeShortElement(desc:index:value:)")));
- (void)encodeStringElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index value:(NSString *)value __attribute__((swift_name("encodeStringElement(desc:index:value:)")));
- (void)encodeUnitElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("encodeUnitElement(desc:index:)")));
- (void)endStructureDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc __attribute__((swift_name("endStructure(desc:)")));
- (BOOL)shouldEncodeElementDefaultDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("shouldEncodeElementDefault(desc:index:)")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialModule> context __attribute__((swift_name("context")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinArray")))
@interface SharedCodeKotlinArray : KotlinBase
+ (instancetype)arrayWithSize:(int32_t)size init:(id _Nullable (^)(SharedCodeInt *))init __attribute__((swift_name("init(size:init:)")));
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (id _Nullable)getIndex:(int32_t)index __attribute__((swift_name("get(index:)")));
- (id<SharedCodeKotlinIterator>)iterator __attribute__((swift_name("iterator()")));
- (void)setIndex:(int32_t)index value:(id _Nullable)value __attribute__((swift_name("set(index:value:)")));
@property (readonly) int32_t size __attribute__((swift_name("size")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeSerialModule")))
@protocol SharedCodeKotlinx_serialization_runtimeSerialModule
@required
- (void)dumpToCollector:(id<SharedCodeKotlinx_serialization_runtimeSerialModuleCollector>)collector __attribute__((swift_name("dumpTo(collector:)")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer> _Nullable)getContextualKclass:(id<SharedCodeKotlinKClass>)kclass __attribute__((swift_name("getContextual(kclass:)")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer> _Nullable)getPolymorphicBaseClass:(id<SharedCodeKotlinKClass>)baseClass value:(id)value __attribute__((swift_name("getPolymorphic(baseClass:value:)")));
- (id<SharedCodeKotlinx_serialization_runtimeKSerializer> _Nullable)getPolymorphicBaseClass:(id<SharedCodeKotlinKClass>)baseClass serializedClassName:(NSString *)serializedClassName __attribute__((swift_name("getPolymorphic(baseClass:serializedClassName:)")));
@end;

__attribute__((swift_name("KotlinAnnotation")))
@protocol SharedCodeKotlinAnnotation
@required
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeSerialKind")))
@interface SharedCodeKotlinx_serialization_runtimeSerialKind : KotlinBase
- (NSString *)description __attribute__((swift_name("description()")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeCompositeDecoder")))
@protocol SharedCodeKotlinx_serialization_runtimeCompositeDecoder
@required
- (BOOL)decodeBooleanElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeBooleanElement(desc:index:)")));
- (int8_t)decodeByteElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeByteElement(desc:index:)")));
- (unichar)decodeCharElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeCharElement(desc:index:)")));
- (int32_t)decodeCollectionSizeDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc __attribute__((swift_name("decodeCollectionSize(desc:)")));
- (double)decodeDoubleElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeDoubleElement(desc:index:)")));
- (int32_t)decodeElementIndexDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc __attribute__((swift_name("decodeElementIndex(desc:)")));
- (float)decodeFloatElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeFloatElement(desc:index:)")));
- (int32_t)decodeIntElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeIntElement(desc:index:)")));
- (int64_t)decodeLongElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeLongElement(desc:index:)")));
- (id _Nullable)decodeNullableSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index deserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer __attribute__((swift_name("decodeNullableSerializableElement(desc:index:deserializer:)")));
- (id _Nullable)decodeSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index deserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer __attribute__((swift_name("decodeSerializableElement(desc:index:deserializer:)")));
- (int16_t)decodeShortElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeShortElement(desc:index:)")));
- (NSString *)decodeStringElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeStringElement(desc:index:)")));
- (void)decodeUnitElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index __attribute__((swift_name("decodeUnitElement(desc:index:)")));
- (void)endStructureDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc __attribute__((swift_name("endStructure(desc:)")));
- (id _Nullable)updateNullableSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index deserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer old:(id _Nullable)old __attribute__((swift_name("updateNullableSerializableElement(desc:index:deserializer:old:)")));
- (id _Nullable)updateSerializableElementDesc:(id<SharedCodeKotlinx_serialization_runtimeSerialDescriptor>)desc index:(int32_t)index deserializer:(id<SharedCodeKotlinx_serialization_runtimeDeserializationStrategy>)deserializer old:(id _Nullable)old __attribute__((swift_name("updateSerializableElement(desc:index:deserializer:old:)")));
@property (readonly) id<SharedCodeKotlinx_serialization_runtimeSerialModule> context __attribute__((swift_name("context")));
@property (readonly) SharedCodeKotlinx_serialization_runtimeUpdateMode *updateMode __attribute__((swift_name("updateMode")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinNothing")))
@interface SharedCodeKotlinNothing : KotlinBase
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Kotlinx_serialization_runtimeUpdateMode")))
@interface SharedCodeKotlinx_serialization_runtimeUpdateMode : SharedCodeKotlinEnum
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) SharedCodeKotlinx_serialization_runtimeUpdateMode *banned __attribute__((swift_name("banned")));
@property (class, readonly) SharedCodeKotlinx_serialization_runtimeUpdateMode *overwrite __attribute__((swift_name("overwrite")));
@property (class, readonly) SharedCodeKotlinx_serialization_runtimeUpdateMode *update __attribute__((swift_name("update")));
- (int32_t)compareToOther:(SharedCodeKotlinx_serialization_runtimeUpdateMode *)other __attribute__((swift_name("compareTo(other:)")));
@end;

__attribute__((swift_name("KotlinIterator")))
@protocol SharedCodeKotlinIterator
@required
- (BOOL)hasNext __attribute__((swift_name("hasNext()")));
- (id _Nullable)next __attribute__((swift_name("next()")));
@end;

__attribute__((swift_name("Kotlinx_serialization_runtimeSerialModuleCollector")))
@protocol SharedCodeKotlinx_serialization_runtimeSerialModuleCollector
@required
- (void)contextualKClass:(id<SharedCodeKotlinKClass>)kClass serializer:(id<SharedCodeKotlinx_serialization_runtimeKSerializer>)serializer __attribute__((swift_name("contextual(kClass:serializer:)")));
- (void)polymorphicBaseClass:(id<SharedCodeKotlinKClass>)baseClass actualClass:(id<SharedCodeKotlinKClass>)actualClass actualSerializer:(id<SharedCodeKotlinx_serialization_runtimeKSerializer>)actualSerializer __attribute__((swift_name("polymorphic(baseClass:actualClass:actualSerializer:)")));
@end;

__attribute__((swift_name("KotlinKDeclarationContainer")))
@protocol SharedCodeKotlinKDeclarationContainer
@required
@end;

__attribute__((swift_name("KotlinKAnnotatedElement")))
@protocol SharedCodeKotlinKAnnotatedElement
@required
@end;

__attribute__((swift_name("KotlinKClassifier")))
@protocol SharedCodeKotlinKClassifier
@required
@end;

__attribute__((swift_name("KotlinKClass")))
@protocol SharedCodeKotlinKClass <SharedCodeKotlinKDeclarationContainer, SharedCodeKotlinKAnnotatedElement, SharedCodeKotlinKClassifier>
@required
- (BOOL)isInstanceValue:(id _Nullable)value __attribute__((swift_name("isInstance(value:)")));
@property (readonly) NSString * _Nullable qualifiedName __attribute__((swift_name("qualifiedName")));
@property (readonly) NSString * _Nullable simpleName __attribute__((swift_name("simpleName")));
@end;

#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
