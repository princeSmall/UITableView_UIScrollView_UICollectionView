# UITableView_UIScrollView_UICollectionView

### 视图层级
1、TLTableView最外层容器视图

2、headCV头部滚动视图

3、TLScrollView内容滚动视图

4、TLBottomTV滚动内容视图

5、lineView滚动线条

### 视图嵌套
<pre>
/****
 重写headview，返回CollectionView
 ****/
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
</pre>
<pre>
/****
 在cell里嵌套UIScrollView，用于滚动
 ***/
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
</pre>

### 视图操作
1、字体改变动画
<pre>
if (indexPath.row == currentSelected) {
        [UIView animateWithDuration:.2f animations:^{
            cell.titleLBL.transform = CGAffineTransformMakeScale(2, 2);
            cell.titleLBL.textColor = [UIColor redColor];
        } completion:^(BOOL finished) {
        }];
    }
 </pre>


2、视图滚动动画

<pre>
[UIView animateWithDuration:.2f animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation((self.view.frame.size.width / 5 + 20) * indexPath.row ,0);
    } completion:^(BOOL finished) {

    }];
    [collectionView reloadData];
    [self.TLScrollView setContentOffset:CGPointMake(WINWIDTH *indexPath.row, 0) animated:YES];
</pre>
