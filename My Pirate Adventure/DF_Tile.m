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
    self.location = CGPointMake(x, y);
    [self makeEvents:events andKey:key];
    return self;
}

-(void)showLocation
{
    NSLog(@"(%f, %f)", self.location.x, self.location.y);
}

-(void)makeEvents:(NSDictionary *)eventList andKey:(NSString *)key
{

    self.backgroundImage = [eventList objectForKey:key][0];
    self.story = [eventList objectForKey:key][1];

       
}

-(void)giveWeapon:(NSDictionary *)eventList andKey:(NSString *)key
{
    
}

-(void)giveArmor:(NSDictionary *)eventList andKey:(NSString *)key
{
    
}






@end
