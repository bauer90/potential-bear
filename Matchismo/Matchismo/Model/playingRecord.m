//
//  playingRecord.m
//  Matchismo
//
//  Created by Erhan Hu on 4/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "playingRecord.h"

@implementation playingRecord

-(NSArray *)cards
{
    if (_cards) _cards = [[NSArray alloc] init];
    return _cards;
}


@end
