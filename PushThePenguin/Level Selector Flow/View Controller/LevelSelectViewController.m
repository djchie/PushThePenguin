//
//  LevelSelectViewController.m
//  PushThePenguin
//
//  Created by Derrick J Chie on 1/4/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "LevelSelectScene.h"

@interface LevelSelectViewController ()

@end

@implementation LevelSelectViewController

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
        SKScene *levelSelectScene = [LevelSelectScene sceneWithSize:skView.bounds.size];
        NSLog(@"width: %f", (double)skView.bounds.size.width);
        NSLog(@"height: %f", (double)skView.bounds.size.height);
        
        levelSelectScene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [skView presentScene:levelSelectScene];
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
