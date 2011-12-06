//
//  TabloidWelcomePageVC.h
//  WordPress
//
//  Created by Varut Aphimanchindakul on 11/22/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordPressAppDelegate.h"
#import "WPDataController.h"
#import "Blog.h"
#import "AddSiteViewController.h"
#import "BlogsViewController.h"
#import "WPReachability.h"

@protocol TabloidWelcomePageDelegate 
@optional 
-(void)isConnectedToTabloid:(NSInteger)yesNo;
-(void)countryWithPost:(NSString*)country numberOfPost:(NSInteger)count;
-(void)fetchingDone;
@end 


@interface TabloidWelcomePageVC : UIViewController <ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    Blog *blog;
    NSArray *subsites;
    IBOutlet UITableView* table1;
    IBOutlet UITableView* table2;
    IBOutlet UITableView* table3;
    IBOutlet UITableView* table4;
    IBOutlet UIWebView *postWebView;
    id<TabloidWelcomePageDelegate>delegate;
}
- (void)checkURL;

@property (nonatomic, retain) Blog *blog;
@property (nonatomic, retain) NSString *password, *username, *url;
@property (nonatomic, retain) UITableView* table1;
@property (nonatomic, retain) UITableView* table2;
@property (nonatomic, retain) UITableView* table3;
@property (nonatomic, retain) UITableView* table4;
@property (nonatomic, retain) IBOutlet UIWebView *postWebView;
@property (nonatomic, assign) id<TabloidWelcomePageDelegate>delegate;

-(void)connectToTabloid;

@end
