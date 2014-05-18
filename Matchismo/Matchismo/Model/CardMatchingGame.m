//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by ERHAN HU on 4/1/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@end

@implementation CardMatchingGame


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)playingHistory
{
    if (!_playingHistory) _playingHistory = [[NSMutableArray alloc] init];
    return _playingHistory;
}

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    return nil;
}

- (BOOL)isNewGame
{
    return self.stepCount == 0;
}

- (void)addToPlayingHistoryWithMove:(NSUInteger)moveForThisClick
                           andCards:(NSArray *)listOfCards
                            andCard:(PlayingCard *)aCard
                           andScore:(NSInteger)score
{
    return;
}


- (void) unChooseLastSelections
{
    return;
}

// what happens when cards[index] is clicked -
// matchMdoe == 2 for Matchismo; 3 for Set.
- (void)chooseCardAtIndex:(NSUInteger)index
{
    return;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= [self.cards count]) ? self.cards[index] : nil;
}


@end
