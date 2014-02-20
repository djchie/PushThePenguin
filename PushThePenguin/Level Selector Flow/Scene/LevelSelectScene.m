//
//  LevelSelectScene.m
//  PushThePenguin
//
//  Created by Derrick J Chie on 1/4/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LevelSelectScene.h"

#import "ObstacleNode.h"
#import "GameViewController.h"

@implementation LevelSelectScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        // CREATE LEVELS HERE!!! TO TEST IT OUT
        // FIND IMAGES FOR THE ROCK AND WALL OBSTACLES FIRST
        // SET THIS AS INITIAL SCENE
        // MAKE GAME SCENE FLEXIBLE TO NODES SELECTED WITH OBSTACLES
        // IMPLEMENT WALL AND ROCK NODES
        SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"LevelBackground.png"];
        backgroundNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:backgroundNode];
        
        self.levels = [[NSMutableArray alloc] init];
        
        Level *level1 = [[Level alloc] init];
        level1.number = [NSNumber numberWithInt:1];
        level1.position = CGPointMake(100.0f, 100.0f);
        
        level1.obstacles = [[NSMutableArray alloc] init];
        ObstacleNode *obstacle1 = [[ObstacleNode alloc] initWithName:kRockCategoryName withPosition:(CGPointMake(50.0f, 50.0f))];
        ObstacleNode *obstacle2 = [[ObstacleNode alloc] initWithName:kWallCategoryName withPosition:(CGPointMake(100.0f, 100.0f))];
        [level1.obstacles addObject:obstacle1];
        [level1.obstacles addObject:obstacle2];
        // complete adding fake obstacles
        
        [self.levels addObject:level1];
        
        Level *level2 = [[Level alloc] init];
        level2.number = [NSNumber numberWithInt:2];
        level2.position = CGPointMake(100.0f, 100.0f);
        
        level2.obstacles = [[NSMutableArray alloc] init];
        obstacle1 = [[ObstacleNode alloc] initWithName:kRockCategoryName withPosition:(CGPointMake(90.0f, 90.0f))];
        obstacle2 = [[ObstacleNode alloc] initWithName:kWallCategoryName withPosition:(CGPointMake(30.0f, 30.0f))];
        [level2.obstacles addObject:obstacle1];
        [level2.obstacles addObject:obstacle2];
        
        [self.levels addObject:level2];
        
        Level *level3 = [[Level alloc] init];
        level3.number = [NSNumber numberWithInt:3];
        level3.position = CGPointMake(300.0f, 300.0f);
        
        level3.obstacles = [[NSMutableArray alloc] init];
        obstacle1 = [[ObstacleNode alloc] initWithName:kRockCategoryName withPosition:(CGPointMake(500.0f, 500.0f))];
        obstacle2 = [[ObstacleNode alloc] initWithName:kWallCategoryName withPosition:(CGPointMake(100.0f, 100.0f))];
        [level1.obstacles addObject:obstacle1];
        [level1.obstacles addObject:obstacle2];
        
        [self.levels addObject:level3];
        
        [self populateWithLevelNodes];
    }
    return self;
}

//-----------------------------------------------------------------------
// Methods populating scene with the level nodes

- (void)populateWithLevelNodes
{
    for (Level *level in self.levels)
    {
        LevelNode *levelNode = [[LevelNode alloc] initWithLevel:level];
        [self addChild:levelNode];
    }
}

//-----------------------------------------------------------------------
// Methods for touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    if ([touchedNode.name isEqualToString:kLevelCategoryName])
    {
        LevelNode *levelNode = (LevelNode *)touchedNode;
        
        // Present level preview popover
        GameViewController *gameViewController = [[GameViewController alloc] initWithLevel:levelNode.level];
        
//        [gameViewController ]
        // how to push??
        
        
    }
}





@end
