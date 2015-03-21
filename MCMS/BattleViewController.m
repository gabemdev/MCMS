//
//  BattleViewController.m
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "BattleViewController.h"
#import "MagicalCreature.h"

@interface BattleViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *player1;
@property (weak, nonatomic) IBOutlet UIImageView *player2;
@property (weak, nonatomic) IBOutlet UILabel *playerOneName;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoName;
@property (weak, nonatomic) IBOutlet UIButton *fightButton;
@property MagicalCreature *fighter2;


@end

@implementation BattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     *  Initialize player 1
     */
    self.playerOneName.text = self.battleCreature.name;
    self.player1.image = self.battleCreature.creatImage;

    /**
     *  Initialize player 2;
     */
    NSInteger player = arc4random()% self.fighters.count;
    self.fighter2 = self.fighters[player];
    self.playerTwoName.text = self.fighter2.name;
    self.player2.image = self.fighter2.creatImage;

    self.fightButton.layer.cornerRadius = 3;

}

#pragma mark - Actions
- (IBAction)onCloseButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.battleCreature.isSelected = NO;
}

- (IBAction)onFightButtonTapped:(id)sender {
    //Create array with the selected creature and the random fighter
    NSMutableArray *fighters = [NSMutableArray arrayWithObjects:self.battleCreature.name, self.fighter2.name, nil];

    // Get a random number between 0 and the number of fighters.
    NSInteger winner = arc4random() % fighters.count;

    //If the number is 1 or less, you win.
    if (winner <= 1) {
        NSLog(@"Winner: %@", self.battleCreature.name);
        [self alertWithWinner:self.battleCreature.name];

    } else {
        //Number greater than 1, random fighter wins.
        NSLog(@"Winner2: %@", self.fighter2.name);
        [self alertWithWinner:self.fighter2.name];
        
    }
}

#pragma mark - UIAlertViewDelegate

- (UIAlertView *)alertWithWinner:(NSString *)winner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Won!", winner]
                                                    message:@"Flawless victory!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:@"Try again", nil];
    [alert show];

    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
