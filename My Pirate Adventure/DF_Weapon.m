//
//  DF_Weapon.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/16/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_Weapon.h"

@implementation DF_Weapon

-(id)initWithName:(NSString *)name withDamageStat:(int)damageStat
{
    self.name = name;
    self.damageStat = damageStat;
    return self;
}

@end
