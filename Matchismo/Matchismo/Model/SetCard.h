//
//  SetCard.h
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

// the four properties that define a card
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *symbol;

+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;

- (NSInteger)match:(NSArray *)cards;

@end
