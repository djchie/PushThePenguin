//
//  LevelNode.h
//  PushThePenguin
//
//  Created by Derrick J Chie on 1/1/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Level.h"

@interface LevelNode : SKSpriteNode

@property (strong, nonatomic) Level *level;

- (id)initWithLevel:(Level *)level;

@end
