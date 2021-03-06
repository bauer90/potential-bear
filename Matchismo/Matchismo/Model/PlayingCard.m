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
