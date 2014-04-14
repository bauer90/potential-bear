//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by ERHAN HU on 4/1/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger stepCount;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSMutableArray *playingHistory;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)playingHistory
{
    if (!_playingHistory) _playingHistory = [[NSMutableArray alloc] init];
    return _playingHistory;
}

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; //calling NSObject's initializer
    if (self) { // error checking for mem alloc failure
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else { // addObject:nil will cause error
                self = nil;
                break;
            }
        }
    }
    self.matchMode = 2;
    self.score = 0;
    self.stepCount = 0;
    return self;
}


- (BOOL)isNewGame
{
    return self.stepCount == 0;
}


- (void)addToPlayingHistoryWithMove:(NSUInteger)moveForThisClick
                           andCards:(NSArray *)listOfCards
                            andCard:(PlayingCard *)aCard
                           andScore:(NSInteger)score
{
    playingRecord *rcd = [[playingRecord alloc]initWithMove:moveForThisClick
                                                   andCards:listOfCards
                                                    andCard:aCard
                                               gainingScore:score];
    [self.playingHistory addObject:rcd];
}

- (void) unChooselastSelections
{
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            card.chosen = NO;
        }
    }
}

// what happens when cards[index] is clicked -
- (void)chooseCardAtIndex:(NSUInteger)index
{
    self.stepCount++;
    PlayingCard *card = (PlayingCard *)[self cardAtIndex:index];
    NSArray* eligibles = [card UnMatchedAndChosen:self.cards];
    if ([eligibles count] == self.matchMode) { // when there're enough eligibles and an extra is clicked -
        [self unChooselastSelections];
        card.chosen = YES;
        self.score -= MISMATCH_PENALTY;
        [self addToPlayingHistoryWithMove:SELECTING andCards:nil andCard:card andScore:-COST_TO_CHOOSE];
    } else if ([eligibles count] == (self.matchMode - 1)) { // when there're enough eligibles including this click -
        int matchScore = (self.matchMode == 2) ? [card match:eligibles] : [card match3:eligibles];
        if (matchScore > 0) {
            self.score += matchScore * MATCH_BONUS;
            card.chosen = YES;
            card.matched = YES;
            for (PlayingCard *_card in eligibles) {
                _card.chosen = YES;
                _card.matched = YES;
            }
        } else {
            card.chosen = YES;
            self.score -= MISMATCH_PENALTY;
        }
        [self addToPlayingHistoryWithMove:(matchScore > 0) ?  MATCH : MISMATCH
                                 andCards:eligibles
                                  andCard:card
                                 andScore:(matchScore > 0) ? matchScore*MATCH_BONUS : -MISMATCH_PENALTY];
    } else { // no enough eligibles (including this click) -
        if (card.isChosen) {
            card.chosen = NO;
          [self addToPlayingHistoryWithMove:SELECTING
                                   andCards:eligibles
                                    andCard:nil
                                   andScore:0];
            
        } else {
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [self addToPlayingHistoryWithMove:SELECTING
                                     andCards:eligibles
                                      andCard:card
                                     andScore:-COST_TO_CHOOSE];
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= [self.cards count]) ? self.cards[index] : nil;
}


@end
