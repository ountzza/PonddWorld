//
//  PostTableViewController.h
//  WordPress
//
//  Created by Varut Aphimanchindakul on 12/6/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPReachability.h"
#import "WordPressAppDelegate.h"
#import "WPDataController.h"
#import "Blog.h"
#import "PostWebViewController.h"

@interface PostTableViewController : UITableViewController
{
    NSMutableArray *postItems;
    NSMutableArray *postItemsFull;
}

-(void)getArray:(NSMutableArray*)array andAll:(NSMutableArray*)array2;

@end
