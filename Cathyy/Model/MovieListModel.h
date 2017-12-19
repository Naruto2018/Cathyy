//
//  MovieListModel.h
//  Cathyy
//
//  Created by 鸣人 on 2017/12/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieListModel : NSObject
///ID
@property (nonatomic,copy) NSString *id;
///标题
@property (nonatomic,copy) NSString *title;
///图片
@property (nonatomic,copy) NSString *img;

@end

@interface MovieResAttionModel : NSObject
@property (nonatomic,copy) NSArray *photo;
@property (nonatomic,assign) NSInteger count;

@end
