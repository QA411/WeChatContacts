//
//  KTAddressBookTableViewCell.h
//  Client
//
//  Created by qq on 2017/5/23.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KTAddressBookTableViewCellBlock)(UITableViewCell *cell);

@interface KTAddressBookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic , copy) KTAddressBookTableViewCellBlock isClickDownBtnBlock;

+ (instancetype)settingCellWithTableView:(UITableView *)tableview;
@end
