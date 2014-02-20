//
//  ViewController.m
//  PullThePenguin
//
//  Created by Derrick J Chie on 12/16/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

@synthesize level;

- (id)initWithLevel:(Level *)levelToLoad
{
    self = [super init];
    
    if (self)
    {
        level = levelToLoad;
    }
    
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view
    SKView *skView = (SKView *)self.view;
    if (!skView.scene)
    {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene
        SKScene *gameScene = [[GameScene alloc] initWithSize:skView.bounds.size withLevel:level];
        NSLog(@"width: %f", (double)skView.bounds.size.width);
        NSLog(@"height: %f", (double)skView.bounds.size.height);
        
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [skView presentScene:gameScene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskLandscape;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
