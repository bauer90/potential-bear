//
//  ViewController.m
//  Matchismo
//
//  Created by Erhan Hu on 3/18/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingRecord.h"

@interface ViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSelector;
@property (weak, nonatomic) IBOutlet UISlider *historyViewer;
@end

@implementation ViewController

// called when selected index is changed
- (IBAction)switchMatchMode:(UISegmentedControl *)sender
{
    self.game.matchMode = sender.selectedSegmentIndex + 2;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (IBAction)resetGame:(UIButton *)sender
{
    self.game = nil;
    self.historyViewer.maximumValue = 0;
    self.historyViewer.value = 0;
    [self updateUI];
}

- (IBAction)slideHistoryBar:(UISlider *)sender
{
    self.historyViewer.value = sender.value;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton*)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.historyViewer.maximumValue++;
    self.historyViewer.value = self.historyViewer.maximumValue;
    [self updateUI];
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
    self.matchModeSelector.enabled = self.game.isNewGame;
    self.statusMessage.text = [self statusLabelContents:self.historyViewer.value];
    NSLog(@"maxVal = %d curVal = %d", (int)self.historyViewer.maximumValue, (int)self.historyViewer.value);
}

- (NSString *)statusLabelContents:(int)index
{
    if (index == 0) return @"New Game Started!";
    NSString *moveString = @"";
    NSString *scoreString = @"";
    playingRecord *rec = self.game.playingHistory[index - 1];
    if (rec.move == MATCH) {
        moveString = @"YEAH! A Match for: ";
    } else if (rec.move == MISMATCH) {
        moveString = @"BOOO! A Mismatch for: ";
    } else {
        moveString = @"Currently Selecting: ";
    }
    NSString *result = moveString;
    for (PlayingCard *card in rec.cards) {
        result = [result stringByAppendingFormat:@" %@ ", card.contents];
    }
    if (rec.score == 0) {
        scoreString = @"\n... and score not changed.";
    } else if (rec.score > 0) {
        scoreString = [NSString stringWithFormat:@"\n... and %d points gained!", rec.score];
    } else {
        scoreString = [NSString stringWithFormat:@"\n... and %d points lost.", -rec.score];
    }
    result = [result stringByAppendingString:scoreString];
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
