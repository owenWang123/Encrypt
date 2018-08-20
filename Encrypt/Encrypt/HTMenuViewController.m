//
//  HTMenuViewController.m
//  SqliteDemo
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "HTMenuViewController.h"
#import "HTEncryptViewController.h"

@interface HTMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArr;

@end

@implementation HTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}
#pragma mark- UI
- (void)configUI{
    self.title = @"Menu";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
}
#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.sourceArr.count >0) {
        cell.textLabel.text = self.sourceArr[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self jumpToOtherPage:indexPath.row];
}
- (void)jumpToOtherPage:(NSInteger)index{
    HTEncryptViewController *controller = [[HTEncryptViewController alloc]init];
    controller.titleStr = self.sourceArr[index];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark- lazy
- (NSMutableArray *)sourceArr{
    if (_sourceArr == nil) {
        NSArray *tmpArr = @[@"URL Encode",@"Base64",@"MD5",@"SHA",@"AES",@"DES"];
        _sourceArr = [NSMutableArray arrayWithArray:tmpArr];
    }
    return _sourceArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
