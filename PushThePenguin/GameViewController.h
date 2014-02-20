//
//  ViewController.h
//  PullThePenguin
//

//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Level.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic) Level *level;

- (id)initWithLevel:(Level *)levelToLoad;

@end
