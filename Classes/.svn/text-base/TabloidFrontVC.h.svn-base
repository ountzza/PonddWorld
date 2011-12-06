//
//  TabloidFrontVC.h
//  WordPress
//
//  Created by Varut Aphimanchindakul on 11/28/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabloidWelcomePageVC.h"
#import "NSURL+IDN.h"
#import "WordPressAppDelegate.h"
#import "WPDataController.h"
#import "Blog.h"
#import "AddSiteViewController.h"
#import "BlogsViewController.h"
#import "WPReachability.h"

@class TabloidWelcomePageVC;
@interface TabloidFrontVC : UIViewController <ASIHTTPRequestDelegate,UIScrollViewDelegate,UIPopoverControllerDelegate>
{
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIScrollView *layer1;
    IBOutlet UIScrollView *layer2;
    IBOutlet UIScrollView *layer3;
    NSTimer *timer;
    IBOutlet UIView *loadingScreen;
    IBOutlet UILabel *loadingScreenLabel;
    Blog *blog;
    NSArray *subsites;
    UIPopoverController *popoverController;
    

}

@property (nonatomic, retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *layer1;
@property (nonatomic, retain) IBOutlet UIScrollView *layer2;
@property (nonatomic, retain) IBOutlet UIScrollView *layer3;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) IBOutlet UIView *loadingScreen;
@property (nonatomic, retain) IBOutlet UILabel *loadingScreenLabel;
@property (nonatomic, retain) Blog *blog;
@property (nonatomic, retain) NSString *password, *username, *url;
@property (nonatomic, retain) UIPopoverController *popoverController; 


-(IBAction)goToMainPage:(id)sender;
-(void)isConnectedToTabloid:(NSInteger)yesNo;
-(void)countryWithPost:(NSString*)country numberOfPost:(NSInteger)count;
-(void)fetchingDone;
-(void)connectToTabloid;
@end
