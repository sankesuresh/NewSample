//
//  Dataware.m


#import "Dataware.h"

@implementation Dataware
@synthesize databaseName, databasePath;

- (id) initDataware
{
	databaseName = @"Quotation.sql";
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	[self checkAndCreateDatabase];
	//NSLog(databasePath);
	return self;
}

- (NSString *)applicationDocumentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(void) checkAndCreateDatabase
{
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];
	if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];	
}

- (sqlite3_stmt *) OpenSQL:(const char *)stmt
{
	sqlite3_stmt *compiledStatement=nil; 
	const char *sqlStatement = stmt;
	if(sqlite3_open([databasePath UTF8String], &dbsql) == SQLITE_OK)sqlite3_prepare_v2(dbsql, sqlStatement, -1, &compiledStatement, NULL);
	return compiledStatement;
}

- (NSInteger) GetInsertId
{
	return sqlite3_last_insert_rowid(dbsql);
}

- (BOOL) Execute:(const char *)stmt
{
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = stmt;
	if(sqlite3_open([databasePath UTF8String], &dbsql) == SQLITE_OK)
	{
	if (sqlite3_prepare_v2(dbsql, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
	{
		sqlite3_finalize(compiledStatement);
		return YES;
	}
	}
	else
	{
		NSLog(@"connection failure");
	}
	return NO;
}

- (NSInteger) GetCode:(const char *)stmt
{
	sqlite3_stmt *compiledStatement;
	const char *sqlStatement = stmt;
	NSInteger iCode=0;
	
	if(sqlite3_open([databasePath UTF8String], &dbsql) == SQLITE_OK)
	{
		sqlite3_prepare_v2(dbsql, sqlStatement, -1, &compiledStatement, NULL);
		if(compiledStatement != nil)		
		if(sqlite3_step(compiledStatement) == SQLITE_ROW) 
		iCode = sqlite3_column_int(compiledStatement, 0);
		sqlite3_finalize(compiledStatement);
	}
	return iCode+1;
}
	
- (void) CloseSQL
{
	sqlite3_close(dbsql);
}




@end