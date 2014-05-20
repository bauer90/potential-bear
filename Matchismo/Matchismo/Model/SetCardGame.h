//
//  SetCardGame.h
//  Matchismo
//
//  Created by Erhan Hu on 5/17/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGame : CardMatchingGame

// draw 3 cards and mark them 'alreadyAppeared'
// return nil if there're no enough such cards.
- (void)deal1;
- (NSArray *)cardsShown;

@end
