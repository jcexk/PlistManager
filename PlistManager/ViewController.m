//
//  ViewController.m
//  AAAAAA
//
//  Created by 江其 on 2018/8/7.
//  Copyright © 2018年 江其. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showDetailViewController:[SecondVC new] sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

