//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by ERHAN HU on 4/1/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger stepCount;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; //calling NSObject's initializer
    if (self) { // error checking for mem alloc failure
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else { // addObject:nil will cause error
                self = nil;
                break;
            }
        }
    }
    self.score = 0;
    self.stepCount = 0;
    return self;
}


- (BOOL)isNewGame
{
    return self.stepCount == 0;
}

- (NSArray *)chosenCards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if (card.isChosen) {
            [result addObject:card];
        }
    }
    return result;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) { // matched cards are "out of game"
        if (card.isChosen) { // toggle between Chosen / !Chosen
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) { // matchScore > 0
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES; // mark both cards to -
                        otherCard.matched = YES; // be "out of game"
                    } else { // no match
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.stepCount++;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= [self.cards count]) ? self.cards[index] : nil;
}

@end
