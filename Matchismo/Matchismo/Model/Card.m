//
//  Card.m
//  Matchismo
//
//  Created by Erhan Hu on 3/25/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSArray *)UnMatchedAndChosen:(NSArray *)cards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Card *_card in cards) {
        if (_card.isChosen && !_card.isMatched && _card != self) [result addObject:_card];
    }
    return (NSArray *)result;
}

@end
