//
//  HBImage.m
//  HeroicBase
//
//  Created by Rafael Winter on 26/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBImage.h"

@implementation HBImage

- (NSString<Ignore> *)standardMediumPath {
    return [NSString stringWithFormat:@"%@/standard_medium.%@", self.path, self.extension];
    
}

- (NSString<Ignore> *)landscapeIncrediblePath {
    return [NSString stringWithFormat:@"%@/landscape_incredible.%@", self.path, self.extension];
    
}

@end
