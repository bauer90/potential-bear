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
@property (nonatomic, readonly) NSInteger score;

// is 2 for two-card mode and 3 for three-card mode
@property (nonatomic) NSInteger matchMode; // 2 or 3

// an NSMutableArray of playingRecord
@property (nonatomic, readonly) NSMutableArray *playingHistory;

// how many clicks have been made so far
@property (nonatomic, readonly) NSInteger stepCount;

@end
