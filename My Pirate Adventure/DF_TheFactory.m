//
//  DF_TheFactory.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_TheFactory.h"

@implementation DF_TheFactory

-(NSArray *)makeGameBoard
{
    NSArray *col1 = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSArray *col2 = [NSArray arrayWithObjects:@"4", @"5", @"6", nil];
    NSArray *col3 = [NSArray arrayWithObjects:@"7", @"8", @"9", nil];
    NSArray *col4 = [NSArray arrayWithObjects:@"10", @"11", @"12", nil];
    self.gameBoard = [NSArray arrayWithObjects:col1, col2, col3, col4, nil];
    return self.gameBoard;
}

@end
