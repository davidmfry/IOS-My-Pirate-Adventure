//
//  DF_Armor.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/16/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_Armor.h"

@implementation DF_Armor

-(id)initWithName:(NSString *)name withArmorStat:(int)armorStat
{
    self.name = name;
    self.armorStat = armorStat;
    return self;
}


@end
