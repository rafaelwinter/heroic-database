//
//  HBDetailViewController.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBCharacter;

@interface HBDetailViewController : UIViewController

@property (strong, nonatomic) HBCharacter *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *shortBio;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;

@end

