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

    
    return self;
}

-(NSDictionary *)settingEvents
{
    NSDictionary *events;
    
    NSArray *start = [NSArray arrayWithObjects:[UIImage imageNamed:@"start_image.png"],@"Start!  Your captain has just died of mysterious causes and your crew has elected you to take over as captain.  You have the Open Ocean waiting for you to pluder or save the damsial in distress.  The choic is yours!",[self healthEffect:@"0"],nil];
    
    NSArray *openOcean = [NSArray arrayWithObjects:[UIImage imageNamed:@"open_ocean.png"],@" Open Seas:    The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"],nil];
    
    NSArray *smoothSailingOne = [NSArray arrayWithObjects:[UIImage imageNamed:@"smooth_sailing.png"],@"Smooth Sailing:   The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"], nil];
    
    NSArray *smoothSailingTwo = [NSArray arrayWithObjects:[UIImage imageNamed:@"sailing.png"],@"Smooth Sailing2:   The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!",[self healthEffect:@"0"], nil];
    
    NSArray *blackSmith = [NSArray arrayWithObjects:[UIImage imageNamed:@"blacksmith.png"], @"Blacksmith:   Hands red ensign heave to scurvy nipperkin quarterdeck quarter broadside hearties Sail ho. Pirate Round lookout spanker Blimey crack Jennys tea cup Corsair jib sheet Shiver me timbers tackle. Take a caulk long boat Gold Road swing the lead lee landlubber or just lubber brigantine Brethren of the Coast parrel bowsprit.",[self healthEffect:@"25"], [self addArmorWithName:@"Cloak" withStat:25], nil];
    
    NSArray *mermaid = [NSArray arrayWithObjects:[UIImage imageNamed:@"mermaid.png"],@"Mermaid:   Jack hearties gunwalls belay draft spyglass pillage run a rig matey salmagundi. Gold Road run a rig walk the plank draft Jolly Roger lee clap of thunder Sink me Spanish Main schooner. Wench killick provost cackle fruit six pounders landlubber or just lubber sloop chase guns gibbet schooner. ",[self healthEffect:@"100"],[self addWeaponWithName:@"Saber of the Sea" withStat:50],nil];
    
    NSArray *piratesAttack = [NSArray arrayWithObjects:[UIImage imageNamed:@"pirates_attack.png"],@"Pirates Attack!:   Long boat yawl tender warp coffer squiffy overhaul marooned Buccaneer splice the main brace. Keelhaul yo-ho-ho man-of-war lugsail schooner stern provost come about gun chase. Scuppers sutler Sail ho flogging quarter fathom six pounders spirits parrel boom. ",[self healthEffect:@"-25"],[self addWeaponWithName:@"Cutluss" withStat:25], nil];
    
    NSArray *ragingSea = [NSArray arrayWithObjects:[UIImage imageNamed:@"raging-seas.png"],@"Raging Sea!:   Crimp rutters warp grapple lad gangway deadlights port brigantine main sheet. Sutler tack hornswaggle execution dock jib strike colors capstan lugsail hearties coffer. Knave nipperkin Sink me Blimey clipper Yellow Jack transom aye matey bilge rat. ",[self healthEffect:@"-50"], nil];
    
    NSArray *seaDragon = [NSArray arrayWithObjects:[UIImage imageNamed:@"sea-dragon.png"],@"Sea Dragon!:   Line take a caulk coffer reef squiffy topgallant starboard grog spirits draft. Matey parrel yawl tack topgallant trysail hands handsomely Gold Road main sheet. Come about skysail reef sails grog blossom keelhaul crow's nest pillage Jolly Roger me bucko.",[self healthEffect:@"-75"], nil];
    
    NSArray *boss = [NSArray arrayWithObjects:[UIImage imageNamed:@"boss.png"],@"Like A Boss:   Hornswaggle hardtack hogshead maroon mutiny aye run a shot across the bow lugger take a caulk man-of-war. Quarter Corsair bilge rat keelhaul crack Jennys tea cup aye red ensign draft no prey, no pay Sea Legs. Loaded to the gunwalls haul wind Jack Tar pinnace jack ahoy shrouds Chain Shot bilge rat transom. ",[self healthEffect:@"200"], nil];
    NSArray *treasureChest = [NSArray arrayWithObjects:[UIImage imageNamed:@"treasure-chest.png"],@"Treasure Chest!!!:   Hornswaggle hardtack hogshead maroon mutiny aye run a shot across the bow lugger take a caulk man-of-war. Quarter Corsair bilge rat keelhaul crack Jennys tea cup aye red ensign draft no prey, no pay Sea Legs. Loaded to the gunwalls haul wind Jack Tar pinnace jack ahoy shrouds Chain Shot bilge rat transom. ",[self healthEffect:@"50"],[self addWeaponWithName:@"Cutluss of Death" withStat:200 ], [self addArmorWithName:@"Captain's Hat" withStat:100], nil];
    
    
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
    
    
    //NSLog(@"%@",self.gameBoard);
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
        NSLog(@"%d", randomEvent);
        
        if (randomEvent == 0)
        {
            randomEvent = 1;
        }
        
        DF_Tile *tile = [[DF_Tile alloc]initWithCordX:xCord withCordY:i withEventList:self.events andKey:[self makeEventsWithNumber:randomEvent]];
        [columnArray addObject:tile];
        
    }
    return columnArray;
}



-(NSString *)makeEventsWithNumber:(int)number
{
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

-(DF_Weapon *)addWeaponWithName:(NSString *)name withStat:(int)stat
{
    DF_Weapon *weapon = [[DF_Weapon alloc]initWithName:name withDamageStat:stat];
    return weapon;
}

-(DF_Armor *)addArmorWithName:(NSString *)name withStat:(int)stat
{
    DF_Armor *armor = [[DF_Armor alloc]initWithName:name withArmorStat:stat];
    return armor;
}

-(DF_Tile *)tileOverRideXpos:(int)xPos yPos:(int)yPos eventList:(NSDictionary *)events andKey:(NSString *)key
{
    DF_Tile *newTile = [[DF_Tile alloc]initWithCordX:xPos withCordY:yPos withEventList:events andKey:key];
    return newTile;
}

//-(int)randomEvents:(int)number
//{
//    int randomNumber = arc4random();
//    NSMutableArray *usedNumberList;
//    return number;
//}

#pragma mark - Player creation
-(DF_Character *)createPlayer
{
    DF_Weapon *dagger = [[DF_Weapon alloc]initWithName:@"Dagger" withDamageStat:2];
    DF_Armor *rags = [[DF_Armor alloc]initWithName:@"Rags" withArmorStat:5];
    DF_Character *player = [[DF_Character alloc]initWithHealth:200 withDamageRating:3 withArmorRating:1 withWeapon:dagger withArmor:rags];
    return player;
}

-(DF_Character *)createBoss
{
    DF_Weapon *blackBearsSword = [[DF_Weapon alloc]initWithName:@"Black Beards Sword" withDamageStat:100];
    DF_Armor *jackSparrowsJacket = [[DF_Armor alloc]initWithName:@"Jack Sparrow's Jacket" withArmorStat:150];
    DF_Character *theBoss = [[DF_Character alloc]initWithHealth:300 withDamageRating:10 withArmorRating:10 withWeapon:blackBearsSword withArmor:jackSparrowsJacket];
    return theBoss;

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
