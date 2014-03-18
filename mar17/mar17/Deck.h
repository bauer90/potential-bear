//
//  Deck.h
//  mar17
//
//  Created by Erhan Hu on 3/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

// try out commit on mba
#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
