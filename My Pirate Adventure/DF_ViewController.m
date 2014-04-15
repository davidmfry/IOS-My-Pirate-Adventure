//
//  DF_ViewController.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_ViewController.h"
#import "DF_TheFactory.h"

@interface DF_ViewController ()

@end

@implementation DF_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    DF_TheFactory *gameContainer = [[DF_TheFactory alloc]init];
    NSArray *gameBoard = [gameContainer makeGameBoard];
    NSLog(@"%@", gameBoard);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
