//
//  Files.h
//  Sample
//
//  Created by Agility Logistics on 20/09/13.
//  Copyright (c) 2013 Sukanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Files : UIViewController
{
    IBOutlet UIImageView *img_1,*img_2,*img_3,*img_4,*img_5,*img_6,*imageView;
    IBOutlet UILabel *lbl_1,*lbl_2,*lbl_3,*lbl_4,*lbl_5,*lbl_6;
    NSMutableArray *arr_Files;
    IBOutlet UIWebView *myWebView;
    NSString  *filePath;
}

@property (strong, nonatomic) UIImageView *imageView;


@end
