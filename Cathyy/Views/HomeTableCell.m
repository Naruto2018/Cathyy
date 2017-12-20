//
//  HomeTableCell.m
//  Cathyy
//
//  Created by 鸣人 on 2017/12/20.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "HomeTableCell.h"
#import <UIImageView+WebCache.h>
@interface HomeTableCell()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@end

@implementation HomeTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [UIImageView new];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(500);
        }];
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_imgView);
            make.top.equalTo(_imgView.mas_bottom).offset(15);
            make.height.mas_equalTo(25);
        }];
        _titleLabel.font = LZBoldFont(18);
        
        _detailLabel = [UILabel new];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.right.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        }];
        _detailLabel.font = LZFont(14);
        _detailLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)setModel:(MovieListModel *)model{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:LZImage(@"IMG_1413.JPG")];
    _titleLabel.text = model.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
