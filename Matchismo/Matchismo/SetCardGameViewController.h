//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "ViewController.h"
#import "SetCard.h"
#import "SetCardGame.h"

@interface SetCardGameViewController : ViewController

@property (nonatomic, strong) SetCardGame *game;

+ (NSAttributedString *)titleForCard:(SetCard *)card;


@end
