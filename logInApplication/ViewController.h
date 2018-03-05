//
//  ViewController.h
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signupViewController.h"
#import "logInViewController.h"

@interface ViewController : UIViewController



@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)signupAction:(UIButton *)sender;

@end

