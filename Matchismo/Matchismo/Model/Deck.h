//
//  Deck.h
//  Matchismo
//
//  Created by Erhan Hu on 3/29/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card;

- (void) addCard:(Card *)card
           atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
