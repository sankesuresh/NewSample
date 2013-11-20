//
//  Files.m
//  Sample
//
//  Created by Agility Logistics on 20/09/13.
//  Copyright (c) 2013 Sukanya. All rights reserved.
//

#import "Files.h"

@interface Files ()

@end

@implementation Files
@synthesize imageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    arr_Files=[[NSMutableArray alloc] init];
    filePath=[[NSString alloc] init];
    NSLog(@"My Array is=%@",arr_Files);

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"Msword"];
    NSLog(@"My Path is=%@",filePath);

    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:filePath ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:htmlString baseURL:nil];
    
    imageView.frame=CGRectMake(0, 0, 320, 460);
    [myWebView addSubview:imageView];
  }

-(void)downloadingData
{
    NSString *stringURL = @"http://www.somewhere.com/thefile.png";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath1 = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"Mspower.ppt"];
        [urlData writeToFile:filePath1 atomically:YES];
    }
}


-(NSArray *)listFileAtPath:(NSString *)path
{
    NSLog(@"LISTING ALL FILES FOUND");
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        [arr_Files addObject:[directoryContent objectAtIndex:count]];
    }
    return directoryContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
