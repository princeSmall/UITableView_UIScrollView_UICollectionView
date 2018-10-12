//
//  ViewController.m
//  ScrollView
//
//  Created by le tong on 2018/10/11.
//  Copyright © 2018年 le tong. All rights reserved.
//

#import "ViewController.h"
#import "TLCell.h"
#import "TLImageCell.h"
#import "TLCollectionViewCell.h"
#import "TLBackCell.h"

#define WINWIDTH self.view.frame.size.width
#define WINHEIGHT self.view.frame.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSInteger currentSelected;
}
@property (nonatomic , strong)UITableView *TLTableView;
@property (nonatomic , strong)UICollectionView *headCV;
@property (nonatomic , strong)UIScrollView *TLScrollView;
@property (nonatomic , strong)UITableView *TLBottomTV;
@property (nonatomic , strong)UIView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.TLTableView];
    self.title = @"UITableView + UIScrollView + UICollectionView";
    currentSelected = 0;
    // Do any additional setup after loading the view, typically from a nib.
}
- (UITableView *)TLTableView{
    if (!_TLTableView) {
        _TLTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _TLTableView.delegate = self;
        _TLTableView.dataSource = self;
        _TLTableView.tableFooterView = [UIView new];
        [_TLTableView registerClass:[TLCell class] forCellReuseIdentifier:cellIndentifier];
        [_TLTableView registerClass:[TLImageCell class] forCellReuseIdentifier:imageCellIndentifier];
    }
    return _TLTableView;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tableView isEqual:self.TLTableView] ?  2 : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableView isEqual:self.TLTableView] ? 1 : 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.TLTableView]) {
        return indexPath.section == 0 ? 200 : WINHEIGHT;
    }else{
        return 100;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.TLTableView]) {
        return section == 0 ? 0 : 120;
    }else{
        return 0;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headCV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if ([tableView isEqual:self.TLTableView]) {
        if (indexPath.section == 0) {
            TLImageCell *tlImageCell = [tableView dequeueReusableCellWithIdentifier:imageCellIndentifier forIndexPath:indexPath];
            if (tlImageCell == nil) {
                tlImageCell = [[TLImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellIndentifier];
            }
            tlImageCell.backgroundColor = [UIColor redColor];
            cell = tlImageCell;
        }else{
            TLCell * tlCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
            if (tlCell == nil) {
                tlCell = [[TLCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            }
            [tlCell addSubview:self.TLScrollView];
            
            cell = tlCell;
        }
    }else{
        TLBackCell * tlBackCell = [tableView dequeueReusableCellWithIdentifier:TLBackCellIndentifier forIndexPath:indexPath];
        if (tlBackCell == nil) {
            tlBackCell = [[TLBackCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TLBackCellIndentifier];
        }
        tlBackCell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        tlBackCell.textLabel.textColor = [UIColor blackColor];
        cell = tlBackCell;
    }
    return cell;
}
- (UIScrollView *)TLScrollView{
    if (!_TLScrollView) {
        _TLScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _TLScrollView.contentSize = CGSizeMake(WINWIDTH * 20, WINHEIGHT);
        for (int i = 0; i < 20; i ++) {
            _TLBottomTV = [[UITableView alloc]initWithFrame:CGRectMake(i * WINWIDTH, 0, WINWIDTH, WINHEIGHT)];
            _TLBottomTV.delegate = self;
            _TLBottomTV.dataSource = self;
            _TLBottomTV.tableFooterView = [UIView new];
            [_TLBottomTV registerClass:[TLBackCell class] forCellReuseIdentifier:TLBackCellIndentifier];
           [_TLScrollView addSubview:self.TLBottomTV];
        }
        [_TLScrollView setContentOffset:CGPointMake(0, 0)];
        
    }
    return _TLScrollView;
}
- (UICollectionView *)headCV{
    if (!_headCV) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 5, 120);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _headCV = [[UICollectionView alloc]initWithFrame:self.TLTableView.tableHeaderView.bounds collectionViewLayout:flowLayout];
        _headCV.showsVerticalScrollIndicator = NO;
        _headCV.showsHorizontalScrollIndicator = NO;
        _headCV.backgroundColor = [UIColor whiteColor];
        [_headCV registerClass:[TLCollectionViewCell class] forCellWithReuseIdentifier:tlCollectionViewCell];
        _headCV.delegate = self;
        _headCV.dataSource = self;
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 10 - 15, 119, 30, 5)];
        self.lineView.backgroundColor = [UIColor blackColor];
        [_headCV addSubview:self.lineView];
    }
    return _headCV;
}
#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:tlCollectionViewCell forIndexPath:indexPath];
    cell.titleLBL.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.titleLBL.textColor = [UIColor blackColor];
    cell.titleLBL.transform = CGAffineTransformIdentity;
    if (indexPath.row == currentSelected) {
        [UIView animateWithDuration:.2f animations:^{
            cell.titleLBL.transform = CGAffineTransformMakeScale(2, 2);
            cell.titleLBL.textColor = [UIColor redColor];
        } completion:^(BOOL finished) {
        }];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    currentSelected = indexPath.row;
    [UIView animateWithDuration:.2f animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation((self.view.frame.size.width / 5 + 20) * indexPath.row ,0);
    } completion:^(BOOL finished) {

    }];
    [collectionView reloadData];
    
    [self.TLScrollView setContentOffset:CGPointMake(WINWIDTH *indexPath.row, 0) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
