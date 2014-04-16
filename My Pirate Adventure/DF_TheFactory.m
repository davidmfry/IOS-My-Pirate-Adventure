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
    [self makeGameBoardWithSizeX:4 andSizeY:3];
    self.startPoint = CGPointMake(0, 0);
    
    return self;
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
        DF_Tile *tile = [[DF_Tile alloc]initWithCordX:xCord withCordY:i];
        [columnArray addObject:tile];
        
    }
    return columnArray;
}

@end
