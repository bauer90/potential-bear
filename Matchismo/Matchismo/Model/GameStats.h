//
//  GameStats.h
//  Matchismo
//
//  Created by ERHAN HU on 5/15/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playingRecord.h"


@interface GameStats : NSObject

@property (nonatomic, strong) NSMutableArray *records; // array of playingRecord's.


- (instancetype)init;

@end
