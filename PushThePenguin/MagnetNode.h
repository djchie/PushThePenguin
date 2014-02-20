//
//  MagnetNode.h
//  PushThePenguin
//
//  Created by Derrick J Chie on 12/29/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MagnetNode : SKSpriteNode

@property (nonatomic) float previousDistanceWithPenguinNode;

- (id)initWithName:(NSString *)name withPosition:(CGPoint)position;
- (void)applyMagneticForceOnNode:(SKSpriteNode *)node;
- (float)distanceFromNode:(SKSpriteNode *)node;
- (float)angleWithNode:(SKSpriteNode *)node;

@end
