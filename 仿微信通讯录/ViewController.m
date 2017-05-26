//
//  ViewController.m
//  仿微信通讯录
//
//  Created by qq on 2017/5/26.
//  Copyright © 2017年 fangxian. All rights reserved.
//

#import "ViewController.h"
#import "KTRelationShipAddressBookViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickOnPushButton:(UIButton *)sender {
    
    [self checkStatus];
}

#pragma mark --- 通讯录操作相关  注意：通讯录只适配了IOS9_OR_LATER_SX  如需支持更多在SXAddressBookManager 里修改即可

- (void)checkStatus
{
    [[SXAddressBookManager manager]checkStatusAndDoSomethingSuccess:^{
        NSLog(@"已经有权限，做相关操作，可以做读取通讯录等操作");
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        KTRelationShipAddressBookViewController *Vc = [sb instantiateViewControllerWithIdentifier:@"KTRelationShipAddressBookViewController"];
        Vc.personEntityArray = [[SXAddressBookManager manager]getPersonInfoArray];
        [self.navigationController pushViewController:Vc animated:YES];
        
    } failure:^{
        NSLog(@"未得到权限，做相关操作，可以做弹窗询问等操作");
        
        UIAlertController *alertViewC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-通讯录\"中允许访问通讯录。" preferredStyle:UIAlertControllerStyleAlert];
        [alertViewC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertViewC animated:YES completion: nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
