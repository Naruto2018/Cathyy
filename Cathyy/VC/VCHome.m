//
//  VCHome.m
//  Cathyy
//
//  Created by 鸣人 on 2017/12/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "VCHome.h"
#import "MovieListModel.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "HomeTableCell.h"

NSString *const cellstr = @"Cell";
@interface VCHome ()

@end

@implementation VCHome

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tab.delegate = self;
    _tab.dataSource = self;
    
     _Data = [[NSMutableArray alloc] init];
    
    [self.view addSubview:_tab];
    [self loadData];
}

//返回数据个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",[_Data count]);
    return _Data.count;
}

//设置数据视图组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // _cell = [_tab dequeueReusableCellWithIdentifier:cellstr forIndexPath:indexPath];
    
//         _cell = [_tab dequeueReusableCellWithIdentifier:cellstr];
//
//        if (_cell == nil) {
//            //创建一个单元格对象
//            //1 单元格样式
//            //2 单元格复用标记
//            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//            _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellstr];
//        }
    
    //HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableCell class]) forIndexPath:indexPath];
    
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableCell class])];
    if (!cell) {
        cell = [[HomeTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([HomeTableCell class])];
    }

    cell.model = _Data[indexPath.row];
    return cell;

//    MovieListModel* MovieList = [_Data objectAtIndex:indexPath.row];
//
//    NSString* title = [NSString stringWithFormat:@"名字 %@",MovieList.title];
//
//    _imageView = [[UIImageView alloc] init];
//    [_imageView setFrame:CGRectMake(150, 5, 90, 90)];
//    [_cell.contentView addSubview:_imageView];
//
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:MovieList.img ];
//    if (image) {
//        _imageView.image = image;
//    } else {
//        [_imageView sd_setImageWithURL:[NSURL URLWithString:MovieList.img ] placeholderImage:[UIImage imageNamed:@"IMG_1413.JPG"]];
//    }
//
//    _cell.textLabel.text = title;
    //return _cell;
}

//获取高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 580;
}

-(Class)cellRegisterClass{
    return [HomeTableCell class];
}

-(void)setRefreshBlock:(GloableBlock)refreshBlock{
    _refreshBlock =refreshBlock;
    NSLog(@"setRefreshBlock");
    _tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //_size =20;
        _page =0;
        NSLog(@"setRefreshBlock");
        if (_refreshBlock) {
            _refreshBlock(_tab.mj_header);
        }
    }];
}
-(void)setLoadMoreBlock:(GloableBlock)loadMoreBlock{
    _loadMoreBlock =loadMoreBlock;
    _tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_loadMoreBlock) {
            _loadMoreBlock(_tab.mj_footer);
        }
    }];
}
-(void)startRefresh{
    [_tab.mj_header beginRefreshing];
}
-(void)stopRefresh{
    if ([_tab.mj_header isRefreshing]) {
        [_tab.mj_header endRefreshing];
    }
    if ([_tab.mj_footer isRefreshing]) {
        [_tab.mj_footer endRefreshing];
    }
}

-(void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    AFHTTPSessionManager* s = [AFHTTPSessionManager manager];
    @weakify(self);
    self.refreshBlock = ^(VCHome * refreshView) {
        @strongify(self);
    NSDictionary *dict = @{ @"page":@"0",@"per_page":@"5" ,@"isimg":@"1" ,@"json":@"1"};
    s.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [s GET:@"https://www.cathyy.com/index.php?Action=movielist" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             [self stopRefresh];
             [SVProgressHUD dismiss];
             MovieResAttionModel *resModel = [MovieResAttionModel yy_modelWithJSON:responseObject];
             _Data = [resModel.photo copy];
             [_tab reloadData];
         }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败->%@", error);
    }];
    };
    [self startRefresh];
    self.loadMoreBlock = ^(VCHome * refreshView) {
        @strongify(self);
        
    };
}

-(void)AFNetMonitor{
    //检测网络链接状态
    //AFNetworkReachabilityManager 网络监测管理类
    //开启网络状态监控器
    //sharedManager 获取唯一单例对象
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //获取网络链接结果
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络链接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络链接");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络,4G");
                break;
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
