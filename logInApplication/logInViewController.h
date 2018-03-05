//
//  logInViewController.h
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "signupViewController.h"

@interface logInViewController : UIViewController<UITextFieldDelegate>
{
    sqlite3 *snapchatdatabase;
}



@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)logInAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;

-(void)createTable;

-(NSString *)getDatabasePath;

-(BOOL)executequery:(NSString *)query;

-(void)getAllTasksDOne:(NSString *)query;

@property NSMutableArray *usernameArray,*passwordArray;

@end
