//
//  TabloidCountryViewController.h
//  WordPress
//
//  Created by Varut Aphimanchindakul on 11/24/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"
#import "Category.h"
@interface TabloidCountryViewController : UITableViewController
{
    NSMutableArray *countryList;
    Blog* myBlog;
}
@property (nonatomic, retain) Blog *myBlog;
- (void)blogsRefreshNotificationReceived:(NSNotification *)notification;

@end
