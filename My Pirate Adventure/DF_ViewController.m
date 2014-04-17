//
//  DF_ViewController.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_ViewController.h"
#import "DF_Tile.h"

@interface DF_ViewController ()

@end

@implementation DF_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.theGame = [[DF_TheFactory alloc]initGame];
    //self.currentTileLocation = self.theGame.startPoint;
 
    self.currentTileLocation =  self.theGame.startPoint;
    
    NSLog(@"%f %f",self.currentTileLocation.x, self.currentTileLocation.y);
    [self hideNavButtons];
    
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButton:(id)sender
{
}

- (IBAction)resetButton:(id)sender
{
}

- (IBAction)northButton:(id)sender
{
    int xPos = self.currentTileLocation.x;
    int yPos = self.currentTileLocation.y;
    self.currentTileLocation = [self moveToPoint:self.currentTileLocation atTile:self.theGame.gameBoard[xPos][yPos] numberOfSpacesToMove:1 andDirection:@"north"];
    [self hideNavButtons];
}

- (IBAction)eastButton:(id)sender
{
    int xPos = self.currentTileLocation.x;
    int yPos = self.currentTileLocation.y;
    self.currentTileLocation = [self moveToPoint:self.currentTileLocation atTile:self.theGame.gameBoard[xPos][yPos] numberOfSpacesToMove:1 andDirection:@"east"];
    [self hideNavButtons];
}

- (IBAction)southButton:(id)sender
{
    int xPos = self.currentTileLocation.x;
    int yPos = self.currentTileLocation.y;
    self.currentTileLocation = [self moveToPoint:self.currentTileLocation atTile:self.theGame.gameBoard[xPos][yPos] numberOfSpacesToMove:1 andDirection:@"south"];
    [self hideNavButtons];
}

- (IBAction)westButton:(id)sender
{
    int xPos = self.currentTileLocation.x;
    int yPos = self.currentTileLocation.y;
    self.currentTileLocation = [self moveToPoint:self.currentTileLocation atTile:self.theGame.gameBoard[xPos][yPos] numberOfSpacesToMove:1 andDirection:@"west"];
    [self hideNavButtons];
}

// Helper Methods
-(void)hideNavButtons
{
    int maxHeight = [self.theGame.gameBoard[0] count] - 1;
    int maxWidth = [self.theGame.gameBoard count] - 1;
    // show north button
    if (maxHeight >= self.currentTileLocation.y + 1  )
    {
        NSLog(@"North Ok");
        self.northBtnProp.hidden = NO;
    }
    // hide north button
    if (self.currentTileLocation.y + 1 > maxHeight)
    {
        NSLog(@"Can't go North");
        self.northBtnProp.hidden = YES;
    }
    
    // show east button
    if (maxWidth >= self.currentTileLocation.x + 1)
    {
        NSLog(@"East Ok");
        self.eastBtnProp.hidden = NO;
    }
    // hide east button
    if (self.currentTileLocation.x + 1 > maxWidth)
    {
        NSLog(@"Can't go east");
        self.eastBtnProp.hidden = YES;
    }
    

    // show west button
    if (self.currentTileLocation.x - 1 >= 0)
    {
        NSLog(@"West ok");
        self.westBtnProp.hidden = NO;
    }
    // hide west button
    if (self.currentTileLocation.x - 1 < 0)
    {
        NSLog(@"Can't go West");
        self.westBtnProp.hidden = YES;
    }
    
    
    if (self.currentTileLocation.y - 1 >= 0)
    {
        NSLog(@"South Ok");
        self.southBtnProp.hidden = NO;
    }
    if (self.currentTileLocation.y - 1 < 0)
    {
        NSLog(@"Can't go South");
        self.southBtnProp.hidden = YES;
    }
}

-(CGPoint)moveToPoint:(CGPoint)point atTile:(DF_Tile *)tile numberOfSpacesToMove:(int)spaces andDirection:(NSString *)direction
{
    
    if ([direction  isEqual: @"north"])
    {
        tile = self.theGame.gameBoard[(int)point.x][(int)point.y + spaces];
        NSLog(@"NEW POINT FROM TILE %f, %f", tile.location.x, tile.location.y);
        return tile.location;
    }
    
    else if ([direction  isEqual: @"south"])
    {
        tile = self.theGame.gameBoard[(int)point.x][(int)point.y - spaces];
        NSLog(@"NEW POINT FROM TILE %f, %f", tile.location.x, tile.location.y);
        return tile.location;
    }
    
    else if ([direction isEqual:@"east"])
    {
        tile = self.theGame.gameBoard[(int)point.x + spaces][(int)point.y];
        NSLog(@"NEW POINT FROM TILE %f, %f", tile.location.x, tile.location.y);
        return tile.location;
    }
    
    else if ([direction isEqual:@"west"])
    {
        tile = self.theGame.gameBoard[(int)point.x - spaces][(int)point.y];
        NSLog(@"NEW POINT FROM TILE %f, %f", tile.location.x, tile.location.y);
        return tile.location;
    }
    
    else
    {
        return point;
    }

    
    
}
@end
