//
//  signupViewController.h
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "logInViewController.h"


@interface signupViewController : UIViewController<UITextFieldDelegate>

{
    sqlite3 *snapchatDatabase;
}

@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@property (strong, nonatomic) IBOutlet UITextField *firstNametextField;

@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;


@property (strong, nonatomic) IBOutlet UITextField *usernametextfield;

- (IBAction)signupbtnAction:(UIButton *)sender;


-(void)createTable;

-(NSString *)getDatabasePath;

-(BOOL)executeQuery:(NSString *)query;

-(void)getAllTasksDOne:(NSString *)query;

@property NSMutableArray *firstNameArray,*lastNameArray,*userNamesArray;



@end
