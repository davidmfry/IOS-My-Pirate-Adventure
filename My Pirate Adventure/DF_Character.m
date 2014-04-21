//
//  DF_Character.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/16/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_Character.h"

@implementation DF_Character
-(id)initWithHealth:(int)health withDamageRating:(int)damage withArmorRating:(int)armorRating withWeapon:(DF_Weapon *)weapon withArmor:(DF_Armor *) armor;
{
    self = [super init];
    if (self)
    {
        self.health = health;
        self.damageRating = damage;
        self.armorRating = armorRating;
        self.weapon = weapon;
        self.armor = armor;
    }
 
    return self;
}

@end
