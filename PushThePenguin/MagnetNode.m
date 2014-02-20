//
//  MagnetNode.m
//  PushThePenguin
//
//  Created by Derrick J Chie on 12/29/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import "MagnetNode.h"

@implementation MagnetNode

- (id)initWithName:(NSString *)name withPosition:(CGPoint)position
{
    if ([name isEqualToString:kPositiveNodeCategoryName])
    {
        self = [super initWithImageNamed:@"PositiveNode.png"];
    }
    else if ([name isEqualToString:kNegativeNodeCategoryName])
    {
        self = [super initWithImageNamed:@"NegativeNode.png"];
    }
    
    if (self)
    {
        self.name = name;
        self.position = position;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];
        self.physicsBody.categoryBitMask = kMagnetNodeCategory;
        self.physicsBody.dynamic = NO;
    }
    
    return self;
}

//-----------------------------------------------------------------------
// Methods for establishing a magnetic force

- (void)applyMagneticForceOnNode:(SKSpriteNode *)node
{
    float distance = [self distanceFromNode:node];
    float angle = [self angleWithNode:node];
    float xForce = 0.0f;
    float yForce = 0.0f;
    
    NSLog(@"The penguin's x speed is: %f", node.physicsBody.velocity.dx);
    NSLog(@"The penguin's y speed is: %f", node.physicsBody.velocity.dy);
    
    if ([self.name isEqualToString:kPositiveNodeCategoryName])
    {
        xForce = -(kMaxForce / distance) * cosf(angle);
        yForce = -(kMaxForce / distance) * sinf(angle);
        
        //        NSLog(@"The xForce is: %f", xForce);
        //        NSLog(@"The yForce is: %f", yForce);
    }
    else if ([self.name isEqualToString:kNegativeNodeCategoryName])
    {
        xForce = (kMaxForce / distance) * cosf(angle);
        yForce = (kMaxForce / distance) * sinf(angle);
        
        NSLog(@"kMaxForce / distance = %f", kMaxForce / distance);
        NSLog(@"cosf(angle) = %f", cosf(angle));
        NSLog(@"The xForce applied is: %f", xForce);
        NSLog(@"The yForce applied is: %f", yForce);
        NSLog(@"\n");
    }
    
    CGVector force = CGVectorMake(xForce, yForce);
    [node.physicsBody applyForce:force];
}

- (float)distanceFromNode:(SKSpriteNode *)node
{
    float differenceInX = node.position.x - self.position.x;
    float differenceInY = node.position.y - self.position.y;
    float distance = ceilf(sqrtf((differenceInX*differenceInX) + (differenceInY*differenceInY)));
    return distance;
}

- (float)angleWithNode:(SKSpriteNode *)node
{
    float differenceInX = node.position.x - self.position.x;
    float differenceInY = node.position.y - self.position.y;
    float angle = atan2f(differenceInY, differenceInX) + M_PI;
    return angle;
}

@end
