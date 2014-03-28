//
//  PlayingCard.h
//  Matchismo
//
//  Created by Erhan Hu on 3/29/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSArray *)validRanks;
+ (NSUInteger)maxRank;

@end
