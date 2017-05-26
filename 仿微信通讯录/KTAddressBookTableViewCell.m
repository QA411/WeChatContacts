//
//  KTAddressBookTableViewCell.m
//  Client
//
//  Created by qq on 2017/5/23.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "KTAddressBookTableViewCell.h"
#import "colors.h"

@implementation KTAddressBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 注意  自定义分割线写在这里  会避免由于  右边的索引栏 导致cell的contentView收窄  从而出现 分割线不能到头（一直抵达屏幕右边缘）的bug
    // 为毛这样  我也不清楚  反正xib中使用分割线  会由于右边的索引栏 分割线不能到头（一直抵达屏幕右边缘）视图调试器查看显示cell的contentView收窄
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(16, 80.f - 1, [UIScreen mainScreen].bounds.size.width, 1)];
    view.backgroundColor = [UIColor colorWithHex:titleRed];
    [self.contentView addSubview:view];
}

// 创建单元格的时候使用默认的style
+ (instancetype)settingCellWithTableView:(UITableView *)tableview {
    static NSString *ID = @"KTAddressBookTableViewCell";
    KTAddressBookTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (IBAction)clickOnBtn:(id)sender {
    if (self.isClickDownBtnBlock) {
        self.isClickDownBtnBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
