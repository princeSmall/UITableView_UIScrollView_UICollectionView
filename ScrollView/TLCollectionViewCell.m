//
//  TLCollectionViewCell.m
//  ScrollView
//
//  Created by le tong on 2018/10/11.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "TLCollectionViewCell.h"
@interface TLCollectionViewCell()

@end

@implementation TLCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLBL];
    }
    return self;
}

- (UILabel *)titleLBL{
    if (!_titleLBL) {
        _titleLBL = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        _titleLBL.textColor = [UIColor blackColor];
        _titleLBL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLBL;
}


@end
