//
//  Card.h
//  Matchismo
//
//  Created by Erhan Hu on 3/25/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;


// returns a list of those in cards (excluding self)
// that are ready to test for match-ness.
// i.e. Chosen but not Matched.
- (NSArray *)UnMatchedAndChosen:(NSArray *)cards;

@end
