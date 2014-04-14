//
//  playingRecord.m
//  Matchismo
//
//  Created by Erhan Hu on 4/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "playingRecord.h"

@implementation playingRecord

- (NSArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithMove:(NSUInteger)theMove
                     andCards:(NSArray *)theCards
                      andCard:(PlayingCard *)theCard
{
    self = [super init];
    if (self) {
        self.move = theMove;
        if (theCards != nil && [theCards count] > 0) {
            [self.cards addObjectsFromArray:theCards];
        }
        if (theCard != nil) {
            [self.cards addObject:theCard]; 
        }
    }
    return self;
}

@end
