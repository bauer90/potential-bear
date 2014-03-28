//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Erhan Hu on 3/29/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype) init
{
    self = [super init];
    if (self) {
        for (NSString *suit_index in [PlayingCard validSuits]) {
            for (NSUInteger rank_index = 1; rank_index <= [PlayingCard maxRank]; rank_index++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit_index;
                card.rank = rank_index;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
