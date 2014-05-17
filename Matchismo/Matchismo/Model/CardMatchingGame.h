//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by ERHAN HU on 4/1/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "SetCard.h"
#import "PlayingCardDeck.h"
#import "SetCardDeck.h"
#import "PlayingRecord.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

// called when a card is clicked
- (void)chooseCardAtIndex:(NSUInteger)index;

// returns the card at location = 'index'
- (Card *)cardAtIndex:(NSUInteger)index;

// returns YES if no moves have been made
- (BOOL)isNewGame;

//there is no public setter for this property (readonly) -
@property (nonatomic) NSInteger score;

// is 2 for Matchismo and 3 for Set Game.
@property (nonatomic) NSInteger matchMode;

// an NSMutableArray of playingRecord
@property (nonatomic, strong) NSMutableArray *playingHistory;

// how many clicks have been made so far
@property (nonatomic) NSInteger stepCount;

@property (nonatomic, strong) NSMutableArray *cards;

@end
