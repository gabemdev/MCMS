//
//  CreatureDetailViewController.m
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "CreatureDetailViewController.h"
#import "BattleViewController.h"
#import "MagicalCreature.h"
#import "MainViewController.h"

@interface CreatureDetailViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *creatureName;
@property (weak, nonatomic) IBOutlet UILabel *creatureDescription;
@property (weak, nonatomic) IBOutlet UIImageView *creatureImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *creatureEditButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *battleButton;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITableView *accessoryTable;

@property NSMutableArray *accessoryArray;
@property BOOL isSelected;

@end

@implementation CreatureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.creatureName.text = self.creature.name;
    self.creatureImageView.image = self.creature.creatImage;
    self.creatureDescription.text = self.creature.creatureDescription;
    self.accessoryArray = self.creature.accessories;

    self.selectedButton.layer.cornerRadius = 3;
    self.battleButton.layer.cornerRadius = 3;

    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accessoryArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoryCell"];
    cell.textLabel.text = [self.accessoryArray objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark - Actions
- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    if (self.editing) {
        self.editing = NO;
        self.creatureName.hidden = NO;
        self.creatureDescription.hidden = NO;
        self.nameTextField.hidden = YES;
        self.descriptionTextField.hidden = YES;
        self.creature.name = self.nameTextField.text;
        self.creature.creatureDescription = self.descriptionTextField.text;
        self.creatureName.text = self.creature.name;
        self.creatureDescription.text = self.creature.creatureDescription;
        sender.title = @"Edit";
    }
    else {
        self.editing = YES;
        self.creatureName.hidden = YES;
        self.creatureDescription.hidden = YES;
        self.nameTextField.hidden = NO;
        self.descriptionTextField.hidden = NO;
        self.nameTextField.text = self.creature.name;
        self.descriptionTextField.text = self.creature.creatureDescription;
        sender.title = @"Done";
    }

}

- (IBAction)onSelectedButtonTapped:(id)sender {
    if (self.isSelected) {
        self.isSelected = NO;
        [self.selectedButton setTitle:@"Select" forState:UIControlStateNormal];
        [self.selectedButton setBackgroundColor:[UIColor colorWithRed:0.23 green:0.47 blue:0.85 alpha:1.00]];
        self.battleButton.hidden = YES;
        self.creature.isSelected = NO;
    } else {
        self.isSelected = YES;
        [self.selectedButton setTitle:@"Selected" forState:UIControlStateNormal];
        [self.selectedButton setBackgroundColor:[UIColor colorWithRed:0.20 green:0.67 blue:0.47 alpha:1.00]];
        self.battleButton.hidden = NO;
        self.creature.isSelected = YES;
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BattleViewController *vc = segue.destinationViewController;
    vc.battleCreature = self.creature;
    vc.fighters = self.creatures;
    vc.index = self.index;

    if ([segue.identifier isEqualToString:@"battlePlayer"]) {

        vc.battleCreature.name = self.creature.name;
        vc.battleCreature.creatImage = self.creature.creatImage;
    }
}

@end
