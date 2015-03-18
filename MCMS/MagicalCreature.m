//
//  MagicalCreature.m
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MagicalCreature.h"

@implementation MagicalCreature

- (instancetype)initWithName:(NSString *)name andDescription:(NSString *)creatureDesc andImage:(UIImage *)creatureImageName andAccessories:(NSMutableArray *)accessories {
    if ((self = [super init])) {
        self.name = name;
        self.creatureDescription = creatureDesc;
        self.creatImage = creatureImageName;
        self.accessories = accessories;
    }
    return self;
}


@end
