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
// 4 pt for rank match and 1 pt for suit match.
// updated for hw2 (otherCards can have 2 cards)
//- (int)match:(NSArray *)otherCards
//{
//    int score = 0;
//    switch ([otherCards count]) {
//        case 1: {
//            id card = [otherCards firstObject];
//            if ([card isKindOfClass:[PlayingCard class]]) {
//                PlayingCard *otherCard = (PlayingCard *)card;
//                if (otherCard.rank == self.rank) {
//                    score = 8;
//                } else if ([otherCard.suit isEqualToString:self.suit]) {
//                    score = 2;
//                }
//            }
//            break;
//        }
//        case 2: {
//            id _firstCard = [otherCards firstObject];
//            id _secondCard = [otherCards lastObject];
//            if ([_firstCard isKindOfClass:[PlayingCard class]] && [_secondCard isKindOfClass:[PlayingCard class]]) {
//                PlayingCard *firstCard = (PlayingCard *)_firstCard;
//                PlayingCard *secondCard = (PlayingCard *)_secondCard;
//                if (self.rank == firstCard.rank && self.rank == secondCard.rank) {
//                    score = 20;
//                } else if ([self.suit isEqualToString:firstCard.suit] && [self.suit isEqualToString:secondCard.suit]) {
//                    score = 10;
//                } else if (self.rank == firstCard.rank || self.rank == secondCard.rank) {
//                    score = 6;
//                } else if ([self.suit isEqualToString:firstCard.suit] || [self.suit isEqualToString:secondCard.suit]) {
//                    score = 1;
//                }
//            }
//            break;
//        }
//    }
//    return score;
//}

// matchMode can be 2 or 3
- (int)match:(NSArray *)otherCards
    withMode:(int)matchMode
{
    int score = 0;
    if (matchMode == 2) {
        for (PlayingCard *card in otherCards) {
            if (!card.isMatched && card.isChosen) {
                if (card.rank == self.rank) {
                    score = 8;
                } else if ([card.suit isEqualToString:self.suit]) {
                    score = 2;
                }
            }
        }
    } else if (matchMode == 3) {
        if ([[PlayingCard numUnMatchedAndChosen:otherCards] count] == 2 && [[PlayingCard numUnMatchedAndChosen:@[self]] count] == 1) {
            
        }
        
    }
    return score;
}

+ (NSArray *)numUnMatchedAndChosen:(NSArray *)cards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PlayingCard *card in cards) {
        if (card.isChosen && !card.isMatched) {
            [result addObject:card];
        }
    }
    return result;
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
    if (rank > 0 && rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

/* overriding 'contents' in Card */
- (NSString *)contents
{
    return [self.suit stringByAppendingString:[PlayingCard validRanks][self.rank]];
}



- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
