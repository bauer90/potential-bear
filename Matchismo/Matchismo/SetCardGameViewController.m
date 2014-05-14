//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by ERHAN HU on 5/13/14.
//  Copyright (c) 2014 Erhan Hu. All rights reserved.
//

#import "SetCardGameViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

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

- (NSAttributedString *)titleForCard:(SetCard *)card
{
    // symbol and number
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < card.number; i++) {
        [str appendString:card.symbol];
        [str appendString:@" "];
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
    return str_result;
}

@end
