//
//  DF_Tile.h
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DF_Weapon.h"
#import "DF_Armor.h"

@interface DF_Tile : NSObject
@property (strong, nonatomic)NSString *story;
@property (strong, nonatomic)NSString *actionButtonName;
@property (strong, nonatomic)UIImage *backgroundImage;
@property (strong, nonatomic)DF_Weapon *weapon;
@property (strong, nonatomic)DF_Armor *armor;
@property (strong, nonatomic)NSString *healthEffect;
@property (strong, nonatomic)NSString *tileName;
@property (nonatomic)CGPoint location;
@property (nonatomic)BOOL visited;

-(id)initWithCordX:(int)x withCordY:(int)y withEventList:(NSDictionary *)events andKey:(NSString *)key;
-(void)showLocation;
-(void)showHealthEffect;
-(void)showItems;
-(void)makeEvents:(NSDictionary *)eventList andKey:(NSString *)key;

@end
