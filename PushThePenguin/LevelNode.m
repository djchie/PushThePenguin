//
//  LevelNode.m
//  PushThePenguin
//
//  Created by Derrick J Chie on 1/1/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LevelNode.h"

@implementation LevelNode

- (id)initWithLevel:(Level *)level
{
    self = [super initWithImageNamed:@"LevelNode.png"];
    
    if (self)
    {
        self.level = level;
        self.position = level.position;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
        self.physicsBody.dynamic = NO;
        SKLabelNode* numberLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        numberLabel.fontSize = 20;
        numberLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        numberLabel.text = [NSString stringWithFormat:@"%d", [level.number intValue]];
    }
    
    return self;
}

@end
