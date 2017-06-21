//
//  NSString+Muse.m
//  neuro
//
//  Created by Mert Neşvat on 21/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "NSString+Muse.h"

@implementation NSString (Muse)


- (NSArray *)fetchMuseOptions{
    NSArray *museOptions = @[@"IXNMuseDataPacketTypeAccelerometer",
                             @"IXNMuseDataPacketTypeGyro",
                             @"IXNMuseDataPacketTypeEeg",
                             @"IXNMuseDataPacketTypeDroppedAccelerometer",
                             @"IXNMuseDataPacketTypeDroppedEeg",
                             @"IXNMuseDataPacketTypeQuantization",
                             @"IXNMuseDataPacketTypeBattery",
                             @"IXNMuseDataPacketTypeDrlRef",
                             @"IXNMuseDataPacketTypeAlphaAbsolute",
                             @"IXNMuseDataPacketTypeBetaAbsolute",
                             @"IXNMuseDataPacketTypeDeltaAbsolute",
                             @"IXNMuseDataPacketTypeThetaAbsolute",
                             @"IXNMuseDataPacketTypeGammaAbsolute",
                             @"IXNMuseDataPacketTypeAlphaRelative",
                             @"IXNMuseDataPacketTypeBetaRelative",
                             @"IXNMuseDataPacketTypeDeltaRelative",
                             @"IXNMuseDataPacketTypeThetaRelative",
                             @"IXNMuseDataPacketTypeGammaRelative",
                             @"IXNMuseDataPacketTypeAlphaScore",
                             @"IXNMuseDataPacketTypeBetaScore",
                             @"IXNMuseDataPacketTypeDeltaScore",
                             @"IXNMuseDataPacketTypeThetaScore",
                             @"IXNMuseDataPacketTypeGammaScore",
                             @"IXNMuseDataPacketTypeIsGood",
                             @"IXNMuseDataPacketTypeHsi",
                             @"IXNMuseDataPacketTypeHsiPrecision",
                             @"IXNMuseDataPacketTypeArtifacts",
                             @"IXNMuseDataPacketTypeTotal"
                             ];

    return museOptions;
}

- (NSString *)fetchMuseStringFromInt:(NSNumber *)index{
    NSArray *museOptions = @[@"IXNMuseDataPacketTypeAccelerometer",
                             @"IXNMuseDataPacketTypeGyro",
                             @"IXNMuseDataPacketTypeEeg",
                             @"IXNMuseDataPacketTypeDroppedAccelerometer",
                             @"IXNMuseDataPacketTypeDroppedEeg",
                             @"IXNMuseDataPacketTypeQuantization",
                             @"IXNMuseDataPacketTypeBattery",
                             @"IXNMuseDataPacketTypeDrlRef",
                             @"IXNMuseDataPacketTypeAlphaAbsolute",
                             @"IXNMuseDataPacketTypeBetaAbsolute",
                             @"IXNMuseDataPacketTypeDeltaAbsolute",
                             @"IXNMuseDataPacketTypeThetaAbsolute",
                             @"IXNMuseDataPacketTypeGammaAbsolute",
                             @"IXNMuseDataPacketTypeAlphaRelative",
                             @"IXNMuseDataPacketTypeBetaRelative",
                             @"IXNMuseDataPacketTypeDeltaRelative",
                             @"IXNMuseDataPacketTypeThetaRelative",
                             @"IXNMuseDataPacketTypeGammaRelative",
                             @"IXNMuseDataPacketTypeAlphaScore",
                             @"IXNMuseDataPacketTypeBetaScore",
                             @"IXNMuseDataPacketTypeDeltaScore",
                             @"IXNMuseDataPacketTypeThetaScore",
                             @"IXNMuseDataPacketTypeGammaScore",
                             @"IXNMuseDataPacketTypeIsGood",
                             @"IXNMuseDataPacketTypeHsi",
                             @"IXNMuseDataPacketTypeHsiPrecision",
                             @"IXNMuseDataPacketTypeArtifacts",
                             @"IXNMuseDataPacketTypeTotal"
                             ];
    
    return museOptions[index.integerValue];
    
}





- (NSString*)formatIXNDataPacketTypeToString:(IXNMuseDataPacketType)formatType {
    NSString *result = nil;
    
    switch(formatType) {
        case IXNMuseDataPacketTypeAccelerometer:
            result = @"IXNMuseDataPacketTypeAccelerometer";
            break;
        case IXNMuseDataPacketTypeGyro:
            result = @"IXNMuseDataPacketTypeGyro";
            break;
        case IXNMuseDataPacketTypeEeg:
            result = @"IXNMuseDataPacketTypeEeg";
            break;
        case IXNMuseDataPacketTypeDroppedAccelerometer:
            result = @"IXNMuseDataPacketTypeDroppedAccelerometer";
            break;
        case IXNMuseDataPacketTypeDroppedEeg:
            result = @"IXNMuseDataPacketTypeDroppedEeg";
            break;
        case IXNMuseDataPacketTypeQuantization:
            result = @"IXNMuseDataPacketTypeQuantization";
            break;
        case IXNMuseDataPacketTypeBattery:
            result = @"IXNMuseDataPacketTypeBattery";
            break;
        case IXNMuseDataPacketTypeDrlRef:
            result = @"IXNMuseDataPacketTypeDrlRef";
            break;
        case IXNMuseDataPacketTypeAlphaAbsolute:
            result = @"IXNMuseDataPacketTypeAlphaAbsolute";
            break;
        case IXNMuseDataPacketTypeBetaAbsolute:
            result = @"IXNMuseDataPacketTypeBetaAbsolute";
            break;
        case IXNMuseDataPacketTypeDeltaAbsolute:
            result = @"IXNMuseDataPacketTypeDeltaAbsolute";
            break;
        case IXNMuseDataPacketTypeThetaAbsolute:
            result = @"IXNMuseDataPacketTypeThetaAbsolute";
            break;
        case IXNMuseDataPacketTypeGammaAbsolute:
            result = @"IXNMuseDataPacketTypeGammaAbsolute";
            break;
        case IXNMuseDataPacketTypeAlphaRelative:
            result = @"IXNMuseDataPacketTypeAlphaRelative";
            break;
        case IXNMuseDataPacketTypeBetaRelative:
            result = @"IXNMuseDataPacketTypeBetaRelative";
            break;
        case IXNMuseDataPacketTypeDeltaRelative:
            result = @"IXNMuseDataPacketTypeDeltaRelative";
            break;
        case IXNMuseDataPacketTypeThetaRelative:
            result = @"IXNMuseDataPacketTypeThetaRelative";
            break;
        case IXNMuseDataPacketTypeGammaRelative:
            result = @"IXNMuseDataPacketTypeGammaRelative";
            break;
        case IXNMuseDataPacketTypeAlphaScore:
            result = @"IXNMuseDataPacketTypeAlphaScore";
            break;
        case IXNMuseDataPacketTypeBetaScore:
            result = @"IXNMuseDataPacketTypeBetaScore";
            break;
        case IXNMuseDataPacketTypeDeltaScore:
            result = @"IXNMuseDataPacketTypeDeltaScore";
            break;
        case IXNMuseDataPacketTypeThetaScore:
            result = @"IXNMuseDataPacketTypeThetaScore";
            break;
        case IXNMuseDataPacketTypeGammaScore:
            result = @"IXNMuseDataPacketTypeGammaScore";
            break;
        case IXNMuseDataPacketTypeIsGood:
            result = @"IXNMuseDataPacketTypeIsGood";
            break;
        case IXNMuseDataPacketTypeHsi:
            result = @"IXNMuseDataPacketTypeHsi";
            break;
        case IXNMuseDataPacketTypeHsiPrecision:
            result = @"IXNMuseDataPacketTypeHsiPrecision";
            break;
        case IXNMuseDataPacketTypeArtifacts:
            result = @"IXNMuseDataPacketTypeArtifacts";
            break;
        case IXNMuseDataPacketTypeTotal:
            result = @"IXNMuseDataPacketTypeTotal";
            break;
            
            
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    
    return result;
}


@end
