//
//  BattleViewController.h
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@interface BattleViewController : UIViewController
@property NSMutableArray *fighters;
@property MagicalCreature *battleCreature;
@property NSIndexPath *index;

@end
