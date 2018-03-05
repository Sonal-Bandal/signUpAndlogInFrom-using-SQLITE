//
//  ViewController.m
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender
{
    logInViewController *lvc=[self.storyboard instantiateViewControllerWithIdentifier:@"logInViewController"];
    
    [self.navigationController pushViewController:lvc animated:YES];
}

- (IBAction)signupAction:(UIButton *)sender
{
    signupViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"signupViewController"];
    
    [self.navigationController pushViewController:svc animated:YES];
}
@end
