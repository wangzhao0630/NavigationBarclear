//
//  ViewController.m
//  NavigationBarClear
//
//  Created by juru on 2017/8/2.
//  Copyright © 2017年 juruyi. All rights reserved.
//

#define QMHeadViewH 140

#define QMHeadViewMinH 64

#define QMTabBarH 44
#import "ViewController.h"
#import "UIImage+Image.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, assign) CGFloat oriOffsetY;
@property (nonatomic, weak) UILabel *label;
@end

@implementation ViewController{
    UIView *myheaderView;
    UIView *mineCenterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.backgroundColor = [UIColor yellowColor];
    myTable.showsVerticalScrollIndicator = NO;
    myTable.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:myTable];
    myheaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, QMHeadViewH)];
    myheaderView.backgroundColor = [UIColor redColor];
    mineCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 140-64, self.view.frame.size.width, QMTabBarH)];
    mineCenterView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:mineCenterView];
    [self.view addSubview:myheaderView];
    // 设置导航条
    [self setUpNavigationBar];
    
    // 不需要添加额外的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 先记录最开始偏移量
    _oriOffsetY = -(QMHeadViewH + QMTabBarH);
    
    // 设置tableView顶部额外滚动区域`
    myTable.contentInset = UIEdgeInsetsMake((QMHeadViewH + QMTabBarH), 0, 0, 0);
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算下tableView滚动了多少
    
    // 偏移量:tableView内容与可视范围的差值
    
    // 获取当前偏移量y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    
    // 计算偏移量的差值 == tableView滚动了多少
    // 获取当前滚动偏移量 - 最开始的偏移量(-244)
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    // 计算下头部视图的高度
    CGFloat h = QMHeadViewH - delta;
    if (h < QMHeadViewMinH) {
        h = QMHeadViewMinH;
    }
    myheaderView.frame =  CGRectMake(0, -64, self.view.frame.size.width, h);
    mineCenterView.frame = CGRectMake(0, CGRectGetMaxY(myheaderView.frame), self.view.frame.size.width, QMTabBarH);
    
    // 修改头部视图高度,有视觉差效果
    
    // 处理导航条业务逻辑
    
    // 计算透明度
    CGFloat alpha = delta / (QMHeadViewH - QMHeadViewMinH);
    
    if (alpha > 1) {
        alpha = 0.99;
    }
    
    // 设置导航条背景图片
    // 根据当前alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 设置导航条标题颜色
    _label.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    NSLog(@"%f",alpha);
    
}

// 设置导航条
- (void)setUpNavigationBar
{
    // 设置导航条背景为透明
    // UIBarMetricsDefault只有设置这种模式,才能设置导航条背景图片
    // 传递一个空的UIImage
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 清空导航条的阴影的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航条标题为透明
    UILabel *label = [[UILabel alloc] init];
    label.text = @"sias丶小雨";
    
    _label = label;
    
    // 设置文字的颜色
    label.textColor = [UIColor colorWithWhite:1 alpha:0];
    
    // 尺寸自适应:会自动计算文字大小
    [label sizeToFit];
    
    [self.navigationItem setTitleView:label];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    //    float Version=[[[UIDevice currentDevice] systemVersion] floatValue];
    //
    //    if(Version>=7.0)
    //    {
    //        tableView = (UITableView *)self.scrollView;
    //    }
    //    else
    //    {
    //        tableView=(UITableView *)self.scrollView.superview;
    //    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//辅助标示类型
        
    }
    //显示内容
    
    cell.imageView.image = [UIImage imageNamed:@"sias丶小雨"];
    cell.textLabel.text = @"sias丶小雨";
    cell.detailTextLabel.text = @"我是sias丶小雨,无畏先锋,最强王者";
    return cell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
