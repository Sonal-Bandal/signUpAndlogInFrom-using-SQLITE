//
//  logInViewController.m
//  logInApplication
//
//  Created by Felix-ITS 004 on 05/03/18.
//  Copyright © 2018 sonal. All rights reserved.
//

#import "logInViewController.h"

@interface logInViewController ()

@end

@implementation logInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *getData=@"select firstName,lastName,userName from snapchat";
    
    [self getAllTasksDOne:getData];
    if (self.usernameArray.count>0) {
        self.usernameTextField.delegate=self;
        self.passwordTextField.delegate=self;
    
    }
    
    NSLog(@"%@",self.usernameArray);
    NSLog(@"%@",self.passwordArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTable
{
    NSString *createQuery=@"create table if not exists snapchatTable(userName text,password text)";
    
    BOOL success=[self executequery:createQuery];
    
    if (success)
    {
        NSLog(@"TABLE CREATED");
        
    }
}

-(NSString *)getDatabasePath
{
    NSArray *docArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docpath=[[docArray firstObject]stringByAppendingString:@"/snapchatTable.db"];
    
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

-(BOOL)executequery:(NSString *)query;
{
    BOOL success=0;
    
    sqlite3_stmt *stmt;
    
    const char *cQuery=[query UTF8String];
    
    const char *dbpath=[[self getDatabasePath]UTF8String];
    
    if (sqlite3_open(dbpath,&snapchatdatabase)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(snapchatdatabase,cQuery,-1,&stmt,NULL)==SQLITE_OK)
        {
            if (sqlite3_step(stmt)==SQLITE_DONE)
            {
                success=1;
                
                NSLog(@"done");
                
            }
            else
            {
                NSLog(@"%s in sqlite3_step ",sqlite3_errmsg(snapchatdatabase));
            }
        }
        else
        {
            NSLog(@"%s in sqlite3_prepare_v2",sqlite3_errmsg(snapchatdatabase));
        }
    }
    else
    {
        NSLog(@"%s in sqlite3_open",sqlite3_errmsg(snapchatdatabase));
    }
    
    
    sqlite3_close(snapchatdatabase);
    
    sqlite3_finalize(stmt);
    
    
    
    return success;
}

-(void)getAllTasksDOne:(NSString *)query
{
    
    self.usernameArray=[[NSMutableArray alloc]init];
    
    self.passwordArray=[[NSMutableArray alloc]init];
    
    sqlite3_stmt *stmt;
    
    const char *cQuery=[query UTF8String];
    
    const char *dbpath=[[self getDatabasePath]UTF8String];
    
    if (sqlite3_open(dbpath,&snapchatdatabase)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(snapchatdatabase,cQuery,-1,&stmt,NULL)==SQLITE_OK)
        {
            while(sqlite3_step(stmt)==SQLITE_ROW)
            {
                unsigned const char *username=sqlite3_column_text(stmt,0);
                NSString *finalusername=[NSString stringWithFormat:@"%s",username];
                [self.usernameArray addObject:finalusername];
                
                unsigned const char *pwd=sqlite3_column_text(stmt,1);
                NSString *finalpassword=[NSString stringWithFormat:@"%s",pwd];
                [self.passwordArray addObject:finalpassword];
                
                
            }
        }
        
        
        else
        {
            NSLog(@"%s in sqlite3_prepare_v2",sqlite3_errmsg(snapchatdatabase));
        }
        
        
    }
    else
    {
        NSLog(@"%s in sqlite3_open",sqlite3_errmsg(snapchatdatabase));
    }
    
    sqlite3_close(snapchatdatabase);
    
    sqlite3_finalize(stmt);
    
}



- (IBAction)logInAction:(UIButton *)sender
{
    
    NSString *insertQuery=[NSString stringWithFormat:@"insert into snapchat(userNsme,password)values('%@','%@')",self.usernameTextField.text,self.passwordTextField.text];
    
    BOOL success=[self executequery:insertQuery];
    
    if (success && self.usernameArray.count>0) {
        NSString *selectdata=@"select userName,password from snapchat";
        
        [self getAllTasksDOne:selectdata];
        
        
    }
    
    NSLog(@"username inserted is ::%@ \n and password inserted is ::%@ \n",self.usernameTextField.text,self.passwordTextField.text);
    
    NSLog(@"LOGGED IN SUCCESSFULLY");
    
}
@end
