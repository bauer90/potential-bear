//
//  PlayingCard.m
//  Matchismo
//
//  Created by Erhan Hu on 3/29/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//


#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

// overriding match: of Card, but need no re-declaration
// automatically test if 'other' is eligible for match-test
// and returns the score
- (int)match:(NSArray *)Cards
{
    if ([Cards count] == 1) {
        PlayingCard *card = (PlayingCard *)(Cards[0]);
        if (card.rank == self.rank)
            return 5;
        else if ([card.suit isEqualToString:self.suit])
            return 2;
    }
    return 0;
}

// match for 3-card mode
// automatically test if 'other[0]' and 'other[1]' are eligible for match-test
// and returns the score
- (int)match3:(NSArray *)Cards
{
    if ([Cards count] == 2) {
        PlayingCard *firstCard = (PlayingCard *)(Cards[0]);
        PlayingCard *secondCard = (PlayingCard *)(Cards[1]);
        if (self.rank == firstCard.rank && self.rank == secondCard.rank)
            return  20;
        else if ([self.suit isEqualToString:firstCard.suit] && [self.suit isEqualToString:secondCard.suit])
            return 10;
        else if (self.rank == firstCard.rank || self.rank == secondCard.rank || firstCard.rank == secondCard.rank)
            return 3;
        else if ([self.suit isEqualToString:firstCard.suit] || [self.suit isEqualToString:secondCard.suit] || [firstCard.suit isEqualToString:secondCard.suit])
            return 1;
        else
            return 0;
    }
    return 0;
}

// returns a list of those in cards (excluding self)
// that are ready to test for match-ness.
// i.e. Chosen but not Matched.
- (NSArray *)UnMatchedAndChosen:(NSArray *)cards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (id card in cards) {
        PlayingCard *_card = (PlayingCard *)card;
        if (_card.isChosen && !_card.isMatched && card != self) [result addObject:_card];
    }
    return (NSArray *)result;
}

+ (NSArray *)validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSArray *)validRanks
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard validRanks] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank > 0 && rank <= [PlayingCard maxRank])
        _rank = rank;
}

/* overriding 'contents' in Card */
- (NSString *)contents
{
    return [self.suit stringByAppendingString:[PlayingCard validRanks][self.rank]];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
