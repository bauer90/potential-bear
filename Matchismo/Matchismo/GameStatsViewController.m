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

@end

@implementation GameStatsViewController

// transform playingRecord struct to NSString representation.
- (NSString *)statusMessage:(CardMatchingGame *)game
                    atIndex:(int)index
{
    if (index == 0)
        return @"New Game Started!";
    NSString *moveString = @"", *scoreString = @"", *result = @"";
    playingRecord *rec = game.playingHistory[index - 1];

    if (rec.move == MATCH)
        moveString = @"YEAH! A Match for: ";
    else if (rec.move == MISMATCH)
        moveString = @"BOOO! A Mismatch for: ";
    else
        moveString = @"Currently Selecting: ";

    result = moveString;

    for (PlayingCard *card in rec.cards)
        result = [result stringByAppendingFormat:@" %@ ", card.contents];

    if (rec.score == 0)
        scoreString = @", and score not changed.";
    else if (rec.score == 1)
        scoreString = [NSString stringWithFormat:@", and 1 point gained!"];
    else if (rec.score == -1)
        scoreString = [NSString stringWithFormat:@", and 1 point lost."];
    else if (rec.score > 0)
        scoreString = [NSString stringWithFormat:@", and %d points gained!", rec.score];
    else // => rec.score < 0
        scoreString = [NSString stringWithFormat:@", and %d points lost.", -rec.score];

    result = [result stringByAppendingString:scoreString];
    return result;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
