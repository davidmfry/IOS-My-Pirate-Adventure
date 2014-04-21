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
@property (nonatomic)int bossHealth;
@property (nonatomic)int bossDamage;
@property (nonatomic)int bossArmorRating;
@property (strong, nonatomic) NSString *weaponName;
@property (strong, nonatomic) NSString *armorName;
@end

@implementation DF_ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Creats the factory class to get the game started
    self.theGame                = [[DF_TheFactory alloc]initGame];
    DF_Tile *startTile          = self.theGame.gameBoard[0][0];
    
    // setting the first tile attributes
    self.currentTileLocation    = startTile.location;
    self.xPos                   = self.currentTileLocation.x;
    self.yPos                   = self.currentTileLocation.y;
    self.backgroundImage.image  = startTile.backgroundImage;
    self.storyLabel.text        = startTile.story;
    
    // setting the player attributes
    self.playerHealth           = self.theGame.player.health;
    self.playerDamage           = self.theGame.player.damageRating;
    self.playerArmorRating      = self.theGame.player.armorRating;
    self.weaponName             = self.theGame.player.weapon.name;
    self.armorName              = self.theGame.player.armor.name;
    
    // setting the boss attributes
    self.bossHealth             = self.theGame.theBoss.health;
    self.bossDamage             = self.theGame.theBoss.damageRating;
    self.bossArmorRating        = self.theGame.theBoss.armorRating;
    
    // setting the labels for the player
    self.healthLabel.text       = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.damageLabel.text       = [NSString stringWithFormat:@"%d", self.playerDamage];
    self.weaponLabel.text       = self.weaponName;
    self.armorLabel.text        = self.armorName;

    // hides the action button at the start
    self.actionButton.hidden    = YES;
    
    // Hides the buttons that are off the maps or where the player can't go
    [self hideNavButtons];
}


#pragma mark - Action Buttons

- (IBAction)actionButton:(id)sender
{
    DF_Tile *currentTile = self.theGame.gameBoard[self.xPos][self.yPos];
    
    // Death Checks
    [self bossDeathCheck];
    [self playerDeathCheck];
    
    // item check : Checks if there are items in the current tile and assigns them to the player when the action buttons is pushed
    if ([self itemCheck:currentTile])
    {
        [self assignItemsToPlayer:currentTile];
    }
    
    
    // Check for boss fight
    if ([currentTile.tileName isEqualToString:@"Boss"])
    {
        int playerAttack = self.bossArmorRating - self.playerDamage;
        
        if (playerAttack < 0)
        {
            playerAttack = abs(playerAttack);
        }
        
        else if (playerAttack > 0)
        {
            playerAttack = self.playerDamage;
        }
        
        self.bossHealth = self.bossHealth - playerAttack;
        self.playerHealth = [self bossfight:currentTile];
        NSLog(@"Boss Health: %d", self.bossHealth);
        self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    }
    
    
}

- (IBAction)resetButton:(id)sender
{
    [self viewDidLoad];
}


#pragma mark - Nav Buttons

- (IBAction)northButton:(id)sender
{
    self.yPos++;  // moves in the up direction
    
    //Draws the tile
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    // console log  display for the tile
    [self showTileStats:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    [self playerDeathCheck];
    
    // labels update
    [self updateLabels];
    
    // Nav button update
    [self hideNavButtons];
    
}

- (IBAction)eastButton:(id)sender
{
    self.xPos++;
    //Draws the tile
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    // console log  display for the tile
    [self showTileStats:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    [self playerDeathCheck];
    
    // labels update
    [self updateLabels];
    
    // Nav button update
    [self hideNavButtons];
}

- (IBAction)southButton:(id)sender
{
    self.yPos--;
    //Draws the tile
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    // console log  display for the tile
    [self showTileStats:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    [self playerDeathCheck];
    
    // labels update
    [self updateLabels];
    
    // Nav button update
    [self hideNavButtons];
}


- (IBAction)westButton:(id)sender
{
    self.xPos--;
    //Draws the tile
    [self drawTile:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    // console log  display for the tile
    [self showTileStats:self.theGame.gameBoard[self.xPos][self.yPos]];
    
    [self playerDeathCheck];
    
    // labels update
    [self updateLabels];
    
    // Nav button update
    [self hideNavButtons];
}

#pragma mark - Helper Methods
// Helper Methods
-(void)hideNavButtons
{
    // Hides the Nav buttons when the player is at the edge of the map/gameboard
    
    int maxHeight = [self.theGame.gameBoard[0] count] - 1;
    int maxWidth = [self.theGame.gameBoard count] - 1;
    
    // show north button
    if (maxHeight >= self.yPos + 1  )
    {
        self.northBtnProp.hidden = NO;
    }
    // hide north button
    if (self.yPos + 1 > maxHeight)
    {
        self.northBtnProp.hidden = YES;
    }
    
    // show east button
    if (maxWidth >= self.xPos + 1)
    {
        self.eastBtnProp.hidden = NO;
    }
    // hide east button
    if (self.xPos + 1 > maxWidth)
    {
        self.eastBtnProp.hidden = YES;
    }
    
    // show south button
    if (self.yPos - 1 >= 0)
    {
        self.southBtnProp.hidden = NO;
    }
    // hide south button
    if (self.yPos - 1 < 0)
    {
        self.southBtnProp.hidden = YES;
    }
    
    
    // show west button
    if (self.xPos - 1 >= 0)
    {
        self.westBtnProp.hidden = NO;
    }
    // hide west button
    if (self.xPos - 1 < 0)
    {
        self.westBtnProp.hidden = YES;
    }

}

-(void)showTileStats:(DF_Tile *)currentTile
{
    // logs the tile stats to the console
    [currentTile showLocation];
    [currentTile showItems];
}

- (void)assignItemsToPlayer:(DF_Tile *)currentTile
{
    // checks the current tile to see if there are weapons and armor with the tile. If there are items, it assigns them to the player
    // and hides the action button
    
    if ([currentTile.weapon isKindOfClass:[DF_Weapon class]] && [currentTile.armor isKindOfClass:[DF_Armor class]] == NO)
    {
        self.theGame.player.weapon = currentTile.weapon;
        self.playerDamage = self.theGame.player.weapon.damageStat;
        self.damageLabel.text = [NSString stringWithFormat:@"%d", self.playerDamage];
        self.weaponLabel.text = self.theGame.player.weapon.name;
    }
    
    else if ([currentTile.armor isKindOfClass:[DF_Armor class]] && [currentTile.weapon isKindOfClass:[DF_Weapon class]] == NO)
    {
        self.theGame.player.armor = currentTile.armor;
        self.playerArmorRating = self.theGame.player.armor.armorStat;
        self.armorLabel.text = self.theGame.player.armor.name;
    }
    
    else if ([currentTile.armor isKindOfClass:[DF_Armor class]] && [currentTile.weapon isKindOfClass:[DF_Weapon class]])
    {
        NSLog(@"in add both");
        self.theGame.player.weapon = currentTile.weapon;
        self.theGame.player.armor = currentTile.armor;
        self.playerDamage = self.theGame.player.weapon.damageStat;
        self.playerArmorRating = self.theGame.player.armor.armorStat;
        self.weaponLabel.text = self.theGame.player.weapon.name;
        self.armorLabel.text = self.theGame.player.armor.name;
        self.damageLabel.text = [NSString stringWithFormat:@"%d", self.playerDamage];
    }
    
    self.actionButton.hidden = YES;
}

- (void)updateLabels
{
    // updates the player health, weapon name and armor name labels.
    
    self.healthLabel.text = [NSString stringWithFormat:@"%d", self.playerHealth];
    self.weaponLabel.text = self.theGame.player.weapon.name;
    self.armorLabel.text = self.theGame.player.armor.name;
}

-(void)drawTile:(DF_Tile *)currentTile
{
    
    if ([self itemCheck:currentTile])
    {
        if ([currentTile.weapon isKindOfClass:[DF_Weapon class]] && [currentTile.armor isKindOfClass:[DF_Armor class]] == NO)
        {
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up weapon" forState:UIControlStateNormal];
        }
        
        if ([currentTile.armor isKindOfClass:[DF_Armor class]] && [currentTile.weapon isKindOfClass:[DF_Weapon class]] == NO)
        {
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up armor" forState:UIControlStateNormal];
        }
        else
        {
            self.actionButton.hidden = NO;
            [self.actionButton setTitle:@"Pick up items" forState:UIControlStateNormal];
        }
    }
    else
    {
        self.actionButton.hidden = YES;
    }
        
    self.backgroundImage.image = currentTile.backgroundImage;
    self.storyLabel.text = currentTile.story;
    
    if ([currentTile.tileName isEqualToString:@"Boss"])
    {
        [self displayBossButton:currentTile];
    }
    
    else
    {
        self.playerHealth = [self checkHealthEffect:currentTile];
    }
}

-(void)displayBossButton:(DF_Tile *)tile
{
    self.actionButton.hidden = NO;
    [self.actionButton setTitle:@"Attack!" forState:UIControlStateNormal];
}

-(int)updatePlayerActionStats:(int)itemStat
{
    return itemStat;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self viewDidLoad];
    }
}

#pragma mark - Check Methods
-(int)checkHealthEffect:(DF_Tile *)tile
{
    int effectAmount = [tile.healthEffect intValue];
    
    if ([tile.tileName  isEqualToString:@"Boss"])
    {
        effectAmount = 0;
        return effectAmount;
    }
    
    if (effectAmount < 0)
    {
        effectAmount = [tile.healthEffect intValue];
        return  effectAmount + self.playerHealth;
    }
    return effectAmount + self.playerHealth;
}

-(void)playerDeathCheck
{
    if (self.playerHealth <= 0)
    {
        self.specialAction = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"You have been killed" delegate:self cancelButtonTitle:@"Start Over" otherButtonTitles:nil];
        [self.specialAction show];
    }
}

-(void)bossDeathCheck
{
    if (self.bossHealth <= 0)
    {
        self.specialAction = [[UIAlertView alloc]initWithTitle:@"You Won" message:@"You have killed THE BOSS" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles: nil];
        [self.specialAction show];
    }
}

-(BOOL)itemCheck:(DF_Tile *)tile
{
    if ([tile.weapon isKindOfClass:[DF_Weapon class]] || [tile.armor isKindOfClass:[DF_Armor class]])
    {
        return YES;
    }
    else return NO;
}



-(int)bossfight:(DF_Tile *)tile
{
    int bossAttack = self.playerArmorRating - self.bossDamage;
    int playerHealth = self.playerHealth;
    int playerHit = 0;
    
    if (bossAttack < 0)
    {
        bossAttack = abs(bossAttack);
    }
    playerHit = playerHealth - bossAttack;
    
    return playerHit;
}






@end
