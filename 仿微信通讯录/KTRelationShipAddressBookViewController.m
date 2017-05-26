//
//  KTRelationShipAddressBookViewController.m
//  Client
//
//  Created by qq on 2017/5/23.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "KTRelationShipAddressBookViewController.h"
#import "KTAddressBookTableViewCell.h"

#import "ContactModel.h"
#import "ContactDataHelper.h"
#import "colors.h"

@interface KTRelationShipAddressBookViewController ()
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation KTRelationShipAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //去掉底部多余的表格线
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [_tableView setSectionIndexColor:[UIColor colorWithRed:117.0/255 green:117.0/255 blue:117.0/255 alpha:1]];
    _dataArr= [NSMutableArray array];
    for (NSDictionary *subDic in _personEntityArray) {
        ContactModel *model=[[ContactModel alloc]initWithDic:subDic];
        [_dataArr addObject:model];
    }
    
    _rowArr=[ContactDataHelper getFriendListDataBy:_dataArr];
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
}

// MARK: UITableViewDelegate & UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_rowArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _rowArr.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section]]];
    return label;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sectionArr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27.f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KTAddressBookTableViewCell* cell = [KTAddressBookTableViewCell settingCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ContactModel *model=_rowArr[indexPath.section][indexPath.row];
    cell.nameLabel.text = model.fullname.length > 0?model.fullname:@"#";
    cell.phoneLabel.text = model.phoneNumber;
    cell.imageLabel.text = model.phoneNumber == nil? _sectionArr[indexPath.section]:model.fullname.length >0?[model.fullname substringToIndex:1]:@"#";//# 这种就是没姓名
    cell.imageLabel.textColor = [UIColor blackColor];
    __weak __typeof__(self) weakSelf = self;
    if ([weakSelf.relationArray containsObject:model.phoneNumber]) {
        model.isHidden = @"1";
    }
    [weakSelf isShowType:cell.addButton withParam:model.isHidden];
    
    cell.isClickDownBtnBlock = ^(UITableViewCell *currentCell){
        
        NSIndexPath* index=[weakSelf.tableView indexPathForCell:currentCell];
        ContactModel *contactModel=_rowArr[index.section][index.row];
        
    };
    return cell;
}

// 判断 cell上 button的显示样式
- (void)isShowType:(UIButton *)btn withParam:(NSString *)isParam{
    
    if ([isParam isEqualToString:@"1"]) {
        btn.enabled = NO;
        [btn setTitle:@"已添加" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 0;
        btn.layer.borderWidth = 0;
    }else{
        btn.enabled = YES;
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:titleRed] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 0.5;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
