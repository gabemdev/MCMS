//
//  MagicalCreature.h
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MagicalCreature : NSObject
@property NSString *name;
@property NSString *creatureDescription;
@property UIImage *creatImage;
@property NSMutableArray *accessories;
@property BOOL isSelected;


//Custom initializer. 
- (instancetype)initWithName:(NSString *)name andDescription:(NSString *)creatureDesc andImage:(UIImage *)creatureImageName andAccessories:(NSMutableArray *)accessories;



@end
