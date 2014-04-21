//
//  DF_Tile.m
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import "DF_Tile.h"

@implementation DF_Tile


-(id)initWithCordX:(int)x withCordY:(int)y withEventList:(NSDictionary *)events andKey:(NSString *)key
{
    self.visited = NO;
    self.location = CGPointMake(x, y);
    [self makeEvents:events andKey:key];
    self.tileName = key;
    return self;
}

-(void)showLocation
{
    NSLog(@"(X:%f, Y:%f)", self.location.x, self.location.y);
}

-(void)showHealthEffect
{
    NSLog(@"Health Effect: %@", self.healthEffect);
}

-(void)showItems
{
    NSLog(@"Weapon: %@, Armor: %@", self.weapon.name, self.armor.name);
}

-(void)makeEvents:(NSDictionary *)eventList andKey:(NSString *)key
{
    
    if ([[eventList objectForKey:key]count] == 4 )
    {
        if ([[eventList objectForKey:key][3] isKindOfClass:[DF_Weapon class]])
        {
            self.weapon = [eventList objectForKey:key][3];
        }
        
        else if ([[eventList objectForKey:key][3] isKindOfClass:[DF_Armor class]])
        {
            self.armor = [eventList objectForKey:key][3];

        }
    }
    
    if ([[eventList objectForKey:key]count] == 5)
    {
        self.weapon = [eventList objectForKey:key][3];
        self.armor = [eventList objectForKey:key][4];
    }
    
    self.backgroundImage = [eventList objectForKey:key][0];
    self.story = [eventList objectForKey:key][1];
    self.healthEffect = [eventList objectForKey:key][2];
    
}







@end
