//
//  Level.h
//  PushThePenguin
//
//  Created by Derrick J Chie on 1/1/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

// For the level select, popover, and game scene
@property (strong, nonatomic) NSNumber *number;

// For the level select scene
@property (nonatomic) CGPoint position;

// For the game scene
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) NSMutableArray *obstacles;

// For the popover
@property (strong, nonatomic) NSMutableArray *topFiveFBPlayers;
@property (strong, nonatomic) UIImage *previewImage;

@end
