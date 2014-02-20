//
//  MyScene.h
//  PullThePenguin
//

//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MagnetNode.h"
#import "Level.h"
#import "ObstacleNode.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKSpriteNode *backgroundNode;
@property (strong, nonatomic) SKSpriteNode *positiveNodeButtonNode;
@property (strong, nonatomic) SKSpriteNode *negativeNodeButtonNode;
@property (strong, nonatomic) SKSpriteNode *runButtonNode;
@property (strong, nonatomic) SKSpriteNode *nestNode;
@property (strong, nonatomic) SKSpriteNode *penguinNode;
@property (strong, nonatomic) SKSpriteNode *buttonMenuBarNode;

@property (strong, nonatomic) NSMutableArray *magnetNodes;

@property (strong, nonatomic) MagnetNode *currentlySelectedMagnetNode;
@property (nonatomic) BOOL isGameRunning;

@property (strong, nonatomic) Level *level;

- (id)initWithSize:(CGSize)size withLevel:(Level *)levelToLoad;

@end
