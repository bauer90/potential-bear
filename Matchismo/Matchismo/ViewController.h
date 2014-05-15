//
//  ViewController.h
//  Matchismo
//
//  Created by Erhan Hu on 3/18/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

// Abstract class. Must implement methods as described below.
#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "Card.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;


// protected
// for subclasses
- (Deck *)createDeck; // abstract
- (void)updateUI; // abstract
- (NSString *)titleForCard:(Card *)card; // abstract
- (UIImage *)backgroundImageForCard:(Card *)card; // abstract
@end
