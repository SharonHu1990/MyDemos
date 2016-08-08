//
//  DTCSSListStyle.h
//  CoreTextExtensions
//
//  Created by Oliver Drobnik on 8/11/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

typedef enum
{
    DTCSSListStyleTypeInherit = 0,
    DTCSSListStyleTypeNone,
    DTCSSListStyleTypeCircle,
    DTCSSListStyleTypeDecimal,
    DTCSSListStyleTypeDecimalLeadingZero,
    DTCSSListStyleTypeDisc,
    DTCSSListStyleTypeUpperAlpha,
    DTCSSListStyleTypeUpperLatin,
    DTCSSListStyleTypeLowerAlpha,
    DTCSSListStyleTypeLowerLatin,
    DTCSSListStyleTypePlus,
    DTCSSListStyleTypeUnderscore,
	DTCSSListStyleTypeImage,
    DTCSSListStyleTypeNotFound
} DTCSSListStyleType;

typedef enum
{
	DTCSSListStylePositionInherit = 0,
	DTCSSListStylePositionInside,
	DTCSSListStylePositionOutside,
    DTCSSListStylePositionNotFound
} DTCSSListStylePosition;

@interface DTCSSListStyle : NSObject
{
	BOOL _inherit;
	
	DTCSSListStyleType _type;
	DTCSSListStylePosition _position;
	
	NSString *_imageName;
}

@property (nonatomic, assign) BOOL inherit; 
@property (nonatomic, assign) DTCSSListStyleType type;
@property (nonatomic, assign) DTCSSListStylePosition position;
@property (nonatomic, copy) NSString *imageName;

+ (DTCSSListStyle *)listStyleWithStyles:(NSDictionary *)styles;
+ (DTCSSListStyle *)decimalListStyle;
+ (DTCSSListStyle *)discListStyle;
+ (DTCSSListStyle *)inheritedListStyle;

+ (DTCSSListStyleType)listStyleTypeFromString:(NSString *)string;
+ (DTCSSListStylePosition)listStylePositionFromString:(NSString *)string;

- (id)initWithStyles:(NSDictionary *)styles;

- (NSString *)prefixWithCounter:(NSInteger)counter;

@end
