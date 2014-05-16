//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "ViewController.h"
#import "SetCard.h"
#define INIT_CARD_NUM 10

@interface SetCardGameViewController : ViewController

+ (NSAttributedString *)titleForCard:(SetCard *)card;


@end
