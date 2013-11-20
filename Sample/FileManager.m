//
//  FileManager.m
//  Sample
//
//  Created by Agility Logistics on 18/09/13.
//  Copyright (c) 2013 Sukanya. All rights reserved.
//

#import "FileManager.h"
#import "Files.h"

@interface FileManager ()

@end

@implementation FileManager

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
    
        
    arr_List=[[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory ;
      for(int i=0;i<[paths count];i++)
      {
         documentsDirectory= [paths objectAtIndex:i];
          NSLog(@"Path is=%@", documentsDirectory);
      }
    
    NSArray *directoryContent = [[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory];
    
    NSString *str;
    str=[[NSString alloc] init];
    for(int i=0;i<[directoryContent count];i++)
    {
        str= [directoryContent objectAtIndex:i];
        [arr_List addObject:str];
        NSLog(@"Name is=%@", str);
    }
    
    [myTable  reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr_List count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] ;
    
  
    cell.textLabel.frame=CGRectMake(40, 6, 260, 36);
    cell.textLabel.numberOfLines=0;
    cell.textLabel.backgroundColor=[UIColor whiteColor];
     cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    cell.textLabel.textAlignment=UITextAlignmentLeft;
    cell.textLabel.text=[arr_List objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
	cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    if([cell.textLabel.text rangeOfString:@"pdf"].location!=NSNotFound)
    {
        cell.imageView.image=[UIImage imageNamed:@"pdf.png"];
    }
    else if([cell.textLabel.text rangeOfString:@"doc"].location!=NSNotFound)
    {
        cell.imageView.image=[UIImage imageNamed:@"msword.png"];
    }
    else if([cell.textLabel.text rangeOfString:@"ppt"].location!=NSNotFound)
    {
        cell.imageView.image=[UIImage imageNamed:@"powerpoint.png"];
    }
    else if([cell.textLabel.text rangeOfString:@"png"].location!=NSNotFound)
    {
        cell.imageView.image=[UIImage imageNamed:@"pictures.png"];
    }
    else if([cell.textLabel.text rangeOfString:@"mp3"].location!=NSNotFound)
    {
        cell.imageView.image=[UIImage imageNamed:@"music.png"];
    }
    else 
    {
        cell.imageView.image=[UIImage imageNamed:@"white.png"];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Files *files=[[Files alloc] init];
    files.imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pictures.png"]];
    [self.navigationController pushViewController:files animated:YES];
}
@end
