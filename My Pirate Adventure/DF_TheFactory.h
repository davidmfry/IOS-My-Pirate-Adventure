//
//  DF_TheFactory.h
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DF_Tile.h"
#import "DF_Character.h"

@interface DF_TheFactory : NSObject
@property (strong, nonatomic) NSMutableArray *gameBoard;
@property (nonatomic) CGPoint startPoint;
@property (strong, nonatomic) DF_Tile *currentTile;
@property (strong, nonatomic) NSDictionary *events;
@property (strong, nonatomic) DF_Character *player;
@property (strong, nonatomic) DF_Character *theBoss;


-(id)initGame;
-(NSMutableArray *)makeGameBoardWithSizeX:(int)sizeX andSizeY:(int)sizeY;
-(void)addItemToPlayer:(DF_Character *)player item:(id)item;


@end
