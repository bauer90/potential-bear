//
//  SetCardGame.m
//  Matchismo
//
//  Created by Erhan Hu on 5/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (nonatomic, strong) NSMutableArray* appearedCards; //speccially for SetCardGame. An array of cards that already appeared (dealt)
@end

@implementation SetCardGame

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
    self.matchMode = 3;
    self.score = 0;
    self.stepCount = 0;
    return self;
}

- (NSArray *)cardsShown
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (SetCard *card in self.cards) {
        if (!card.matched && card.alreadyAppeared) {
            [arr addObject:card];
        }
    }
    return (NSArray *)arr;
}

- (NSArray *)deal3
{
    // make sure there are enough such cards
    NSMutableArray *holder = [[NSMutableArray alloc] init];
    int eligibleCount = 0;
    for (SetCard *card in self.cards) {
        if (!card.alreadyAppeared) {
            eligibleCount++;
        }
    }
    if (eligibleCount < 3) return nil;

    // copy 3 cards to the 'holder'
    for (SetCard *card in self.cards) {
        if (!card.alreadyAppeared) {
            [holder addObject:card];
            card.alreadyAppeared = YES;
        }
    }

    //return the array of those 3 cards.
    return (NSArray *)holder;
}


@end
