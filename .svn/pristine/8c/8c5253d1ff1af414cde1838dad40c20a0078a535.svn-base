//
//  HomeAssessViewController.m
//  JingFengMall
//
//  Created by len on 16/5/10.
//  Copyright © 2016年 yunlan. All rights reserved.
//

#import "HomeAssessViewController.h"
#import "HomeSucceedViewController.h"

@interface HomeAssessViewController ()
{
   NSString *one;
   NSString *two;
   NSString *three;
}
- (IBAction)FinishedBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *star1;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet TQStarRatingView *onTimeRatingView;
@property (weak, nonatomic) IBOutlet TQStarRatingView *cleanRatingView;
@property (weak, nonatomic) IBOutlet TQStarRatingView *lookRatingView;

@end

@implementation HomeAssessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"评价";
 
    _onTimeRatingView.delegate = self;
    _lookRatingView.delegate = self;
    _cleanRatingView.delegate = self;
    
    _textField.delegate = self;
    
    [self setBtnConfig];
}

-(void)setBtnConfig
{
    UIView *view = [self.view viewWithTag:10];
    for (int i = 11; i <= 22 ; i++) {
        UIButton *btn = [view viewWithTag:i];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 0.5;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -五星评价代理
-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
//    float s = score * 5;
    int s = score;
    if (view == _onTimeRatingView) {
        oneTag = s;
    }else if (view == _cleanRatingView)
    {
        twoTag = s;
    }else
    {
        threeTag = s;
    }
}

#pragma mark - textField字数限制

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_textField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 4) { //如果输入框内容大于20则弹出警告
            Toast *toa = [Toast makeText:@"最多输入四个字"];
            [toa showWithType:ShortTime];
            return NO;
        }
    }
    return YES;
}

static  float oneTag = 5 ;
static  float twoTag = 5;
static  float threeTag = 5;

- (IBAction)FinishedBtn:(id)sender {
    
    
    /*
     userPhone	String	用户手机号(账号)	非空
     onTime	float	准时的星级	非空
     neat	float	整洁的星级	非空
     appearance	float	外貌的星级	非空
     orderID	int	要评价的订单ID	非空
     label	int	标签串（神准时，整洁，）	非空
     */
    NSString *url = @"http://123.57.28.11:8080/jfsc_app/addHAssess.do";
    NSMutableDictionary *pass = [[NSMutableDictionary alloc]init];
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:ACCOUNT];
    [pass setObject:user forKey:@"userPhone"];
    NSLog(@"orderID=%@",_orderID);
    [pass setObject:_orderID forKey:@"orderID"];
  
    NSString  *strFloat1 = [NSString stringWithFormat:@"%f",oneTag];
    [pass setObject:strFloat1 forKey:@"onTime"];
    NSString  *strFloat2 = [NSString stringWithFormat:@"%f",twoTag];
    [pass setObject:strFloat2 forKey:@"neat"];
    NSString  *strFloat3 = [NSString stringWithFormat:@"%f",threeTag];
    [pass setObject:strFloat3 forKey:@"appearance"];
    
    
    NSMutableString *strs = [NSMutableString string];
    UIView *view = [self.view viewWithTag:10];
    for (int i = 11; i <= 20 ; i++) {
        UIButton *btn = [view viewWithTag:i];
        if (btn.selected) {
            NSString *s = btn.titleLabel.text;
            [strs appendFormat:@"%@,",s];
        }
    }
    if (_textField.text) {
        [strs appendString:_textField.text];
    }
    
    [pass setObject:strs forKey:@"label"];
    AFHTTPRequestOperationManager *mgr2=[AFHTTPRequestOperationManager manager];
    [mgr2 POST:url parameters:pass  success:^(AFHTTPRequestOperation * operation, id responsObject)
     {
         NSLog(@"%@",responsObject);
         if ([[responsObject objectForKey:@"code"] isEqualToNumber:@1]) {
             
         HomeSucceedViewController *HSVC = [[HomeSucceedViewController alloc]init];
         [self.navigationController pushViewController:HSVC animated:YES];
             HSVC.lableStr = @"感谢您的评价,我们会继续努力!";
        }
    
         else{
             HomeSucceedViewController *HSVC = [[HomeSucceedViewController alloc]init];
             [self.navigationController pushViewController:HSVC animated:YES];
             HSVC.lableStr = @"评价失败";

         }
         
     } failure:^(AFHTTPRequestOperation * operation, NSError * error)
     {
         
         Toast *toa = [Toast makeText:@"网络连接失败请重试"];
         [toa showWithType:ShortTime];
         
     }];
    
}




- (IBAction)btn1:(UIButton*)sender
{

    if (sender.isSelected == NO) {
        if (_labelNumber >= 3) {
            Toast *toa = [Toast makeText:@"最多只能选三个"];
            [toa showWithType:ShortTime];
        }else
        {
            sender.backgroundColor = [UIColor grayColor];
            sender.selected = YES;
            _labelNumber++;
        }
    }else
    {
        sender.backgroundColor = [UIColor whiteColor];
        sender.selected = NO;
        _labelNumber--;
    }
}


@end
