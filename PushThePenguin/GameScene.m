//
//  MyScene.m
//  PullThePenguin
//
//  Created by Derrick J Chie on 12/16/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

@synthesize backgroundNode;
@synthesize positiveNodeButtonNode;
@synthesize negativeNodeButtonNode;
@synthesize runButtonNode;
@synthesize nestNode;
@synthesize penguinNode;
@synthesize buttonMenuBarNode;

@synthesize magnetNodes;

@synthesize currentlySelectedMagnetNode;
@synthesize isGameRunning;

@synthesize level;

- (id)initWithSize:(CGSize)size withLevel:(Level *)levelToLoad
{
    self = [super initWithSize:size];
    if (self)
    {
        /* Setup your scene here */
        
        // Turning off gravity
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        
        // Set self as contact delegate
        self.physicsWorld.contactDelegate = self;
        
        // Setting up background
        backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"Background.png"];
        backgroundNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:backgroundNode];
        
        // Setting up the background as the border and making the background as friction free
        SKPhysicsBody *borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody = borderBody;
        self.physicsBody.friction = 0.0f;
        self.physicsBody.categoryBitMask = kBorderCategory;
        
        // Prepare all the initial buttons
        [self prepareInitialButtons];
        
        // Prepare all the initial nodes
        [self prepareInitialNodes];
        
        level = levelToLoad;
        
        // Prepares the level (walls and rocks)
        [self prepareLevel];
        
        if (!magnetNodes)
        {
            magnetNodes = [[NSMutableArray alloc] init];
        }
        
        isGameRunning = NO;
    }
    return self;
}

- (void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    for (MagnetNode *magnetNode in magnetNodes)
    {
//        float currentDistance = [magnetNode distanceFromNode:penguinNode];
//        
//        if (magnetNode.previousDistanceWithPenguinNode != currentDistance)
//        {
//            magnetNode.previousDistanceWithPenguinNode = currentDistance;
            [magnetNode applyMagneticForceOnNode:penguinNode];
//        }

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
    
    if ([touchedNode.name isEqualToString:kPositiveNodeButtonCategoryName])
    {
        currentlySelectedMagnetNode = [[MagnetNode alloc] initWithName:kPositiveNodeCategoryName withPosition:touchLocation];
        [self addChild:currentlySelectedMagnetNode];
        
        [magnetNodes addObject:currentlySelectedMagnetNode];
        // Controlled on and off by the run button
    }
    else if ([touchedNode.name isEqualToString:kNegativeNodeButtonCategoryName])
    {
        currentlySelectedMagnetNode = [[MagnetNode alloc] initWithName:kNegativeNodeCategoryName withPosition:touchLocation];
        [self addChild:currentlySelectedMagnetNode];
        
        [magnetNodes addObject:currentlySelectedMagnetNode];
    }
    else if ([touchedNode.name isEqualToString:kRunButtonCategoryName])
    {
        // If the run button is not selected
        // Goes through the array of all the magnetic nodes and applies the magnetism of each of them on to the penguinNode
        if (isGameRunning == NO)
        {
            NSLog(@"The game is running");
            
            isGameRunning = YES;
            penguinNode.physicsBody.dynamic = YES;
            
            positiveNodeButtonNode.userInteractionEnabled = YES;
            negativeNodeButtonNode.userInteractionEnabled = YES;
            
            for (MagnetNode *magnetNode in magnetNodes)
            {
                magnetNode.userInteractionEnabled = YES;
                magnetNode.previousDistanceWithPenguinNode = -1.0f;
                [magnetNode applyMagneticForceOnNode:penguinNode];
            }
        }
        // Else
        // Goes through the array and cancel's all magnetic forces of the nodes
        else
        {
            NSLog(@"The game is stopped");
            
            isGameRunning = NO;
            
            [self preparePenguinNode];
            penguinNode.position = CGPointMake(self.frame.size.width*2/16, self.frame.size.height/2);
            
            positiveNodeButtonNode.userInteractionEnabled = NO;
            negativeNodeButtonNode.userInteractionEnabled = NO;
            
            for (MagnetNode *magnetNode in magnetNodes)
            {
                magnetNode.userInteractionEnabled = NO;
            }
        }
    }
    else
    {
        // Else, if it is a positive or negative node that's already on the screen

        currentlySelectedMagnetNode = (MagnetNode *)touchedNode;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:previousPosition];
    
    if ([touchedNode.name isEqualToString:currentlySelectedMagnetNode.name])
    {
        runButtonNode.userInteractionEnabled = YES;
        currentlySelectedMagnetNode.position = positionInScene;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    
    if ([touchedNode.name isEqualToString:currentlySelectedMagnetNode.name])
    {
        if ([buttonMenuBarNode containsPoint:currentlySelectedMagnetNode.position])
        {
            [currentlySelectedMagnetNode removeFromParent];
            [magnetNodes removeObject:currentlySelectedMagnetNode];
        }
        
        runButtonNode.userInteractionEnabled = NO;
    }
}

//-----------------------------------------------------------------------
// Initial methods to be called to setup the buttons, nodes, and levels (obstruction)

// Prepares the positive node button, negative node button, and the run button
- (void)prepareInitialButtons
{
    CGSize buttonMenuBarSize = CGSizeMake(self.frame.size.width, self.frame.size.height*1/8);
    buttonMenuBarNode = [SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:buttonMenuBarSize];
    buttonMenuBarNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/16);
    buttonMenuBarNode.name = kButtonMenuBarCategoryName;
    buttonMenuBarNode.userInteractionEnabled = YES;
    buttonMenuBarNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:buttonMenuBarSize];
    buttonMenuBarNode.physicsBody.dynamic = NO;
    buttonMenuBarNode.physicsBody.categoryBitMask = kButtonMenuBarCategory;
    [self addChild:buttonMenuBarNode];
    
    runButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"RunButtonNode.png"];
    runButtonNode.position = CGPointMake(self.frame.size.width*15/16, self.frame.size.height*1/16);
    runButtonNode.name = kRunButtonCategoryName;
    [self addChild:runButtonNode];
    
    positiveNodeButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"PositiveNode.png"];
    positiveNodeButtonNode.position = CGPointMake(self.frame.size.width*3/16, self.frame.size.height*1/16);
    positiveNodeButtonNode.name = kPositiveNodeButtonCategoryName;
    [self addChild:positiveNodeButtonNode];
    
    negativeNodeButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"NegativeNode.png"];
    negativeNodeButtonNode.position = CGPointMake(self.frame.size.width*5/16, self.frame.size.height*1/16);
    negativeNodeButtonNode.name = kNegativeNodeButtonCategoryName;
    [self addChild:negativeNodeButtonNode];
}

// Prepares the penguin node and the nest node
- (void)prepareInitialNodes
{
    penguinNode = [SKSpriteNode spriteNodeWithImageNamed:@"Penguin.png"];
    penguinNode.position = CGPointMake(self.frame.size.width*2/16, self.frame.size.height/2);
    penguinNode.name = kPenguinCategoryName;
    penguinNode.userInteractionEnabled = YES;
    penguinNode.zPosition = 1;
    [self preparePenguinNode];
    [self addChild:penguinNode];
    
    nestNode = [SKSpriteNode spriteNodeWithImageNamed:@"Nest.png"];
    nestNode.position = CGPointMake((self.frame.size.width*15/16), self.frame.size.height/2);
    nestNode.name = kNestCategoryName;
    nestNode.userInteractionEnabled = YES;
    nestNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:nestNode.frame.size];
    nestNode.physicsBody.dynamic = NO;
    nestNode.physicsBody.categoryBitMask = kNestCategory;
    [self addChild:nestNode];
}

- (void)preparePenguinNode
{
    penguinNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:penguinNode.frame.size.width/2];
    penguinNode.physicsBody.dynamic = NO;
    penguinNode.physicsBody.friction = 0.0f;
    penguinNode.physicsBody.restitution = 1.0f;
    penguinNode.physicsBody.linearDamping = 0.5f;
    penguinNode.physicsBody.allowsRotation = YES;
    penguinNode.physicsBody.categoryBitMask = kPenguinCategory;
    
    // Which node the penguinNode hits, but does not pass;
    penguinNode.physicsBody.collisionBitMask = kPenguinCategory | kWallCategory | kRockCategory | kButtonMenuBarCategory | kBorderCategory;
    
    // Which nodes, when contacted with the penguinNode, will send the delegate a message
    penguinNode.physicsBody.contactTestBitMask = kNestCategory | kPenguinCategory | kWallCategory | kRockCategory;
}

// Prepares the level of the game scene
- (void)prepareLevel
{
    // Takes in an array representing the level
    for (ObstacleNode *obstacleNode in self.level.obstacles)
    {
        [self addChild:obstacleNode];
    }
}

//-----------------------------------------------------------------------
// Methods for handling contacts

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    BOOL isWon;
    
    if (contact.bodyA.categoryBitMask == kNestCategory || contact.bodyB.categoryBitMask == kNestCategory)
    {
        isWon = YES;
        
        // New view loaded?
        // Look up on how to handle this situation
        // Select level button, main menu button, next level button
    }
    else
    {
        isWon = NO;
        
        // New view loaded?
        // Select level button, main menu button, try again? button
    }
}

@end

// levels in array, loaded in init, init calls a loadlevel array or maybe have an initWithLevel etc...
