//
//  PostWebViewController.m
//  WordPress
//
//  Created by Varut Aphimanchindakul on 12/6/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import "PostWebViewController.h"

@implementation PostWebViewController
@synthesize postWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)getArray:(NSMutableArray*)array andRow:(NSUInteger)row
{
    cat6 = array;
    Post *selectedPost = [cat6 objectAtIndex:row];
    NSLog(@"newPost = %@", selectedPost.content);
    NSString *contentString = [selectedPost.content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    [postWebView loadHTMLString:contentString baseURL:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
