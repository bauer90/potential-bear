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

@interface ViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
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

- (void)reset
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
}

     
- (IBAction)resetGame:(UIButton *)sender
{
    [self reset];
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
    for (UIButton *button in self.cardButtons) { // for each index of card ...
        int buttonIndex = [self.cardButtons indexOfObject:button]; // get the index ...
        Card *card = [self.game cardAtIndex:buttonIndex]; // find the card ...
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.matchModeSelector.enabled = self.game.isNewGame;
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
