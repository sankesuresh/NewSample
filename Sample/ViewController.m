//
//  ViewController.m
//  Sample
//
//  Created by Agility Logistics on 11/09/13.
//  Copyright (c) 2013 Sukanya. All rights reserved.
//

#import "ViewController.h"
#import "Dataware.h"
#import "FileManager.h"
#import "Files.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    txtNo.frame=CGRectMake(90, 15, 200, 40);
    txtName.frame=CGRectMake(90, 70, 200, 40);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)SavingReferencesIntoDatabase
{
    Dataware *dbsql = [[Dataware alloc] initDataware];
	sqlite3_stmt *sqlStmt;
	NSString *sql=@"";
    NSInteger referenceId;
    NSString *myStr;
    myStr=[[NSString alloc] initWithFormat:@"Sanke"];
    sql=@"insert into MyTable(tid,tNo,tName)values(?,?,?)";
    NSInteger newid=[dbsql GetCode:"select max(MyTable.tid) from MyTable"];
    referenceId=newid;
    NSLog(@"Reference Id is=%d",referenceId);
    
    
    NSString *string = txtNo.text;
    int myNumber = [string intValue];
    
    
    sqlStmt=[dbsql OpenSQL:[sql UTF8String]];
	if(sqlStmt != nil)
	{
		sqlite3_bind_int(sqlStmt,1,referenceId);
        sqlite3_bind_int(sqlStmt,2,myNumber);
        sqlite3_bind_text(sqlStmt,3,[txtName.text UTF8String],-1, SQLITE_TRANSIENT);
	}
 	if(sqlite3_step(sqlStmt) == SQLITE_DONE)
    {
        sqlite3_reset(sqlStmt);
        [dbsql CloseSQL];
        
        //   return TRUE;
    }
    sqlite3_reset(sqlStmt);
    [dbsql CloseSQL];
    //  return TRUE;
    
}

-(IBAction)DeleteDuplicateFromDatabase
{
    Dataware *dbsql = [[Dataware alloc] initDataware];
	NSString *sql=@"";
    
    sql=@"delete from MyTable where tNo=?";
    
    sqlite3_stmt *sqlStmt;
	sqlStmt=[dbsql OpenSQL:[sql UTF8String]];
    
    NSString *string = txtNo.text;
    int myNumber = [string intValue];
    
	if(sqlStmt != nil)
	{
		sqlite3_bind_int(sqlStmt,1,myNumber);
		if(sqlite3_step(sqlStmt) == SQLITE_DONE)
		{
			sqlite3_reset(sqlStmt);
			[dbsql CloseSQL];
            //	return TRUE;
		}
		
	}
	sqlite3_reset(sqlStmt);
	[dbsql CloseSQL];
    //	return TRUE;
}


-(IBAction)UpdateDuplicateFromDatabase
{
    Dataware *dbsql = [[Dataware alloc] initDataware];
	NSString *sql=@"";
    
    sql=@"update  MyTable set tName=? where tNo=?";

    sqlite3_stmt *sqlStmt;
	sqlStmt=[dbsql OpenSQL:[sql UTF8String]];
    
    NSString *string = txtNo.text;
    int myNumber = [string intValue];

    
	if(sqlStmt != nil)
	{
        sqlite3_bind_text(sqlStmt,1,[txtName.text UTF8String],-1, SQLITE_TRANSIENT);
        sqlite3_bind_int(sqlStmt,2,myNumber);

		if(sqlite3_step(sqlStmt) == SQLITE_DONE)
		{
			sqlite3_reset(sqlStmt);
			[dbsql CloseSQL];
            //	return TRUE;
		}
		
	}
	sqlite3_reset(sqlStmt);
	[dbsql CloseSQL];
    //	return TRUE;
}



-(IBAction)selectFileManagerApp
{
    FileManager  *fileManager=[[FileManager alloc] init];
    [self.navigationController pushViewController:fileManager animated:YES];
}



@end
