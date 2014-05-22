//
//  GameStatsViewController.m
//  Matchismo
//
//  Created by ERHAN HU on 5/15/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "GameStatsViewController.h"
#import "CardMatchingGame.h"

@interface GameStatsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation GameStatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.text = self.textToDisplay;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
