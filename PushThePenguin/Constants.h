//
//  Constants.h
//  PullThePenguin
//
//  Created by Derrick J Chie on 12/24/13.
//  Copyright (c) 2013 Derrick J Chie. All rights reserved.
//

#ifndef PullThePenguin_Constants_h
#define PullThePenguin_Constants_h

// Node name references

#define kPenguinCategoryName                            @"Penguin"
#define kPositiveNodeCategoryName                       @"PositiveNode"
#define kNegativeNodeCategoryName                       @"NegativeNode"
#define kPositiveNodeButtonCategoryName                 @"PositiveNodeButton"
#define kNegativeNodeButtonCategoryName                 @"NegativeNodeButton"
#define kRunButtonCategoryName                          @"RunButton"
#define kWallCategoryName                               @"Wall"
#define kRockCategoryName                               @"Rock"
#define kNestCategoryName                               @"Nest"
#define kButtonMenuBarCategoryName                      @"ButtonMenuBar"

#define kLevelCategoryName                              @"Level"

// Contact and collision category mask references
#define kPenguinCategory                                 0x1 << 0
#define kMagnetNodeCategory                              0x1 << 1
#define kWallCategory                                    0x1 << 2
#define kRockCategory                                    0x1 << 3
#define kNestCategory                                    0x1 << 4
// Need this?
#define kBorderCategory                                  0x1 << 5
#define kButtonMenuBarCategory                           0x1 << 6

// Physical world limits
#define kMaxForce                                        250.0f

#endif
