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
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton*)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    // updates each card
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
    self.statusMessage.text = [self statusLabelContents];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSString *)statusLabelContents
{
    NSString *result = @"";
    NSString *moveString = @"";
    playingRecord *rec = [self.game.playingHistory lastObject];
    NSLog(@"%d", rec.move);
    if (rec.move == 1) {
        moveString = @"YEAH! A Match for: ";
    } else if (rec.move == 2) {
        moveString = @"BOOO! A Mismatch for: ";
    } else if (rec.move == 3) {
        moveString = @"Currently Selecting: ";
    } else {
        moveString = @"";
    }
    result = [result stringByAppendingString:moveString];
    for (PlayingCard *card in rec.cards) {
        result = [result stringByAppendingFormat:@" %@ ", card.contents];
    }
    return result;
}


@end
