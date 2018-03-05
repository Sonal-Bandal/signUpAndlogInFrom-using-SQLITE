//
//  signupViewController.m
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import "signupViewController.h"

@interface signupViewController ()

@end

@implementation signupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTable];
    
    NSString *getData=@"select firstName,lastName,userName from snapchat";
    
    [self getAllTasksDOne:getData];
    if (self.firstNameArray.count>0) {
        self.firstNametextField.delegate=self;
        
        self.lastNameTextField.delegate=self;
        
        self.usernametextfield.delegate=self;
    }
    
    NSLog(@"%@",self.firstNameArray);
    
    NSLog(@"%@",self.lastNameArray);
    
    NSLog(@"%@",self.userNamesArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTable
{
    NSString *createQuery=@"create table if not exists snapchat(firstName text,lastName text,userName text)";
    
    BOOL success=[self executeQuery:createQuery];
    
    if (success)
    {
        NSLog(@"TABLE CREATED");
        
    }
}

-(NSString *)getDatabasePath
{
    NSArray *docArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docpath=[[docArray firstObject]stringByAppendingString:@"/snapchat.db"];
    
    NSLog(@"PATH IS ::%@",docpath);
    
    return docpath;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)executeQuery:(NSString *)query
{
    BOOL success=0;
    
    sqlite3_stmt *stmt;

    const char *cQuery=[query UTF8String];
    
    const char *dbpath=[[self getDatabasePath]UTF8String];
    
    if (sqlite3_open(dbpath,&snapchatDatabase)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(snapchatDatabase,cQuery,-1,&stmt,NULL)==SQLITE_OK)
        {
            if (sqlite3_step(stmt)==SQLITE_DONE)
            {
                success=1;
                
                NSLog(@"done");
                
            }
            else
            {
                NSLog(@"%s in sqlite3_step ",sqlite3_errmsg(snapchatDatabase));
            }
        }
        else
        {
            NSLog(@"%s in sqlite3_prepare_v2",sqlite3_errmsg(snapchatDatabase));
        }
    }
    else
    {
        NSLog(@"%s in sqlite3_open",sqlite3_errmsg(snapchatDatabase));
    }
    
    
    sqlite3_close(snapchatDatabase);
    
    sqlite3_finalize(stmt);
    
    
    
    return success;
}

-(void)getAllTasksDOne:(NSString *)query
{
    self.firstNameArray=[[NSMutableArray alloc]init];
    
    self.lastNameArray=[[NSMutableArray alloc]init];
    
    self.userNamesArray=[[NSMutableArray alloc]init];

    
    
    //BOOL success=0;
    
    sqlite3_stmt *stmt;
    
    const char *cQuery=[query UTF8String];
    
    const char *dbpath=[[self getDatabasePath]UTF8String];
    
    if (sqlite3_open(dbpath,&snapchatDatabase)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(snapchatDatabase,cQuery,-1,&stmt,NULL)==SQLITE_OK)
        {
             while(sqlite3_step(stmt)==SQLITE_ROW)
             {
                unsigned const char *name=sqlite3_column_text(stmt,0);
                 NSString *finalresult=[NSString stringWithFormat:@"%s",name];
                 [self.firstNameArray addObject:finalresult];
                 
                 unsigned const char *lastname=sqlite3_column_text(stmt,1);
                 NSString *finallastname=[NSString stringWithFormat:@"%s",lastname];
                 [self.lastNameArray addObject:finallastname];
                 
                 unsigned const char *username=sqlite3_column_text(stmt,2);
                 NSString *finalusername=[NSString stringWithFormat:@"%s",username];
                 [self.lastNameArray addObject:finalusername];
             
            }
        }
        
        
        else
        {
            NSLog(@"%s in sqlite3_prepare_v2",sqlite3_errmsg(snapchatDatabase));
        }
            
            
    }
    else
    {
        NSLog(@"%s in sqlite3_open",sqlite3_errmsg(snapchatDatabase));
    }
    
    sqlite3_close(snapchatDatabase);
    
    sqlite3_finalize(stmt);
    
}

- (IBAction)signupbtnAction:(UIButton *)sender
{
    NSString *insertQuery=[NSString stringWithFormat:@"insert into snapchat(firstName,lastName,userName) values('%@','%@','%@')",self.firstNametextField.text,self.lastNameTextField.text,self.usernametextfield.text];
    
    BOOL success=[self executeQuery:insertQuery];
    
    if (success && self.firstNameArray.count>0)
    {
        NSString *selectData=@"select firtName,lastName,userName from snapchat";
        
        [self getAllTasksDOne:selectData];
        
    }
    
    NSLog(@"DONE");
    
    NSLog(@"first name inserted is  \n::: %@ \n  and last name inserted is\n :::%@ \n and username inserted is ::::%@",self.firstNametextField.text,self.lastNameTextField.text,self.usernametextfield.text);
    
    logInViewController *loginvc=[self.storyboard instantiateViewControllerWithIdentifier:@"logInViewController"];
    
    [self.navigationController pushViewController:loginvc animated:YES];
    
}






@end
