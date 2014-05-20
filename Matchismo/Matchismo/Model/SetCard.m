//
//  SetCard.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

- (void)setNumber:(int)number
{
    if (number <= MAX_CARD_NUMBER && number >= 1) _number = number;
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (int)match:(NSArray *)cards
{
    // todo
    if ([cards count] != 2) return 0;
    SetCard *card0 = cards[0], *card1 = cards[1];

    if ((self.number == card0.number) && (self.number == card1.number)) {
        return 10;
    }
    if (([self.symbol isEqualToString:card0.symbol]) && ([self.symbol isEqualToString:card1.symbol])) {
        return 10;
    }

    if (([self.color isEqualToString:card0.color]) && ([self.color isEqualToString:card1.color])) {
        return 10;
    }
    if (([self.shading isEqualToString:card0.shading]) && ([self.shading isEqualToString:card1.shading])) {
        return 0;
    }

    // at this point no match found.
    return 0;
}

// Leave everything for ViewController.
// Use AttributedString there.
- (NSString *)contents
{
    return nil;
}

- (NSArray *)UnMatchedAndChosen:(NSArray *)cards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (id card in cards) {
        SetCard *_card = (SetCard *)card;
        if (_card.isChosen && !_card.isMatched && card != self) [result addObject:_card];
    }
    return (NSArray *)result;
}

@end
