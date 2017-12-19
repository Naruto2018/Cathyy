//
//  MovieListModel.m
//  Cathyy
//
//  Created by 鸣人 on 2017/12/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "MovieListModel.h"

@implementation MovieListModel

@end

@implementation MovieResAttionModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"photo" : [MovieListModel class],};
}
@end
