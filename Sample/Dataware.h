//
//  Dataware.h


#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Dataware : NSObject 
{
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *dbsql;
}

@property (nonatomic, retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;

-(id)initDataware;
-(sqlite3_stmt *)OpenSQL:(const char *)stmt;
- (void)CloseSQL;
-(void) checkAndCreateDatabase;

- (NSInteger) GetCode:(const char *)stmt;
- (sqlite3_stmt *) OpenSQL:(const char *)stmt;
@end
