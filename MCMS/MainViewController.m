//
//  MainViewController.m
//  MCMS
//
//  Created by Rockstar. on 3/17/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MainViewController.h"
#import "MagicalCreature.h"
#import "CreatureDetailViewController.h"
#import "BattleViewController.h"


@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property NSMutableArray *creatures;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addCreatureButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *battleButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property BOOL isSelected;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addCreatureButton.layer.cornerRadius = 3;
    [self.addCreatureButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.addCreatureButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];

    MagicalCreature *one = [[MagicalCreature alloc] initWithName:@"Mort"
                                                  andDescription:@"Shy monster who doesn't say much. He prefers to watch the world go by from the shadows"
                                                        andImage:[UIImage imageNamed:@"mort"]
                                                  andAccessories:[@[@"Darkness", @"Moonlight"]mutableCopy]];

    MagicalCreature *two = [[MagicalCreature alloc] initWithName:@"George"
                                                  andDescription:@"Very affectionaty monster who loves nature and all its creatures."
                                                        andImage:[UIImage imageNamed:@"george"]
                                                  andAccessories:[@[@"Trees", @"Flowers", @"Animals"]mutableCopy]];

    MagicalCreature *three = [[MagicalCreature alloc] initWithName:@"Spot"
                                                    andDescription:@"Loyal and caring monster. He enjoys sports."
                                                          andImage:[UIImage imageNamed:@"spot"]
                                                    andAccessories:[@[@"Football", @"Soccer", @"Baseball bat"]mutableCopy]];

    MagicalCreature *four = [[MagicalCreature alloc] initWithName:@"Slimon"
                                                   andDescription:@"Kind-hearded monster who loves to read"
                                                         andImage:[UIImage imageNamed:@"slimon"]
                                                   andAccessories:[@[@"Books", @"Rulers", @"Book Shelves"]mutableCopy]];

    MagicalCreature *five = [[MagicalCreature alloc] initWithName:@"Reginald"
                                                   andDescription:@"Refined monster who enjoys casual strolls around the countryside."
                                                         andImage:[UIImage imageNamed:@"reginald"]
                                                   andAccessories:[@[@"Tea bags", @"Creamers", @"Sugar packs"]mutableCopy]];

    MagicalCreature *six = [[MagicalCreature alloc] initWithName:@"Flip"
                                                  andDescription:@"Loves making new friends and going on adventures, but tends to daydream."
                                                        andImage:[UIImage imageNamed:@"flip"]
                                                  andAccessories:[@[@"Candy", @"Nighmares"]mutableCopy]];

    MagicalCreature *seven = [[MagicalCreature alloc] initWithName:@"Donk"
                                                    andDescription:@"Athletic monster who enojys hiking mountains."
                                                          andImage:[UIImage imageNamed:@"donk"]
                                                    andAccessories:[@[@"Size", @"Fresh air", @"Hiking boots"]mutableCopy]];

    MagicalCreature *eight = [[MagicalCreature alloc] initWithName:@"Steve"
                                                    andDescription:@"Happy monster who loves food."
                                                          andImage:[UIImage imageNamed:@"steve"]
                                                    andAccessories:[@[@"Cakes", @"Pots", @"Pans", @"Cookie Dough"]mutableCopy]];

    self.creatures = [NSMutableArray arrayWithObjects:one, two, three, four, five, six, seven, eight, nil];

    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creatures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreatureCell"];
    MagicalCreature *creatures = [self.creatures objectAtIndex:indexPath.row];
    cell.textLabel.text = creatures.name;
    cell.detailTextLabel.text = creatures.creatureDescription;
    cell.imageView.image = creatures.creatImage;

    return cell;
}


#pragma mark - Actions

- (IBAction)onAddButtonTapped:(id)sender {
    if ([self.nameTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter name and description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSString *newName = self.nameTextField.text;
        NSString *newDesc = self.descriptionTextField.text;
        UIImage *defaultImage = [UIImage imageNamed:@"newMonster"];
        NSMutableArray *newAccessories = [NSMutableArray arrayWithObjects:@"TableViews", @"Storyboards", @"Livestream power", nil];
        MagicalCreature *newCreature = [[MagicalCreature alloc] initWithName:newName
                                                              andDescription:newDesc
                                                                    andImage:defaultImage
                                                              andAccessories:newAccessories];
        [self.creatures addObject:newCreature];
    }

    [self.tableView reloadData];
    self.nameTextField.text = @"";
    self.descriptionTextField.text = @"";

    if ([self.nameTextField isFirstResponder] == YES) {
        [self.nameTextField resignFirstResponder];

    } else if ([self.descriptionTextField isFirstResponder] == YES) {
        [self.descriptionTextField resignFirstResponder];
        
    }
}



#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{

    if ([segue.identifier isEqualToString:@"creatureDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        MagicalCreature *creature = [self.creatures objectAtIndex:indexPath.row];
        CreatureDetailViewController *vc = segue.destinationViewController;
        vc.creature = creature;
        vc.creatures = self.creatures;
        vc.index = indexPath;

    } else {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MagicalCreature *playerOne = [self.creatures objectAtIndex:indexPath.row];

        BattleViewController *vc = segue.destinationViewController;
        vc.fighters = self.creatures;
        vc.index = indexPath;

        if ([playerOne isSelected]) {
            NSLog(@"Player is selected: %@", playerOne.name);
            vc.battleCreature = playerOne;
            vc.battleCreature.name = [[self.creatures objectAtIndex:indexPath.row] name];
            vc.battleCreature.creatImage = [[[self creatures] objectAtIndex:indexPath.row] creatImage];
        } else {
            playerOne.isSelected = NO;
            NSLog(@"Player not selected");
        }
    }
}

#pragma mark - Buttons

- (void)buttonHighlight:(id)sender {
    self.addCreatureButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.67 blue:0.47 alpha:1.00];
}

- (void)buttonNormal:(id)sender {
    self.addCreatureButton.backgroundColor = [UIColor colorWithRed:0.23 green:0.47 blue:0.85 alpha:1.00];

}


@end
