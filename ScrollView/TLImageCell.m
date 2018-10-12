
//
//  TLImageCell.m
//  ScrollView
//
//  Created by le tong on 2018/10/11.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "TLImageCell.h"
@interface TLImageCell()
@property (nonatomic ,strong)UIImageView *imageV;

@end
@implementation TLImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageV];
        
    }return self;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _imageV.image = [UIImage imageNamed:@"images"];
    }
    return _imageV;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
