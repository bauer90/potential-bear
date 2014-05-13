//
//  SetCard.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCard.h"

//// NUMBER
//const int ONE = 1;
//const int TWO = 2;
//const int THREE = 3;
//
//// SYMBLE
//const int SOLID = 0;
//const int STRIPED = 1;
//const int OPEN = 2;
//
//// SHADING
//const int DIAMOND = 0;
//const int SQUIGGLE = 1;
//const int OVAL = 2;
//
//// COLOR
//const int RED = 0;
//const int GREEN = 1;
//const int PURPLE = 2;

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

- (void)setNumber:(NSUInteger)number
{
    if (number <= 3 && number >= 1) _number = number;
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

- (NSInteger)match:(NSArray *)cards
{
    // todo
    return 0;
}

// Leave everything for ViewController.
// Use AttributedString there.
- (NSString *)contents
{
    return nil;
}


@end
