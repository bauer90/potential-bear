//
//  playingRecord.h
//  Matchismo
//
//  Created by Erhan Hu on 4/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MATCH 1
#define MISMATCH 2
#define SELECTING 3

@interface playingRecord : NSObject

@property (nonatomic) NSUInteger move;
@property (nonatomic, strong) NSArray *cards;

@end
