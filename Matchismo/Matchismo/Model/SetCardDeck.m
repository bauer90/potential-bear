//
//  SetCardDeck.m
//  Matchismo
//
//  Created by ERHAN HU on 5/14/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int cardNumber = 1; cardNumber <= 3; cardNumber++) {
            for (NSString *cardSymbol in [SetCard validSymbols]) {
                for (NSString *cardColor in [SetCard validColors]) {
                    for (NSString *cardShading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = cardNumber;
                        card.symbol = cardSymbol;
                        card.color = cardColor;
                        card.shading = cardShading;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
