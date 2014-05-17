//
//  MatchismoGame.m
//  Matchismo
//
//  Created by Erhan Hu on 5/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "MatchismoGame.h"

@implementation MatchismoGame


// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init]; //calling NSObject's initializer
    if (self) { // error checking for mem alloc failure
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card)
                [self.cards addObject:card];
            else { // addObject:nil will cause error
                self = nil;
                break;
            }
        }
    }
    self.matchMode = 2;
    self.score = 0;
    self.stepCount = 0;
    return self;
}

@end
