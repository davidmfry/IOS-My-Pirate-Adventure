//
//  DF_Character.h
//  My Pirate Adventure
//
//  Created by David Fry on 4/16/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DF_Weapon.h"
#import "DF_Armor.h"

@interface DF_Character : NSObject
@property (nonatomic) int health;
@property (nonatomic) int damageRating;
@property (nonatomic) int armorRating;
@property (strong, nonatomic) DF_Weapon *weapon;
@property (strong, nonatomic) DF_Armor *armor;


@end
