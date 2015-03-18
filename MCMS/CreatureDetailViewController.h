//
//  CreatureDetailViewController.h
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@interface CreatureDetailViewController : UIViewController
@property MagicalCreature *creature;
@property NSMutableArray *creatures;
@property NSIndexPath *index;




@end
