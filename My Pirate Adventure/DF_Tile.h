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
@property (nonatomic)int healthEffect;
@property (nonatomic)CGPoint location;

-(id)initWithCordX:(int)x withCordY:(int)y withEventList:(NSDictionary *)events andKey:(NSString *)key;
-(void)makeEvents:(NSDictionary *)eventList andKey:(NSString *)key;

@end
