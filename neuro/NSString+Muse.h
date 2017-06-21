//
//  NSString+Muse.h
//  neuro
//
//  Created by Mert Neşvat on 21/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Muse/Muse.h>

@interface NSString (Muse)
- (NSString*)formatIXNDataPacketTypeToString:(IXNMuseDataPacketType)formatType;
- (NSArray *)fetchMuseOptions;
- (NSString *)fetchMuseStringFromInt:(NSNumber *)index;
@end
