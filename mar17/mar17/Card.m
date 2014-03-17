//
//  Card.m
//  mar17
//
//  Created by Erhan Hu on 3/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "Card.h"

@implementation Card

//@synthesize contents = _contents; //this is done automatically

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}


@end
