//
//  ObstacleNode.m
//  PushThePenguin
//
//  Created by Derrick J Chie on 12/31/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import "ObstacleNode.h"

@implementation ObstacleNode

//-----------------------------------------------------------------------
// Methods to create different nodes around on the game scene
// For obstruction nodes, it's called in the prepare node method


- (id)initWithName:(NSString *)name withPosition:(CGPoint)position
{
    if ([name isEqualToString:kRockCategoryName])
    {
        self = [super initWithImageNamed:@"RockNode.png"];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
        self.physicsBody.categoryBitMask = kRockCategory;
    }
    else if ([name isEqualToString:kWallCategoryName])
    {
        self = [super initWithImageNamed:@"WallNode.png"];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        self.physicsBody.categoryBitMask = kWallCategory;
    }
    
    if (self)
    {
        self.name = name;
        self.position = position;
        self.userInteractionEnabled = YES;
        self.physicsBody.dynamic = NO;
    }
    
    return self;
}

@end
