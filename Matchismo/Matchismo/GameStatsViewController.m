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
