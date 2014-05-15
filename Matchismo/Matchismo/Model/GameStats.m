//
//  GameStats.m
//  Matchismo
//
//  Created by ERHAN HU on 5/15/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "GameStats.h"
#import "CardMatchingGame.h"

@implementation GameStats

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.records = [[NSMutableArray alloc] init];
    }
    return self;
}

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


@end
