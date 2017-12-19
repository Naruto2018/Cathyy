//
//  VCHome.h
//  Cathyy
//
//  Created by 鸣人 on 2017/12/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPhotoBrowser.h"
typedef void (^GloableBlock)(id x);

@interface VCHome : UIViewController<UITableViewDataSource,UITableViewDelegate,KSPhotoBrowserDelegate>{
    UITableView* _tab;
    UIImageView* _imageView;
    UITableViewCell* _cell;
    
    //数据视图数据源
    NSMutableArray* _Data;
    
}

@property(nonatomic,copy)GloableBlock refreshBlock;
@property(nonatomic,copy)GloableBlock loadMoreBlock;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger size;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) int k;
@end
