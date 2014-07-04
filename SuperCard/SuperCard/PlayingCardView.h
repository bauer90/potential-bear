//
//  PlayingCardView.h
//  SuperCard
//
//  Created by ERHAN HU on 7/2/14.
//  Copyright (c) 2014 ERHAN HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;

@end
