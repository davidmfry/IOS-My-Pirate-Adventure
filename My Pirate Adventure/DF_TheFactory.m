//
//  DF_TheFactory.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_TheFactory.h"
#import "DF_Tile.h"
#import "DF_Weapon.h"
#import "DF_Armor.h"

@implementation DF_TheFactory

-(id)initGame
{
    self = [super init];
    if (self)
    {
        self.events = [self settingEvents];
        [self makeGameBoardWithSizeX:4 andSizeY:3];
        self.gameBoard[0][0] = [self tileOverRideXpos:0 yPos:0 eventList:self.events andKey:@"Start"];
        self.gameBoard[2][1] = [self tileOverRideXpos:2 yPos:1 eventList:self.events andKey:@"Boss"];
        self.gameBoard[3][0] = [self tileOverRideXpos:3 yPos:0 eventList:self.events andKey:@"TreasureChest"];
        self.currentTile = self.gameBoard[0][0];
        [self.currentTile showLocation];
        self.startPoint = self.currentTile.location;
        self.player = [self createPlayer];
        self.theBoss = [self createBoss];
    }

    
    return self;
}



#pragma mark - Game Board Creations
-(NSMutableArray *)makeGameBoardWithSizeX:(int)sizeX andSizeY:(int)sizeY
{
    /* Creates the game board
        col1   col2  col3  col4
        -------------------------
        | obj | obj | obj | obj |
        | obj | obj | obj | obj |
        | obj | obj | obj | obj |
        -------------------------
     */
    
    self.gameBoard = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < sizeX; i++)
    {
        [self.gameBoard addObject:[self createColumnWithSize:sizeY atXCord:i]];
    }
    
    return self.gameBoard;
}



-(id)createColumnWithSize:(int)size atXCord:(int)xCord
{
    /* Creats an array for the columns of the board and fills it with tile objects
       
        example:
        col1:
        [
            obj,
            obj,
            obj
        ]
     */
    
    
    NSMutableArray *columnArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 0; i < size; i++)
    {
        int randomEvent = arc4random() % 9;
        
        if (randomEvent == 0)
        {
            randomEvent = 1;
        }
        
        DF_Tile *tile = [[DF_Tile alloc]initWithCordX:xCord withCordY:i withEventList:self.events andKey:[self makeEventsWithNumber:randomEvent]];
        [columnArray addObject:tile];
        
    }
    return columnArray;
}

-(NSDictionary *)settingEvents
{
    // Creates the tiles events and puts them into a dictionary.
    // Array format: [(UIImage*)backgroundImage, (NSString *)story, (NSString *)healthEffect, (DF_Weapon *)weapon, (DF_Armor *)armor]
    
    NSDictionary *events;
    
    NSArray *start = [NSArray arrayWithObjects:[UIImage imageNamed:@"start_image.png"],@"Your captain has just died of mysterious causes and your crew has elected you to take over as captain.  You have the Open Ocean waiting for you to pluder or save the damisela in distress.  The choic is yours!",[self healthEffect:@"0"],nil];
    
    NSArray *openOcean = [NSArray arrayWithObjects:[UIImage imageNamed:@"open_ocean.png"],@"The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"],nil];
    
    NSArray *smoothSailingOne = [NSArray arrayWithObjects:[UIImage imageNamed:@"smooth_sailing.png"],@" The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"], nil];
    
    NSArray *smoothSailingTwo = [NSArray arrayWithObjects:[UIImage imageNamed:@"sailing.png"],@"The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"], nil];
    
    NSArray *blackSmith = [NSArray arrayWithObjects:[UIImage imageNamed:@"blacksmith.png"], @"You have come a crossed a blacksmith.  He has offered you a brand spanking new Chain Vest, but does it go with your pirate garb?",[self healthEffect:@"25"], [self addArmorWithName:@"Chain Vest" withStat:50], nil];
    
    NSArray *mermaid = [NSArray arrayWithObjects:[UIImage imageNamed:@"mermaid.png"],@"In the distance you hear a woman singing. Her song makes you forget all of your cares.  You have the feeling of just wanting to sleep and never leave. You get closer and find a mermaid sing. She likes you and gives you a specail sword to aid you on your journy",[self healthEffect:@"100"],[self addWeaponWithName:@"Saber of the Sea" withStat:100],nil];
    
    NSArray *piratesAttack = [NSArray arrayWithObjects:[UIImage imageNamed:@"pirates_attack.png"],@"Pirates Attack!:   Long boat yawl tender! You have rund into other pirates.  They want to pluder your ship. Prepare for BATTLE!... At the end of the battle you lost some and they lost more.",[self healthEffect:@"-25"],[self addWeaponWithName:@"Cutluss" withStat:25], nil];
    
    NSArray *ragingSea = [NSArray arrayWithObjects:[UIImage imageNamed:@"raging-seas.png"],@"Out of no where the winds turn and the sky turn dark grey. 'Crimp rutters warp grapple lad gangway' Yells the crew! You here a CRACK as a huge light bolt crosses the sky.  The sea begins to churn like boiling water.",[self healthEffect:@"-50"], nil];
    
    NSArray *seaDragon = [NSArray arrayWithObjects:[UIImage imageNamed:@"sea-dragon.png"],@"From the murkey depths comes a huge crash out of the water. All you see is a fire ball engulf your ship. THE SEA DRAGON! Get your crew out of there!",[self healthEffect:@"-75"], nil];
    
    NSArray *boss = [NSArray arrayWithObjects:[UIImage imageNamed:@"boss.png"],@"You have to defeat this huge pirate to move on or face face davey jones when he throughs your limbs into the sea",[self healthEffect:@"0"], nil];
    NSArray *treasureChest = [NSArray arrayWithObjects:[UIImage imageNamed:@"treasure-chest.png"],@"Treasure Chest!!!: You have found the ledgenary treasure of some GREAT PIRATE... You get some health, THE CUTLESS OF DEATH and the Captian's Armor.  Now you feel GODLIKE",[self healthEffect:@"50"],[self addWeaponWithName:@"Cutluss of Death" withStat:400 ], [self addArmorWithName:@"Captain's Armor" withStat:10], nil];
    
    
    events = [[NSMutableDictionary alloc]init];
    [events setValue:openOcean          forKeyPath:@"OpenOcean"];
    [events setValue:smoothSailingOne   forKeyPath:@"SmoothSailing1"];
    [events setValue:smoothSailingTwo   forKeyPath:@"SmoothSailing2"];
    [events setValue:blackSmith         forKeyPath:@"Blacksmith"];
    [events setValue:mermaid            forKeyPath:@"Mermaid"];
    [events setValue:piratesAttack      forKeyPath:@"PiratesAttack"];
    [events setValue:ragingSea          forKeyPath:@"RagingSea"];
    [events setValue:seaDragon          forKeyPath:@"SeaDragon"];
    [events setValue:boss               forKeyPath:@"Boss"];
    [events setValue:treasureChest      forKeyPath:@"TreasureChest"];
    [events setValue:start              forKeyPath:@"Start"];
    
    return events;
}


-(NSString *)makeEventsWithNumber:(int)number
{
    // This determins the event based on the number given
    NSString *key;
    switch (number)
    {
        case 1:
            key = @"OpenOcean";
            break;
        case 2:
            key = @"Mermaid";
            break;
        case 3:
            key = @"Blacksmith";
            break;
        case 4:
            key = @"SmoothSailing1";
            break;
        case 5:
            key = @"PiratesAttack";
            break;
        case 6:
            key = @"RagingSea";
            break;
        case 7:
            key = @"SmoothSailing2";
            break;
        case 8:
            key =@"SeaDragon";
            break;
        case 9:
            key = @"TreasureChest";
            break;
        case 10:
            key = @"Boss";
            break;
        case 100:
            key =@"Start";
        default:
            break;
    }
    return key;
}


-(DF_Tile *)tileOverRideXpos:(int)xPos yPos:(int)yPos eventList:(NSDictionary *)events andKey:(NSString *)key
{
    // Overrides a Tile at a give location.  Used to make sure a there is a start tile, boss tile and treasure tile
    DF_Tile *newTile = [[DF_Tile alloc]initWithCordX:xPos withCordY:yPos withEventList:events andKey:key];
    return newTile;
}



#pragma mark - Character creation
-(DF_Character *)createPlayer
{
    DF_Weapon *dagger = [[DF_Weapon alloc]initWithName:@"Dagger" withDamageStat:2];
    DF_Armor *rags = [[DF_Armor alloc]initWithName:@"Rags" withArmorStat:5];
    DF_Character *player = [[DF_Character alloc]initWithHealth:200 withDamageRating:3 withArmorRating:5 withWeapon:dagger withArmor:rags];
    return player;
}

-(DF_Character *)createBoss
{
    DF_Weapon *blackBearsSword = [[DF_Weapon alloc]initWithName:@"Black Beards Sword" withDamageStat:100];
    DF_Armor *jackSparrowsJacket = [[DF_Armor alloc]initWithName:@"Jack Sparrow's Jacket" withArmorStat:150];
    DF_Character *theBoss = [[DF_Character alloc]initWithHealth:300 withDamageRating:100 withArmorRating:200 withWeapon:blackBearsSword withArmor:jackSparrowsJacket];
    return theBoss;

}

#pragma mark - Item helper methods

-(DF_Weapon *)addWeaponWithName:(NSString *)name withStat:(int)stat
{
    // adds a weapon
    DF_Weapon *weapon = [[DF_Weapon alloc]initWithName:name withDamageStat:stat];
    return weapon;
}

-(DF_Armor *)addArmorWithName:(NSString *)name withStat:(int)stat
{
    // adds armor
    DF_Armor *armor = [[DF_Armor alloc]initWithName:name withArmorStat:stat];
    return armor;
}

#pragma mark - Events
-(NSString *)healthEffect:(NSString *)effectAmount
{
    return effectAmount;
}

-(void)addItemToPlayer:(DF_Character *)player item:(id)item
{
    if ([item isKindOfClass:[DF_Weapon class]])
    {
        self.player.weapon = item;
    }
    if ([item isKindOfClass:[DF_Armor class]])
    {
        self.player.armor = item;
    }
        
}


@end
