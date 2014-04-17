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
@property (nonatomic)int xPos;
@property (nonatomic)int yPos;

@property (nonatomic)int playerHealth;
@property (nonatomic)int playerDamage;
@property (nonatomic)int playerArmorRating;
@property (strong, nonatomic) NSString *weaponName;
@property (strong, nonatomic) NSString *armorName;
@end

@implementation DF_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.theGame = [[DF_TheFactory alloc]initGame];
    //self.currentTileLocation = self.theGame.startPoint;
    DF_Tile *startTile = self.theGame.gameBoard[0][0];
    
    self.currentTileLocation = startTile.location;
    
    self.xPos = self.currentTileLocation.x;
    self.yPos = self.currentTileLocation.y;
    
    self.backgroundImage.image = startTile.backgroundImage;
    self.storyLabel.text = startTile.story;
    
    //NSLog(@"%f %f",self.currentTileLocation.x, self.currentTileLocation.y);
    self.playerHealth = self.theGame.player.health;
    self.playerDamage = self.theGame.player.damageRating;
    self.playerArmorRating = self.theGame.player.armorRating;
    self.weaponName = self.theGame.player.weapon.name;
    self.armorName = self.theGame.player.armor.name;
    
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.damageLabel.text = [NSString stringWithFormat:@"%d", self.playerDamage];
    self.weaponLabel.text = self.weaponName;
    self.armorLabel.text = self.armorName;
    
    [self hideNavButtons];
}



- (IBAction)actionButton:(id)sender
{
}

- (IBAction)resetButton:(id)sender
{
}

- (IBAction)northButton:(id)sender
{
    self.yPos++;
    [self DrawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self hideNavButtons];
    
}

- (IBAction)eastButton:(id)sender
{
    self.xPos++;
    [self DrawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self hideNavButtons];
}

- (IBAction)southButton:(id)sender
{
    self.yPos--;
    [self DrawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self hideNavButtons];
}

- (IBAction)westButton:(id)sender
{
    self.xPos--;
    [self DrawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self hideNavButtons];
}

#pragma mark - Helper Methods
// Helper Methods
-(void)hideNavButtons
{
    int maxHeight = [self.theGame.gameBoard[0] count] - 1;
    int maxWidth = [self.theGame.gameBoard count] - 1;
    // show north button
    if (maxHeight >= self.yPos + 1  )
    {
        //NSLog(@"North Ok");
        self.northBtnProp.hidden = NO;
    }
    // hide north button
    if (self.yPos + 1 > maxHeight)
    {
        //NSLog(@"Can't go North");
        self.northBtnProp.hidden = YES;
    }
    
    // show east button
    if (maxWidth >= self.xPos + 1)
    {
        //NSLog(@"East Ok");
        self.eastBtnProp.hidden = NO;
    }
    // hide east button
    if (self.xPos + 1 > maxWidth)
    {
        //NSLog(@"Can't go east");
        self.eastBtnProp.hidden = YES;
    }
    

    // show west button
    if (self.xPos - 1 >= 0)
    {
        //NSLog(@"West ok");
        self.westBtnProp.hidden = NO;
    }
    // hide west button
    if (self.xPos - 1 < 0)
    {
        //NSLog(@"Can't go West");
        self.westBtnProp.hidden = YES;
    }
    
    
    if (self.yPos - 1 >= 0)
    {
        //NSLog(@"South Ok");
        self.southBtnProp.hidden = NO;
    }
    
    if (self.yPos - 1 < 0)
    {
        //NSLog(@"Can't go South");
        self.southBtnProp.hidden = YES;
    }
}



-(void)DrawTile:(DF_Tile *)tile
{
    self.backgroundImage.image = tile.backgroundImage;
    self.storyLabel.text = tile.story;
}







@end
