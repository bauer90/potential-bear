//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "GameStatsViewController.h"

@interface SetCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetCardGameViewController
@synthesize game = _game;

- (IBAction)cardButtonTouched:(UIButton *)sender
{
    int index = [self.cardButtons indexOfObject:sender];
    if (index < [[self.game cardsShown] count]) {
        SetCard *card = (SetCard *)([self.game cardsShown][index]);
        [self.game chooseCardAtIndex:card.indexInCards];
        [self updateUI];
    }
}

- (IBAction)deal3ButtonPushed:(UIButton *)sender
{
    // if there's enough space for new cards -
    int count = 0;
    while (([[self.game cardsShown] count] < [self.cardButtons count]) && count < 3) {
        [self.game deal1];
        count++;
        [self updateUI];
    }
}

// deal all cards at the beginning but only show cards that are
// unmatched && alreadyAppeared
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:(MAX_CARD_NUMBER * [[SetCard validSymbols] count] * [[SetCard validColors] count] * [[SetCard validShadings] count])
                                             usingDeck:[self createDeck]];
    }
    return _game;
}

// deal 9 cards.
- (void)newGameSetup:(int)numOfCards
{
    for (int i = 0; i < numOfCards; i++) {
        [self.game deal1];
    }
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)resetGame:(UIButton *)sender
{
    self.game = nil;
    [self newGameSetup:10];
    [self updateUI];
}

- (void)updateUI
{
    NSArray *cardsShownThisTime = [self.game cardsShown];
    if ([cardsShownThisTime count] > [self.cardButtons count]) {
        NSLog(@"no enough space!");
        return;
    }
    for (UIButton *button in self.cardButtons) {
        int buttonIndex = [self.cardButtons indexOfObject:button];
        if (buttonIndex < [cardsShownThisTime count]) {
            SetCard *card = [cardsShownThisTime objectAtIndex:buttonIndex];
           // [button setAttributedTitle:[SetCardGameViewController titleForCard:card] forState:UIControlStateNormal];
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [button setAttributedTitle:[SetCardGameViewController titleForCard:card] forState:UIControlStateNormal];
            if (card.isChosen) {
                [button setBackgroundColor:[UIColor grayColor]];
            } else {
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        } else {
            //[button setAttributedTitle:[[NSAttributedString alloc] init] forState:UIControlStateNormal];
            [button setAttributedTitle:[[NSAttributedString alloc] init] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor]];

        }
    }
    self.scoreLabel.text = [[NSString alloc] initWithFormat:@"Score: %d", self.game.score];
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
    [self newGameSetup:10];
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GameStatsViewController *gsvc = (GameStatsViewController *)[segue destinationViewController];
    gsvc.textToDisplay = @"";
}

- (NSString *)generateHistoryInfo
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.game.playingHistory count]; i++) {
        playingRecord *rec = (playingRecord *)[self.game.playingHistory objectAtIndex:i];
        [result appendFormat:@"%d", rec.move];
        
    }

    return (NSString *)result;
}

// returns a card's representation in NSAttributedString.
+ (NSAttributedString *)titleForCard:(SetCard *)card
{
    if (card == nil) return [[NSAttributedString alloc] init];
    // symbol and number
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < card.number; i++) {
        [str appendFormat:@"%@\n", card.symbol];
    }

    // add color attribute
    NSMutableAttributedString *str_result = [[NSMutableAttributedString alloc] initWithString:str];
    UIColor *_color = [UIColor blackColor];
    if ([card.color isEqualToString:[SetCard validColors][0]]) {        // red
        _color = [UIColor redColor];
    } else if ([card.color isEqualToString:[SetCard validColors][1]]) { // green
        _color = [UIColor greenColor];
    } else {                                                            // purple
        _color = [UIColor purpleColor];
    }
    [str_result addAttribute:NSForegroundColorAttributeName
                       value:_color
                       range:NSMakeRange(0, [str length])];

    // add shading attribute
    if ([card.shading isEqualToString:[SetCard validShadings][0]]) {        // solid
        // do nothing
    } else if ([card.shading isEqualToString:[SetCard validShadings][1]]) { // striped
        [str_result addAttribute:NSStrokeWidthAttributeName
                           value:@-3
                           range:NSMakeRange(0, [str_result length])];
    } else {                                                                // open
        [str_result addAttribute:NSStrokeWidthAttributeName
                           value:@3
                           range:NSMakeRange(0, [str_result length])];
        [str_result setAttributes:@{NSStrokeColorAttributeName:[UIColor blackColor]}
                            range:NSMakeRange(0, [str_result length])];
    }
    return (NSAttributedString *)str_result;
}

@end
