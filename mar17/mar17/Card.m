//
//  Card.m
//  mar17
//
//  Created by Erhan Hu on 3/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize contents = _contents;

- (int)match:(Card *)card {
    int score = 0;
    if ([card.contents isEqualToString:self.contents]) {
        score = 1;
    }
    return score;
}


@end
