//
//  ViewController.m
//  SuperCard
//
//  Created by ERHAN HU on 7/2/14.
//  Copyright (c) 2014 ERHAN HU. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.rank = 13;
    self.playingCardView.suit = @"♥";
    self.playingCardView.faceUp = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipe:(id)sender {
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

@end
