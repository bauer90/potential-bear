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
    self.matchMode = 2;
    self.score = 0;
    self.stepCount = 0;
    return self;
}


- (BOOL)isNewGame
{
    return self.stepCount == 0;
}

- (void) unChooselastSelections
{
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            card.chosen = NO;
        }
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    self.stepCount++;
    PlayingCard *card = (PlayingCard *)[self cardAtIndex:index];
    NSArray* eligibles = [card UnMatchedAndChosen:self.cards];
    NSLog(@"%d %d",[eligibles count], self.matchMode);
    if ([eligibles count] == self.matchMode) {
        [self unChooselastSelections];
    }
    if ([eligibles count] == (self.matchMode - 1)) {
        NSLog(@"wow");
        int matchScore = (self.matchMode == 2) ? [card match:eligibles] : [card match3:eligibles];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
        } else {
            self.score -= MISMATCH_PENALTY;
        }
    } else {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= [self.cards count]) ? self.cards[index] : nil;
}



@end
