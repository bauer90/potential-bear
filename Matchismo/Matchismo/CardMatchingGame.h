//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by ERHAN HU on 4/1/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

// called when a card is clicked
- (void)chooseCardAtIndex:(NSUInteger)index;


- (Card *)cardAtIndex:(NSUInteger)index;

- (BOOL)isNewGame;

//there is no public setter for this property (readonly) -
@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSInteger matchMode; // 2 or 3

@end
