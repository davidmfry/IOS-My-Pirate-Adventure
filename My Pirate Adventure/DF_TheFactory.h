//
//  DF_TheFactory.h
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DF_TheFactory : NSObject
@property (strong, nonatomic) NSArray *gameBoard;

-(NSArray *)makeGameBoard;

@end
