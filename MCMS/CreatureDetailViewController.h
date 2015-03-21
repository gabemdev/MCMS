//
//  CreatureDetailViewController.h
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@protocol MagicalCreatureDelegate <NSObject>

- (void)selectedCreature:(BOOL)selectedCreature;

@end

@interface CreatureDetailViewController : UIViewController

@property (nonatomic, assign) id<MagicalCreatureDelegate>magicalCreatureDelegate;
@property MagicalCreature *selectedCreature;
@property NSMutableArray *creatures;
@property NSIndexPath *index;
@property BOOL isSelected;









@end
