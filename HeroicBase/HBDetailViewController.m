//
//  HBDetailViewController.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

// Model
#import "HBCharacter.h"
#import "HBImage.h"

// Controller
#import "HBDetailViewController.h"

// Utilities
#import "UIImageView+AFNetworking.h"

@interface HBDetailViewController ()

@end

@implementation HBDetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.name.text = self.detailItem.name;
        self.shortBio.text = self.detailItem.shortBio;
        [self.portrait setImageWithURL:[NSURL URLWithString:self.detailItem.thumbnail.landscapeIncrediblePath]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(HBCharacter *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
