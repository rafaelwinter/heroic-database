//
//  HBCharacterTableViewCell.h
//  HeroicBase
//
//  Created by Rafael Winter on 26/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBCharacterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
