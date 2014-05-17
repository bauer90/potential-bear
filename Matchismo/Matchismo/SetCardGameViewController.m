//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetCardGameViewController
@synthesize game = _game;

- (IBAction)cardButtonTouched:(UIButton *)sender
{
    // todo
    [self updateUI];
}

- (IBAction)deal3ButtonPushed:(UIButton *)sender
{
    // if there's enough space for new cards -
    if ([[self.game cardsShown] count] + 3 <= [self.cardButtons count]) {
        [self.game deal3];
    }
}

// deal all cards at the beginning but only show cards that are
// unmatched && alreadyAppeared
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:(MAX_CARD_NUMBER * [[SetCard validSymbols] count] * [[SetCard validColors] count] * [[SetCard validShadings] count])
                                             usingDeck:[self createDeck]];
        [self.game deal3];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)resetGame:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (void)updateUI
{
    NSLog(@"SetGame (void)updateUI got called.");
    NSArray *cardsShownThisTime = [self.game cardsShown];
    if ([cardsShownThisTime count] > [self.cardButtons count]) {
        NSLog(@"no enough space!");
        return;
    }
    NSLog(@"%d",[cardsShownThisTime count]);
    for (UIButton *button in self.cardButtons) {
        int buttonIndex = [self.cardButtons indexOfObject:button];
        SetCard *card = [cardsShownThisTime objectAtIndex:buttonIndex];
        [button setTitle:[[SetCardGameViewController titleForCard:card] string] forState:UIControlStateNormal];
    }
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



// returns a card's representation in NSAttributedString.
+ (NSAttributedString *)titleForCard:(SetCard *)card
{
    if (card == nil) return nil;
    // symbol and number
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < card.number; i++) {
        [str appendString:@"\n"];
        [str appendString:card.symbol];
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
        [str_result setAttributes:@{NSStrokeColorAttributeName:_color}
                            range:NSMakeRange(0, [str_result length])];
    }
    return (NSAttributedString *)str_result;
}

@end
