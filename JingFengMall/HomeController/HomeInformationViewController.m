//
//  HomeInformationViewController.m
//  JingFengMall
//
//  Created by len on 16/5/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeInformationViewController.h"
#import "SelectServicerTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "auntInfoModel.h"
#define URL @"	http://123.57.28.11:8080/jfsc_app/selectEmployeeByID.do"
@interface HomeInformationViewController ()
{
    NSArray *lblNameArray;
}

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblJiguan;
@property (strong, nonatomic) IBOutlet UILabel *lblZhengshu;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblOnTime;
@property (strong, nonatomic) IBOutlet UILabel *lblTrimness;
@property (strong, nonatomic) IBOutlet UILabel *lblColour;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblNum;
- (IBAction)btnSelect:(id)sender;
@property (nonatomic ,strong)UILabel *lbl;

@end

@implementation HomeInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人详情";
    
    
    self.scrollView.delegate = self;
    UIView *subView = [[[NSBundle mainBundle]loadNibNamed:@"HomeInformationViewController" owner:self options:nil]objectAtIndex:1];
    subView.frame = CGRectMake(0, 0, SCREEN_WIDTH,_scrollView.frame.size.height);
    [self.scrollView addSubview:subView];
    
    [self.view addSubview:_scrollView];
    /*
     id	int	要查看的雇员ID	非空
     typeID	int	该订单对应的服务类型的ID	非空
     */
    NSString *path= @"http://123.57.28.11:8080/jfsc_app/selectEmployeeByID.do";
    NSMutableDictionary *params2=[NSMutableDictionary dictionary];
    
    if (!self.delegate) {
        self.btnSelect.hidden = YES;
    }
    
    params2[@"id"]=_employeeID;
    //得详情界面的_typeId;名字都相同
    params2[@"typeID"]= _typeId;
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:path parameters:params2  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         NSLog(@"sadasdas %@",responsObject);
         NSDictionary *dic = [responsObject objectForKey:@"list"];
         
    
         [self.imageView sd_setImageWithURL:dic[@"photo"]];
         self.lblName.text = dic[@"name"];
         
         NSString *argString = [NSString stringWithFormat:@"%@", dic[@"arg"]];
         self.lblAge.text = argString;
         self.lblJiguan.text = dic[@"birthplace"];
         self.lblZhengshu.text = dic[@"certificate"];
         self.lblPrice.text = dic[@"price"];
         NSString *OnTimeString = [NSString stringWithFormat:@"%@", dic[@"onTime"]];
         self.lblOnTime.text = OnTimeString;
         NSString *neatString = [NSString stringWithFormat:@"%@",dic[@"neat"]];
         self.lblTrimness.text = neatString;
         NSString *appearanceString = [NSString stringWithFormat:@"%@", dic[@"appearance"]];
          self.lblColour.text = appearanceString;
         NSString *scoreString = [NSString stringWithFormat:@"%@", dic[@"score"]];
        self.lblTotal.text = scoreString;
         
         NSString *serviceCountString = [NSString stringWithFormat:@"%@", dic[@"serviceCount"]];
        self.lblNum.text = serviceCountString;
         
         //动态生成lable
         NSLog(@"%@",dic[@"label"]);
         lblNameArray =[dic[@"label"] componentsSeparatedByString:@","];
         
         static NSInteger page;
         for (int i = 0; i< lblNameArray.count-1; i++) {
             
             page = i / 4;
             NSInteger index = i % 4;
             
             _lbl = [[UILabel alloc]init];

             [_lbl setFrame:CGRectMake(index * 70 + ((SCREEN_WIDTH-280)/5*(index+1)), page  * 40 +240 , 70, 25)];
             _lbl.textAlignment = NSTextAlignmentCenter;
             _lbl.text = lblNameArray[i];
             //_lbl.backgroundColor = [UIColor orangeColor];
             _lbl.font = [UIFont systemFontOfSize:14];
             
             _lbl.textColor = [UIColor lightGrayColor];
             _lbl.layer.masksToBounds = YES;
             _lbl.layer.cornerRadius = 6.0;
             _lbl.layer.borderWidth = 1.0;
             _lbl.layer.borderColor = [[UIColor lightGrayColor] CGColor];
             [self.myView addSubview:_lbl];
             
         }
         
         self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH,(page + 1) * 40 + 226 + 70 );
         _scrollView.contentSize = _myView.frame.size;

     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         NSLog(@"nihao");
     }];
}
/*
 imageView
 lblName;
 lblAge;
 lblJiguan;
 lblZhengshu;
 lblPrice;
 lblOnTime;
 lblTrimness;
 lblColour;
 lblTotal;
 lblNum;
 */
-(void)setModel:(auntInfoModel *)model
{

}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 178, SCREEN_WIDTH, SCREEN_HEIGHT - 178 )];
        _scrollView.delegate = self;
//        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        _scrollView.showsHorizontalScrollIndicator = true;
        _scrollView.scrollEnabled = YES;
        [_scrollView flashScrollIndicators];
        _scrollView.directionalLockEnabled = YES;
        
    }
    return _scrollView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createItem{
    
    
}

- (IBAction)btnSelect:(id)sender {
   
    [(SelectServicerTableViewCell*)(self.delegate) passData];
    [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];

    
}
@end
