//
//  ViewController.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "ViewController.h"
#import "SNShareHeaders.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 80, 50);
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)test
{
    [[SNShareManager sharedSNShareManager] test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
