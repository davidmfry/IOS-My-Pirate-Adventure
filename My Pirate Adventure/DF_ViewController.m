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
    BOOL gameOver = NO;
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
    DF_Tile *currentTile = self.theGame.gameBoard[self.xPos][self.yPos];
    
    if ([self itemCheck:currentTile])
    {
        if ([currentTile.weapon isKindOfClass:[DF_Weapon class]])
        {
            self.theGame.player.weapon = currentTile.weapon;
            self.playerDamage = self.theGame.player.weapon.damageStat;
            self.damageLabel.text = [NSString stringWithFormat:@"%d", self.playerDamage];
            self.weaponLabel.text = self.theGame.player.weapon.name;
            self.actionButton.hidden = YES;
        }
        if ([currentTile.armor isKindOfClass:[DF_Armor class]])
        {
            self.theGame.player.armor = currentTile.armor;
            self.playerArmorRating = self.theGame.player.armor.armorStat;
            self.armorLabel.text = self.theGame.player.armor.name;
            self.actionButton.hidden = YES;
        }
        else
        {
            self.theGame.player.weapon = currentTile.weapon;
            self.theGame.player.armor = currentTile.armor;
            self.playerDamage = self.theGame.player.weapon.damageStat;
            self.playerArmorRating = self.theGame.player.armor.armorStat;
            self.weaponLabel.text = self.theGame.player.weapon.name;
            self.armorLabel.text = self.theGame.player.armor.name;
            self.damageLabel.text = [NSString stringWithFormat:@"%d", self.playerDamage];
            self.actionButton.hidden = YES;
        }
    }
}

- (IBAction)resetButton:(id)sender
{
}

- (IBAction)northButton:(id)sender
{
    self.yPos++;
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self.theGame.gameBoard[self.xPos][self.yPos] showItems];
    //[self.theGame.gameBoard[self.xPos][self.yPos] showHealthEffect];
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.weaponLabel.text = self.theGame.player.weapon.name;
    self.armorLabel.text = self.theGame.player.armor.name;
    [self hideNavButtons];
    
}

- (IBAction)eastButton:(id)sender
{
    self.xPos++;
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self.theGame.gameBoard[self.xPos][self.yPos] showItems];
    //[self.theGame.gameBoard[self.xPos][self.yPos] showHealthEffect];
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.weaponLabel.text = self.theGame.player.weapon.name;
    self.armorLabel.text = self.theGame.player.armor.name;
    [self hideNavButtons];
}

- (IBAction)southButton:(id)sender
{
    self.yPos--;
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self.theGame.gameBoard[self.xPos][self.yPos] showItems];
    //[self.theGame.gameBoard[self.xPos][self.yPos] showHealthEffect];
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.weaponLabel.text = self.theGame.player.weapon.name;
    self.armorLabel.text = self.theGame.player.armor.name;
    [self hideNavButtons];
}

- (IBAction)westButton:(id)sender
{
    self.xPos--;
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    [self.theGame.gameBoard[self.xPos][self.yPos] showLocation];
    [self.theGame.gameBoard[self.xPos][self.yPos] showItems];
    //[self.theGame.gameBoard[self.xPos][self.yPos] showHealthEffect];
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.weaponLabel.text = self.theGame.player.weapon.name;
    self.armorLabel.text = self.theGame.player.armor.name;
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



-(void)drawTile:(DF_Tile *)tile
{
    
    if ([self itemCheck:tile])
    {
        NSLog(@"In Over All Check");
        if ([tile.weapon isKindOfClass:[DF_Weapon class]] && [tile.armor isKindOfClass:[DF_Armor class]] == NO)
        {
            NSLog(@"in weapon check");
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up weapon" forState:UIControlStateNormal];
        }
        
        if ([tile.armor isKindOfClass:[DF_Armor class]] && [tile.weapon isKindOfClass:[DF_Weapon class]] == NO)
        {
            NSLog(@"in armor Check");
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up armor" forState:UIControlStateNormal];
        }
        else
        {
            NSLog(@"in both check");
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up items" forState:UIControlStateNormal];
        }
    }
    else
    {
        self.actionButton.hidden = YES;
    }
        
    self.backgroundImage.image = tile.backgroundImage;
    self.storyLabel.text = tile.story;
    self.playerHealth = [self checkHealthEffect:tile];
}

-(int)checkHealthEffect:(DF_Tile *)tile
{
    int effectAmount = [tile.healthEffect intValue];
    
    if ([tile.tileName isEqualToString:@"Boss"] && effectAmount < 0)
    {
        effectAmount = [tile.healthEffect intValue] - self.playerArmorRating;
        return effectAmount + self.playerHealth;
    }
    
    if (effectAmount < 0)
    {
        effectAmount = [tile.healthEffect intValue] - self.playerArmorRating;
        return  effectAmount + self.playerHealth;
    }
    return effectAmount + self.playerHealth;
}


-(BOOL)itemCheck:(DF_Tile *)tile
{
    if ([tile.weapon isKindOfClass:[DF_Weapon class]] || [tile.armor isKindOfClass:[DF_Armor class]])
    {
        return YES;
    }
    else return NO;
}

-(int)updatePlayerActionStats:(int)itemStat
{
    return itemStat;
}

-(void)specialAction:(NSString *)title messasge:(NSString *)message cancelTitle:(NSString *)cancelTitle otherButtontitle:(NSString *)otherTitle
{
    self.specialAction = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [self.specialAction show];
}




@end
