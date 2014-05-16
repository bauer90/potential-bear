//
//  SetCard.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCard.h"

// using ▲ ● ■ to represent symbols.
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


+ (BOOL)threeStringsEqual:(NSArray *)strings
{
    if ([strings count] != 3) return FALSE;
    return ([strings[0] isEqualToString:strings[1]] && [strings[0] isEqualToString:strings[2]]);
}

+ (BOOL)twoOfThreeEqual:(NSArray *)strings
{
    if ([strings count] != 3) return FALSE;
    return ([strings[0] isEqualToString:strings[1]] || [strings[0] isEqualToString:strings[2]] || [strings[1] isEqualToString:strings[2]]);
}

- (int)match:(NSArray *)cards
{
    // todo
    if ([cards count] != 2) return 0;
    SetCard *card0 = cards[0], *card1 = cards[1];
    
    // test if all or any two of them have the same 'number'
    if ((self.number == card0.number) && (self.number == card1.number)) {
        return 10;
    } else if ((self.number == card0.number) || (self.number == card1.number) || (card0.number == card1.number)) {
        return 5;
    } else {
        // do nothing
    }
    
    // test if all or any two of them have the same 'symbol'
    if ([SetCard threeStringsEqual:@[self.symbol, card0.symbol, card1.symbol]]) {
        return 10;
    } else if ([SetCard twoOfThreeEqual:@[self.symbol, card0.symbol, card1.symbol]]) {
        return 5;
    } else {
        // do nothing
    }
    
    // test if all or any two of them have the same 'color'
    if ([SetCard threeStringsEqual:@[self.color, card0.color, card1.color]]) {
        return 10;
    } else if ([SetCard twoOfThreeEqual:@[self.color, card0.color, card1.color]]) {
        return 5;
    } else {
        // do nothing
    }

    // test if all or any two of them have the same 'shading'
    if ([SetCard threeStringsEqual:@[self.shading, card0.shading, card1.shading]]) {
        return 10;
    } else if ([SetCard twoOfThreeEqual:@[self.shading, card0.shading, card1.shading]]) {
        return 5;
    } else {
        // do nothing
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


@end
