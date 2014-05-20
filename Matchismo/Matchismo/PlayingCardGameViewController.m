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
#import "MatchismoGame.h"
#import "GameStatsViewController.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end


@implementation PlayingCardGameViewController
@synthesize game = _game;

- (CardMatchingGame *)game
{
    if (!_game) _game = [[MatchismoGame alloc] initWithCardCount:[self.cardButtons count]
                                                       usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)resetGame:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton*)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GameStatsViewController *gsvc = (GameStatsViewController *)[segue destinationViewController];
    gsvc.textToDisplay = [self generateHistoryInfo];

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

- (NSString *)generateHistoryInfo
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.game.playingHistory count]; i++) {
        playingRecord *rec = (playingRecord *)[self.game.playingHistory objectAtIndex:i];
        [result appendString:[PlayingCardGameViewController generateSingleMovementInfoFromRecordEntry:rec]];
        [result appendString:@"\n\n"];
    }
    return result;
    
}

+ (NSString *)generateSingleMovementInfoFromRecordEntry:(playingRecord *)record
{
    NSString *moveString = nil, *scoreString = nil;
    NSMutableString *result = [[NSMutableString alloc] init];

    // type of move
    if (record.move == MATCH)
        moveString = @"YEAH! A Match for: ";
    else if (record.move == MISMATCH)
        moveString = @"BOOO! A Mismatch for: ";
    else
        moveString = @"Currently Selecting: ";

    [result appendString:moveString];

    // the cards
    for (PlayingCard *card in record.cards)
        [result appendFormat:@" %@ ", card.contents];

    // score earned this time (positive or negative)
    if (record.score == 0)
        scoreString = @" and score not changed.";
    else if (record.score > 0)
        scoreString = [NSString stringWithFormat:@" and %d points gained!", record.score];
    else
        scoreString = [NSString stringWithFormat:@" and %d points lost.", -record.score];

    [result appendString:scoreString];

    return result;
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
