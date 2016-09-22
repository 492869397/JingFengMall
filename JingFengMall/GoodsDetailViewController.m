//
//  GoodsDetailViewController.m
//  JingFengMall
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "CommentModel.h"
#import "YYCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "CommentTableViewCell.h"
#import "CartTableViewController.h"
#import "LoginViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _tableview.estimatedRowHeight = 20;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    
    [self setData];
    
    self.title = @"商品详情";
    
    _tableview.allowsSelection = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     return _head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 429;
}

-(void)setData
{
    self.array = [NSMutableArray array];
    
    self.head = [[[NSBundle mainBundle]loadNibNamed:@"GoodsDetailTitleView" owner:nil options:nil]firstObject];
    
    _head.title.text = _good.title;
    _head.price.text = _good.price;
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"没有更多的评论了";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    label.frame = CGRectMake(10, 0, 150,12 );
    [label sizeToFit];
    
    _tableview.tableFooterView = view;
    
    [self fresh];
}

-(void)fresh
{
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:_goodsID forKey:@"commodityID"];
    
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/selectMallCommodityDetail.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_array removeAllObjects];
        
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            NSArray *array = [NSArray arrayWithArray:[responseObject objectForKey:@"listAssess"]];
            
            for (NSDictionary *dic in array) {
                
                NSString *photo = [[dic objectForKey:@"photo"] isKindOfClass:[NSNull class]]?@"":[dic objectForKey:@"photo"];
                
                CommentModel *com = [[CommentModel alloc]initWithUser:[dic objectForKey:@"userPhone"] commodityID:[dic objectForKey:@"commodityID"] comment:[dic objectForKey:@"assess"] level:[dic objectForKey:@"assessType"] photo:photo];
                [_array addObject:com];
            }
            
            NSString* string = [[[responseObject objectForKey:@"list"]firstObject]objectForKey:@"photo"];
            
            NSArray *arr = [string componentsSeparatedByString:@"**"];
            NSMutableArray *imageArr = [NSMutableArray array];
            
            YYCycleScrollView *adscroll = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, _head.scroll.frame.size.width, _head.scroll.frame.size.height) animationDuration:2.0];
            
            for (NSString *str in arr) {
                NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *u = [NSURL URLWithString:url];
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _head.scroll.frame.size.width, _head.scroll.frame.size.height)];
                [imageview sd_setImageWithURL:u];
                [imageArr addObject:imageview];
            }
            
            [adscroll setFetchContentViewAtIndex:^UIView *(NSInteger index) {
                return imageArr[index];
            }];
            
            [adscroll setTotalPagesCount:^NSInteger{
                return imageArr.count;
            }];
            
            [_head.scroll addSubview:adscroll];
            
            
            _head.count.text = [NSString stringWithFormat:@"月售%@份",[responseObject[@"list"] firstObject] [@"buyCount"] ];
            _head.describe.text = [responseObject[@"list"] firstObject] [@"describe"];
            
        }
        
        [self.tableview reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:nil options:nil]firstObject];
    }
    
    
    CommentModel *commentModel = _array[indexPath.row];
    cell.commentModel = commentModel;
    NSArray *arr = [commentModel.photo componentsSeparatedByString:@"**"];
    
    if ([arr[0] isEqualToString:@""]) {
        
        cell.imageHeight.constant = 0;
        
    }else
    {
        cell.imageHeight.constant = arr.count/4*80+80;
        
        int i = 0;
        for (NSString *urlStr in arr) {
            NSString *url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(80*i%4, i/4*0, 80, 80)];
            [image sd_setImageWithURL:[NSURL URLWithString:url]];
            [cell.viewForImage addSubview:image];
            i++;
        }
        
    }
    
    [cell.startLevelView setScore:commentModel.level.floatValue/5];
    
    NSMutableString *user = [NSMutableString stringWithString:[commentModel.user substringToIndex:3]];
    [user appendFormat:@"***%@",[commentModel.user substringFromIndex:7]];
    
    cell.commentPerson.text = user;
    
    cell.comment.text = commentModel.comment;
    
    return cell;
}


- (IBAction)addToCart:(UIButton *)sender {
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
        
        Toast *toa = [Toast makeText:@"登录后才能进行此操作"];
        [toa showWithType:ShortTime];
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
        return;
    }
    
    Network *net = [[Network alloc]init];
    NSMutableDictionary *pass = [NSMutableDictionary dictionaryWithCapacity:4];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    [pass setObject:_goodsID forKey:@"commodityID"];
    [pass setObject:@"1" forKey:@"commodityNumber"];
    [net accessNetUrl:@"http://123.57.28.11:8080/jfsc_app/addMallShoppingCart.do" parameters:pass success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"code"]isEqualToNumber:@1]) {
            
            Toast *toa = [Toast makeText:@"加入购物车成功"];
            [toa showWithType:ShortTime];
            
        }else
        {
            NSString *str = [responseObject objectForKey:@"msg"];
            Toast *toa = [Toast makeText:str];
            [toa showWithType:ShortTime];
        }
    }];
}

- (IBAction)enterCart:(UIButton *)sender {
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLogin"]) {
        
        Toast *toa = [Toast makeText:@"登录后才能进行此操作"];
        [toa showWithType:ShortTime];
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
        return;
    }
    
    CartTableViewController *cart = [[CartTableViewController alloc]init];
    [self.navigationController pushViewController:cart animated:YES];
}

@end