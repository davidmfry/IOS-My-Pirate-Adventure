//
//  DF_TheFactory.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_TheFactory.h"
#import "DF_Tile.h"

@implementation DF_TheFactory

-(id)initGame
{
    self.events = [self settingEvents];
    [self makeGameBoardWithSizeX:4 andSizeY:3];
    self.currentTile = self.gameBoard[0][0];
    self.startPoint = self.currentTile.location;

    
    return self;
}

-(NSDictionary *)settingEvents
{
    NSDictionary *events;
    
    NSArray *openOcean = [NSArray arrayWithObjects:[UIImage imageNamed:@"open_ocean.png"],@" Open Seas:    The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!", nil];
    
    NSArray *smoothSailingOne = [NSArray arrayWithObjects:[UIImage imageNamed:@"smooth_sailing.png"],@"Smooth Sailing:   The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!", nil];
    
    NSArray *smoothSailingTwo = [NSArray arrayWithObjects:[UIImage imageNamed:@"sailing.png"],@"Smooth Sailing2:   The seas are calm.  You set sail across a vast expanse of diamond-sparkling ocean in search of unknown treasure with the wind at your back and a bright horizon ahead!", nil];
    
    NSArray *blackSmith = [NSArray arrayWithObjects:[UIImage imageNamed:@"blacksmith.png"], @"Blacksmith:   Hands red ensign heave to scurvy nipperkin quarterdeck quarter broadside hearties Sail ho. Pirate Round lookout spanker Blimey crack Jennys tea cup Corsair jib sheet Shiver me timbers tackle. Take a caulk long boat Gold Road swing the lead lee landlubber or just lubber brigantine Brethren of the Coast parrel bowsprit." ,nil];
    
    NSArray *mermaid = [NSArray arrayWithObjects:[UIImage imageNamed:@"mermaid.png"],@"Mermaid:   Jack hearties gunwalls belay draft spyglass pillage run a rig matey salmagundi. Gold Road run a rig walk the plank draft Jolly Roger lee clap of thunder Sink me Spanish Main schooner. Wench killick provost cackle fruit six pounders landlubber or just lubber sloop chase guns gibbet schooner. ",nil];
    
    NSArray *piratesAttack = [NSArray arrayWithObjects:[UIImage imageNamed:@"pirates_attack.png"],@"Pirates Attack!:   Long boat yawl tender warp coffer squiffy overhaul marooned Buccaneer splice the main brace. Keelhaul yo-ho-ho man-of-war lugsail schooner stern provost come about gun chase. Scuppers sutler Sail ho flogging quarter fathom six pounders spirits parrel boom. ", nil];
    
    NSArray *ragingSea = [NSArray arrayWithObjects:[UIImage imageNamed:@"raging-seas.png"],@"Raging Sea!:   Crimp rutters warp grapple lad gangway deadlights port brigantine main sheet. Sutler tack hornswaggle execution dock jib strike colors capstan lugsail hearties coffer. Knave nipperkin Sink me Blimey clipper Yellow Jack transom aye matey bilge rat. ", nil];
    
    NSArray *seaDragon = [NSArray arrayWithObjects:[UIImage imageNamed:@"sea-dragon.png"],@"Sea Dragon!:   Line take a caulk coffer reef squiffy topgallant starboard grog spirits draft. Matey parrel yawl tack topgallant trysail hands handsomely Gold Road main sheet. Come about skysail reef sails grog blossom keelhaul crow's nest pillage Jolly Roger me bucko.", nil];
    
    NSArray *boss = [NSArray arrayWithObjects:[UIImage imageNamed:@"boss.png"],@"Like A Boss:   Hornswaggle hardtack hogshead maroon mutiny aye run a shot across the bow lugger take a caulk man-of-war. Quarter Corsair bilge rat keelhaul crack Jennys tea cup aye red ensign draft no prey, no pay Sea Legs. Loaded to the gunwalls haul wind Jack Tar pinnace jack ahoy shrouds Chain Shot bilge rat transom. ", nil];
    NSArray *treasureChest = [NSArray arrayWithObjects:[UIImage imageNamed:@"treasure-chest.png"],@"Treasure Chest!!!:   Hornswaggle hardtack hogshead maroon mutiny aye run a shot across the bow lugger take a caulk man-of-war. Quarter Corsair bilge rat keelhaul crack Jennys tea cup aye red ensign draft no prey, no pay Sea Legs. Loaded to the gunwalls haul wind Jack Tar pinnace jack ahoy shrouds Chain Shot bilge rat transom. ", nil];
    
    
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
    
    return events;
}


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



// Helper Methods
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
        int randomEvent = arc4random() % 11;
        NSLog(@"%d", randomEvent);
        
        if (randomEvent == 0)
        {
            randomEvent = 1;
        }
        
        DF_Tile *tile = [[DF_Tile alloc]initWithCordX:xCord withCordY:i withEventList:self.events andKey:[self makeEventsWithNumber:randomEvent]];
        //DF_Tile *tile =[[DF_Tile alloc]init];
        //NSLog(@"%@",self.events);
        //[tile makeEvents:self.events andKey:[self makeEventsWithNumber:1]];
        //tile.story = @"THIS IS A STORY";
        //NSLog(@"%@",[self makeEventsWithNumber:1]);
        //[tile makeEvents:self.events andKey:[self makeEventsWithNumber:1]];
        //NSLog(@"%@ ,%@",tile.backgroundImage, tile.story);
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
        default:
            break;
    }
    return key;
}


@end
