//
//  HBMasterViewController.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

// Controllers
#import "HBMasterViewController.h"
#import "HBDetailViewController.h"

// Models
#import "HBMarvelService.h"
#import "HBCharacterDataWrapper.h"
#import "HBCharacterDataContainer.h"
#import "HBCharacter.h"
#import "HBImage.h"

// Views
#import "HBCharacterTableViewCell.h"

// Utilities
#import "UIImageView+AFNetworking.h"

@interface HBMasterViewController ()

@property NSArray *objects;
@end

@implementation HBMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (HBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
        
    [self loadCharacterList];
    
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCharacterList {
    
    HBMarvelService *service = [HBMarvelService sharedMarvelService];
    
    [service characterListWithSuccess:^(HBCharacterDataWrapper *response) {
        self.objects = response.data.results;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error sad face: %@", error);
    }];
}

- (void)insertNewObject:(id)sender {

}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HBCharacter *object = self.objects[indexPath.row];
        HBDetailViewController *controller = (HBDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBCharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBCharacterTableViewCell"
                                                                     forIndexPath:indexPath];

    HBCharacter *object = self.objects[indexPath.row];
    
    cell.name.text = object.name;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:object.thumbnail.standardMediumPath]];
    
    return cell;
}


@end
