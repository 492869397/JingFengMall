//
//  HomeSecondViewMenu.m
//  JingFengMall
//
//  Created by len on 16/5/6.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeSecondViewMenu.h"
#import "MultilevelTableViewCell.h"
#import "MultilevelCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
#import "RDVTabBarController.h"
#import "HomeSecondViewCell.h"

#define kCellRightLineTag 100
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define HomeSecondViewCell @"HomeSecondViewCell"

#define URL @"http://123.57.28.11:8080/jfsc_app/selectHTypeByTwo.do"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface HomeSecondViewMenu()
@property (nonatomic ,strong)NSMutableArray *array;
@property (nonatomic ,strong)NSDictionary *Dic;
@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@end


@implementation HomeSecondViewMenu


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
        self.leftBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor=[UIColor blackColor];
        
        _selectIndex=0;
        
        leftCodeArray = @[@"12",@"14",@"13",@"19",@"5",@"18",@"16",@"17",@"7"];
        
        /**
         左边的视图
         */
          _leftData = @[@"家庭清洁",@"保姆",@"月嫂",@"生活无忧",@"家具养护",@"运输",@"其他"];
//        _leftData = @[@"促销产品",@"名优特产",@"京锋直供",@"水果生鲜",@"蔬菜",@"熟食",@"粮油调味",@"食品生鲜",@"饮料"];
        self.rightData = [NSMutableArray array];
        
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        
        //        /****
        //         右边的上面的图片
        //         ******/
        //        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15+kLeftWidth, 16, kMainScreenWidth-(15*2+kLeftWidth) ,(kMainScreenWidth-(15+kLeftWidth)*2)/3 )];
        //        [self addSubview:image];
        //        image.backgroundColor = [UIColor redColor];
        
      UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing=0.f;//左右间隔
        flowLayout.minimumLineSpacing=0.f;
        float leftMargin = 0;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,16,kMainScreenWidth-kLeftWidth-leftMargin,frame.size.height-20) collectionViewLayout:flowLayout];
        _rightCollection.backgroundColor = [UIColor blueColor];
        
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        
        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
        
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        
        
        [self addSubview:self.rightCollection];
        
        
        self.isReturnLastOffset=YES;
        
        self.rightCollection.backgroundColor=self.leftSelectBgColor;
        
        self.backgroundColor=self.leftSelectBgColor;
        
    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    
    /**
     *  滑动到 指定行数
     */
    [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    _selectIndex=needToScorllerIndex;
    
    [self.rightCollection reloadData];
    
    _needToScorllerIndex=needToScorllerIndex;
}
-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
    
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    self.rightCollection.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}

-(void)setLeftTablewCellSelected:(BOOL)selected withCell:(MultilevelTableViewCell*)cell
{
    UILabel * line=(UILabel*)[cell viewWithTag:kCellRightLineTag];
    if (selected) {
        
        line.backgroundColor=cell.backgroundColor;
        cell.titile.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
    }
    else{
        cell.titile.textColor=self.leftUnSelectColor;
        cell.backgroundColor=self.leftUnSelectBgColor;
        line.backgroundColor=_leftTablew.separatorColor;
    }
    
}

#pragma mark---从网络获取数据的方法
-(void)getRightData:(NSUInteger)index
{
    NSMutableDictionary *params2=[NSMutableDictionary dictionary];
    params2[@"typeID"] = @"2";
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:URL parameters:params2  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         
         NSMutableArray *dataArray = [NSMutableArray arrayWithArray:responsObject[@"list"]];
         for (NSMutableDictionary *dict in dataArray) {
             findModel *model = [findModel initWithDict:dict];
             [self.array addObject:model];
         }
         [self.rightCollection reloadData];
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
     }];

    
}

-(void)setRightView
{
    
    self.isReturnLastOffset=NO;
    
    
    [self.rightCollection reloadData];
    
    [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:self.isRecordLastScrollAnimated];
    
}

#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor=tableView.separatorColor;
        [cell addSubview:label];
        label.tag=kCellRightLineTag;
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.titile.text = _leftData[indexPath.row];
    
    
    if (indexPath.row==self.selectIndex) {
        
        [self setLeftTablewCellSelected:YES withCell:cell];
    }
    else{
        [self setLeftTablewCellSelected:NO withCell:cell];
        
    }
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self getRightData:indexPath.row];
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    //    MultilevelTableViewCell * BeforeCell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:_selectIndex]];
    //
    //    [self setLeftTablewCellSelected:NO withCell:BeforeCell];
    _selectIndex=indexPath.row;
    
    [self setLeftTablewCellSelected:YES withCell:cell];
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    //    cell.titile.textColor=self.leftUnSelectColor;
    //    UILabel * line=(UILabel*)[cell viewWithTag:100];
    //    line.backgroundColor=tableView.separatorColor;
    
    [self setLeftTablewCellSelected:NO withCell:cell];
    
    cell.backgroundColor=self.leftUnSelectBgColor;
}

#pragma mark---imageCollectionView--------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.rightData.count;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsModel *good = _rightData[indexPath.row];
    
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc]init];
    
    vc.goodsID = good.goodsID;
    vc.good = good;
    
    [self.delegate.rdv_tabBarController.navigationController pushViewController:vc animated:YES];
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    
    GoodsModel *goods = _rightData[indexPath.row];
    
    
    cell.title.text = goods.title;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.backgroundColor=UIColorFromRGB(0xF8FCF8);
    NSString *url = [goods.photo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:kImageDefaultName]];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (_rightCollection.frame.size.width-40)/2-10;
    
    return CGSizeMake(width, width+30);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 20, 5, 20);
    
}

#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        self.isReturnLastOffset=YES;
    }
}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if ([scrollView isEqual:self.rightCollection]) {
//
//        title.offsetScorller=scrollView.contentOffset.y;
//        self.isReturnLastOffset=NO;
//
//    }
//
// }
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:self.rightCollection]) {
//
//        rightMeun * title=self.allData[self.selectIndex];
//
//        title.offsetScorller=scrollView.contentOffset.y;
//        self.isReturnLastOffset=NO;
//
//    }
//
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
//        rightMeun * title=self.allData[self.selectIndex];
//
//        title.offsetScorller=scrollView.contentOffset.y;
//
//        
//    }
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
