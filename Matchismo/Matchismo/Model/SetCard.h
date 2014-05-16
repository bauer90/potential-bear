//
//  SetCard.h
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "Card.h"
#define MAX_CARD_NUMBER 4

@interface SetCard : Card

// the four properties that define a card
@property (nonatomic) int number;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *shading;

+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;

- (int)match:(NSArray *)cards;

@end
