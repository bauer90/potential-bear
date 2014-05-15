//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by Erhan Hu on 5/9/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "ViewController.h"

@interface PlayingCardGameViewController : ViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
