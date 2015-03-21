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
@property (weak, nonatomic) IBOutlet UIImageView *creatureImageView;
@property (weak, nonatomic) IBOutlet UILabel *creatureDescription;
@property (weak, nonatomic) IBOutlet UILabel *creatureName;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *creatureEditButton;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *battleButton;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITableView *accessoryTable;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property NSMutableArray *accessoryArray;
@property BOOL isEditSelected;

@end

@implementation CreatureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedCreature.creatureSelected = self.selectedCreature.creatureSelected;
    self.isSelected = NO;
    self.isEditSelected = NO;

    self.creatureName.text = self.selectedCreature.name;
    self.creatureImageView.image = self.selectedCreature.creatImage;
    self.creatureDescription.text = self.selectedCreature.creatureDescription;
    self.accessoryArray = self.selectedCreature.accessories;

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

    if (!self.isEditSelected) {
        sender.title = @"Done";
        //Textfield = label text
        self.nameTextField.text = self.creatureName.text;
        self.descriptionTextField.text = self.creatureDescription.text;
    } else {
        //label = textField
        sender.title = @"Edit";
        self.selectedCreature.name = self.nameTextField.text;
        self.selectedCreature.creatureDescription = self.descriptionTextField.text;
    }
    self.creatureName.hidden = !self.isEditSelected;
    self.creatureDescription.hidden = !self.isEditSelected;
    self.nameTextField.hidden = self.isEditSelected;
    self.descriptionTextField.hidden = self.isEditSelected;
    self.isEditSelected = !self.isEditSelected;

}

- (IBAction)onSelectedButtonTapped:(id)sender {
    NSLog(@"Out is Selected: %d", self.selectedCreature.creatureSelected);
    if (!self.isSelected) {
        self.isSelected = YES;
        [self.selectedButton setTitle:@"Selected" forState:UIControlStateNormal];
        [self.selectedButton setBackgroundColor:[UIColor colorWithRed:0.20 green:0.67 blue:0.47 alpha:1.00]];
        self.battleButton.hidden = NO;
        NSLog(@"YES is Selected: %d", self.selectedCreature.creatureSelected);
        [self.magicalCreatureDelegate selectedCreature:YES];

    } else {
        [self.selectedButton setTitle:@"Select" forState:UIControlStateNormal];
        [self.selectedButton setBackgroundColor:[UIColor colorWithRed:0.23 green:0.47 blue:0.85 alpha:1.00]];
        self.battleButton.hidden = YES;
        self.isSelected = NO;
         [self.magicalCreatureDelegate selectedCreature:NO];

        NSLog(@"NO is Selected: %d", self.selectedCreature.creatureSelected);
    }
    self.selectedCreature.creatureSelected = self.isSelected;
    self.isSelected = !self.isSelected;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BattleViewController *vc = segue.destinationViewController;
    vc.battleCreature = self.selectedCreature;
    vc.fighters = self.creatures;
    vc.index = self.index;

    if ([segue.identifier isEqualToString:@"battlePlayer"]) {

        vc.battleCreature.name = self.selectedCreature.name;
        vc.battleCreature.creatImage = self.selectedCreature.creatImage;
    }
}


@end
