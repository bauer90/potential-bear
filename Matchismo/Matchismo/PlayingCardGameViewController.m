//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Erhan Hu on 5/9/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "playingRecord.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSString *):(int)index
{
    if (index == 0)
        return @"New Game Started!";
    NSString *moveString = @"", *scoreString = @"", *result = @"";
    playingRecord *rec = self.game.playingHistory[index - 1];
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

- (void)updateUI
{
    // updates each card.
    for (UIButton *button in self.cardButtons) {
        int buttonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:buttonIndex];
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    // updates score label, mode selector and msg label.
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
