//
//  TabloidFrontVC.m
//  WordPress
//
//  Created by Varut Aphimanchindakul on 11/28/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import "TabloidFrontVC.h"
#import "CustomBadge.h"
#import "DepartmentViewController.h"


@implementation TabloidFrontVC
@synthesize mainScrollView,layer1,layer2, layer3, timer, loadingScreen, loadingScreenLabel,popoverController;
@synthesize blog;
@synthesize password, username, url;
int scrollMeInt, waitTime;
NSArray *flagArrays;
NSMutableArray *cat1,*cat2,*cat3,*cat4,*cat5,*cat6,*cat7,*cat8;
NSArray *allCatArray2;

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
-(IBAction)goToMainPage:(id)sender
{
    TabloidWelcomePageVC *myTabloidWelcomePageVC = [[TabloidWelcomePageVC alloc] initWithNibName:@"TabloidWelcomePageVC" bundle:nil];
    [self.view addSubview:myTabloidWelcomePageVC.view];
}

#pragma mark - ScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"stoppo");
    //UIButton *myButton = (UIButton*)[self.view viewWithTag:112];
    //NSLog(@"myButton.frame = %f", myButton.frame.origin.x);
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"stoppo2");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f,%f,%f,%f",self.mainScrollView.contentOffset.x,layer1.contentOffset.x,layer2.contentOffset.x, layer3.contentOffset.x);
//    if(self.layer1.contentOffset.x >= 3715)
//    {
//        //[mainScrollView scrollRectToVisible:CGRectMake(84, 0, 1024, 704) animated:NO];
////        layer1.contentOffset = CGPointMake(84, 0);
//        [layer1 scrollRectToVisible:CGRectMake(84, 0, 1024, 704) animated:NO];
//    }
//    else if(self.mainScrollView.contentOffset.x <= 20)
//    {
//        //layer1.contentOffset = CGPointMake(3650, 0);
//        [layer1 scrollRectToVisible:CGRectMake(3650, 0, 1024, 704) animated:NO];
//    }
    
    if(mainScrollView.contentOffset.x <= 55)
    {
        [mainScrollView scrollRectToVisible:CGRectMake(4999, 0, 1024, 704) animated:NO];
        //[layer1 scrollRectToVisible:CGRectMake(3650, 0, 1024, 704) animated:NO];

    }
    else if(mainScrollView.contentOffset.x >= 5000)
    {
        [mainScrollView scrollRectToVisible:CGRectMake(56, 0, 1024, 704) animated:NO];
        //[layer1 scrollRectToVisible:CGRectMake(136, 0, 1024, 704) animated:NO];

    }
        [layer1 scrollRectToVisible:CGRectMake(mainScrollView.contentOffset.x, 0, 1024, 704) animated:NO];
        layer2.contentOffset = CGPointMake(layer1.contentOffset.x/1.5, 0);
        layer3.contentOffset = CGPointMake(layer2.contentOffset.x/2, 0);
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    NSLog(@"stop");
//    [timer invalidate];
//    timer = nil;
//    waitTime = 0;
//}

- (void) autoScroll {
    
    // Updates the variable h, adding 100 (put your own value here!)
    
    scrollMeInt += 1;
    //layer1.contentOffset = CGPointMake(300, 0);  
    //[mainScrollView scrollRectToVisible:CGR animated:<#(BOOL)#>]
    //mainScrollView.contentOffset = CGPointMake(mainScrollView.contentOffset.x+1, 0);

    [mainScrollView setContentOffset:CGPointMake(mainScrollView.contentOffset.x+1, 0) animated:YES];
    //[mainScrollView scrollRectToVisible:CGRectMake(mainScrollView.contentOffset.x+1, 0, 1024, 704) animated:YES];
    
    //if(scrollMeInt == 100)
        
}

-(void)restart
{
    waitTime+=1;
    if(waitTime == 3 && !timer)
        timer = [NSTimer scheduledTimerWithTimeInterval:0.0025 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
}

-(void)imageClick:(id)sender{
	UIButton *clickedButton = (UIButton*)sender;
    NSLog(@"clickedButton tag = %d", clickedButton.tag);
    [mainScrollView scrollRectToVisible:CGRectMake(clickedButton.frame.origin.x-20, mainScrollView.contentOffset.y, mainScrollView.frame.size.width, mainScrollView.frame.size.height) animated:YES];
    NSString *countryString = [flagArrays objectAtIndex:(clickedButton.tag-101)];
    NSUInteger countryIndex = [cat1 indexOfObject:countryString];
    NSLog(@"countryIndex = %d and count = %d", countryIndex, [cat1 count]);
    
    WordPressAppDelegate *appDelegate = [WordPressAppDelegate sharedWordPressApp];
    NSFetchRequest *requestFetch2 = [[NSFetchRequest alloc] init];
	requestFetch2.entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error22 = nil;
	allCatArray2 = [appDelegate.managedObjectContext executeFetchRequest:requestFetch2 error:&error22];
	[requestFetch2 release];
    /////////////////////////////////////////////////////////////////////////
    [cat3 removeAllObjects];
    [cat4 removeAllObjects];
    Category*selectedCat = [cat2 objectAtIndex:countryIndex];
    for (Post *newPost in allCatArray2) {
        for (Category *newCat in newPost.categories){
            if (([newCat.parentID intValue]==[selectedCat.categoryID intValue]) && (![cat3 containsObject:newCat.categoryName])){
                [cat3 addObject:newCat.categoryName];
                [cat4 addObject:newCat];
            }
        }   
    }

    
    if (self.popoverController == nil) {
        DepartmentViewController *departmentVC = 
        [[DepartmentViewController alloc]      
         initWithNibName:@"DepartmentViewController" 
         bundle:[NSBundle mainBundle]]; 
        departmentVC.navigationItem.title = @"Departments";
        departmentVC.contentSizeForViewInPopover = CGSizeMake(300, 500);
        UINavigationController *navController = 
        [[UINavigationController alloc] 
         initWithRootViewController:departmentVC];
        
        UIPopoverController *popover = 
        [[UIPopoverController alloc] 
         initWithContentViewController:navController]; 
        
        popover.delegate = self;
        [departmentVC getArray:cat3 andAll:cat4];

        [departmentVC release];
        [navController release];
        
        self.popoverController = popover;
        
        [popover release];
    }
    
//    [self.popoverController 
//     presentPopoverFromBarButtonItem:clickedButton                                    
//     permittedArrowDirections:UIPopoverArrowDirectionAny 
//     animated:YES];
//    
    
    
    [self.popoverController presentPopoverFromRect:CGRectMake(20, clickedButton.frame.origin.y, 300, 190) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
//    TabloidWelcomePageVC *tabloidWelcomePage = [[TabloidWelcomePageVC alloc] initWithNibName:@"TabloidWelcomePageVC" bundle:nil];
//    tabloidWelcomePage.delegate = self;
//    [tabloidWelcomePage connectToTabloid];
//    
    [self connectToTabloid];
    
    flagArrays = [[NSArray alloc] initWithObjects:@"Australia",@"Austria",@"Belgium",@"Brazil",@"Canada",@"China",@"Czech",@"France",@"German",@"Greece",@"Hungary",@"Thailand",@"India",@"Ireland",@"Italy",@"Japan",@"Mexico",@"Netherlands",@"Poland",@"Portugal",@"Romania",@"Russia",@"Singapore",@"Slovak",@"Spain",@"Switzerland",@"Thailand",@"Turkey",@"UK",@"USA", nil];
    
    int count = 0;
    int layer = 1;
    int localCount = 0;
    //layer1.frame = CGRectMake(0, 0, 6000, 704);
//    layer2.frame = CGRectMake(0, 0, 6000, 704);
//    layer3.frame = CGRectMake(0, 0, 6000, 704);
    [layer1 setContentSize:CGSizeMake(20000, 704)];
    [layer2 setContentSize:CGSizeMake(20000, 704)];
    [layer3 setContentSize:CGSizeMake(20000, 704)];
    
    localCount = 0;
    for(NSString*flagString in flagArrays)
    {
        //layer1 = 15
        //layer2 = 10
        //layer3 = 5
        count++;
        if(count == 16)
        {
            layer = 2;
            localCount = 0;
        }
        if(count == 26)
        {
            layer = 3;
            localCount = 0;
        }
        
        if(layer == 1)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 400, 300, 190);
            
            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            
            [layer1 addSubview:myImage];
            [layer1 addSubview:myOverLayImage];
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];	
            button1.tag = count+100;
            
            //[mainScrollView addSubview:button1];

        }
        if(layer == 2)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 250, 300*0.85, 190*0.85);
            

            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            
            [layer2 addSubview:myImage];
            [layer2 addSubview:myOverLayImage];
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];			
            button1.tag = count+100;
            
           //[layer2 addSubview:button1];
            
        }
        if(layer == 3)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 120, 300*0.7, 190*0.7);
            
            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            
            [layer3 addSubview:myImage];
            [layer3 addSubview:myOverLayImage];   
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];			
            button1.tag = count+100;
            
            //[layer3 addSubview:button1];
        }
        
        localCount++;
        
    }
    
    count = 0;
    localCount = 15;
    layer = 1;
    for(NSString*flagString in flagArrays)
    {
        //layer1 = 15
        //layer2 = 10
        //layer3 = 5
        count++;
        
        if(count == 16)
        {
            layer = 2;
            localCount = 10;
        }
        if(count == 26)
        {
            layer = 3;
            localCount = 5;
        }
        
        if(layer == 1)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 400, 300, 190);
            
            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            if([flagString isEqualToString:@"Thailand"])
                NSLog(@"Thai count = %d", count);
            
            [layer1 addSubview:myImage];
            [layer1 addSubview:myOverLayImage];
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];			
            button1.tag = count+100;
            
            //[mainScrollView addSubview:button1];
            
        }
        if(layer == 2)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 250, 300*0.85, 190*0.85);
            
            
            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            if([flagString isEqualToString:@"Japan"])
                NSLog(@"Japan count = %d", count);
            
            [layer2 addSubview:myImage];
            [layer2 addSubview:myOverLayImage];
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];			
            button1.tag = count+100;
            
            //[layer2 addSubview:button1];
            
        }
        if(layer == 3)
        {
            NSString *myFlagName = [[NSString alloc] initWithFormat:@"%@.png",flagString];
            UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:myFlagName]];
            myImage.frame = CGRectMake(20+(330*localCount), 120, 300*0.7, 190*0.7);
            
            UIImageView *myOverLayImage = [[UIImageView alloc] initWithFrame:myImage.frame];
            myOverLayImage.backgroundColor = [UIColor whiteColor];
            myOverLayImage.alpha = 0.5;
            myOverLayImage.tag = count;
            
            [layer3 addSubview:myImage];
            [layer3 addSubview:myOverLayImage];    
            
            UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
            //[button1 setBackgroundColor:[UIColor redColor]];
            [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];			
            button1.tag = count+100;
            
            //[layer3 addSubview:button1];
        }
        
        localCount++;
        
    }

    
    
}

- (void)viewDidUnload
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewWillAppear:animated];
    
    [mainScrollView setContentSize:CGSizeMake(20000, 704)];
    [mainScrollView scrollRectToVisible:CGRectMake(1787, 0, 1024, 704) animated:NO];
    layer1.contentOffset = CGPointMake(mainScrollView.contentOffset.x, 0);
    layer2.contentOffset = CGPointMake(layer1.contentOffset.x/1.5, 0);
    layer3.contentOffset = CGPointMake(layer2.contentOffset.x/2, 0);

    mainScrollView.delegate = self;
    scrollMeInt = 0;
    waitTime = 0;
    //timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(restart) userInfo:nil repeats:YES];
    
    
//    UIImageView *myImageView = (UIImageView *)[self.view viewWithTag:1];
//    myImageView.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        return NO;
	return YES;
}

#pragma mark - Connect To Tabloid [From TabloidWelcomePageVC

-(void)connectToTabloid
{
    NSLog(@"%s", __FUNCTION__);
    allCatArray2 = [[NSArray alloc] init];
    cat1 = [[NSMutableArray alloc] init];
    cat2 = [[NSMutableArray alloc] init];
    cat3 = [[NSMutableArray alloc] init];
    cat4 = [[NSMutableArray alloc] init];
    cat5 = [[NSMutableArray alloc] init];
    cat6 = [[NSMutableArray alloc] init];
    cat7 = [[NSMutableArray alloc] init];
    cat8 = [[NSMutableArray alloc] init];
    
    self.url = [NSURL IDNEncodedHostname:@"http://172.30.155.140/wordpress/"];
    NSLog(@"blog url: %@", self.url);
    self.username = @"iTabloid";
    self.password = @"varut5401";
    // [self checkURL];
    [self performSelectorInBackground:@selector(checkURL) withObject:nil];
}

- (void)checkURL {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *urlToValidate = @"http://172.30.155.140/wordpress/";    
	
    if(![urlToValidate hasPrefix:@"http"])
        urlToValidate = [NSString stringWithFormat:@"http://%@", url];
	
    urlToValidate = [urlToValidate stringByReplacingOccurrencesOfRegex:@"/wp-login.php$" withString:@""];
    urlToValidate = [urlToValidate stringByReplacingOccurrencesOfRegex:@"/wp-admin/?$" withString:@""]; 
    urlToValidate = [urlToValidate stringByReplacingOccurrencesOfRegex:@"/?$" withString:@""]; 
	
    [FileLogger log:@"%@ %@ %@", self, NSStringFromSelector(_cmd), urlToValidate];
	ASIHTTPRequest *xmlrpcRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlToValidate]];
	[xmlrpcRequest setValidatesSecureCertificate:NO]; 
	[xmlrpcRequest setShouldPresentCredentialsBeforeChallenge:NO];
	[xmlrpcRequest setShouldPresentAuthenticationDialog:YES];
	[xmlrpcRequest setUseKeychainPersistence:YES];
	[xmlrpcRequest setNumberOfTimesToRetryOnTimeout:2];
	[xmlrpcRequest setDidFinishSelector:@selector(remoteValidate:)];
	[xmlrpcRequest setDidFailSelector:@selector(checkURLWentWrong:)];
	[xmlrpcRequest setDelegate:self];
    WordPressAppDelegate *appDelegate = (WordPressAppDelegate *)[[UIApplication sharedApplication] delegate];
	[xmlrpcRequest addRequestHeader:@"User-Agent" value:[appDelegate applicationUserAgent]];
    [xmlrpcRequest addRequestHeader:@"Accept" value:@"*/*"];
    [xmlrpcRequest startAsynchronous];
	[xmlrpcRequest release];
  	[pool release];   
    NSLog(@"%s",__FUNCTION__);
}


- (void)remoteValidate:(ASIHTTPRequest *)xmlrpcRequest
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	WPDataController *dc = [[WPDataController alloc] init];
    
    NSLog(@"%s before guess",__FUNCTION__);
    NSLog(@"%s self.url= %@",__FUNCTION__,self.url);
    NSString *xmlrpc = [dc guessXMLRPCForUrl:self.url];
    WPLog(@"after guess");
    [subsites release]; subsites = nil;
    NSLog(@"%s self.url= %@",__FUNCTION__,self.url);
    if (xmlrpc != nil) {
        subsites = [[dc getBlogsForUrl:xmlrpc username:self.username password:self.password] retain];
        if (subsites != nil) {
            [self performSelectorOnMainThread:@selector(validationSuccess:) withObject:xmlrpc waitUntilDone:YES];
        } else {
            [self performSelectorOnMainThread:@selector(validationDidFail:) withObject:dc.error waitUntilDone:YES];
        }
    } else {
        [self performSelectorOnMainThread:@selector(validationDidFail:) withObject:dc.error waitUntilDone:YES];
    }
	
	[dc release];
	[pool release];  
}

- (void)checkURLWentWrong:(ASIHTTPRequest *)request {
	NSError *error = [request error];
	[FileLogger log:@"%@ %@ %@", self, NSStringFromSelector(_cmd), error];
	[self performSelectorOnMainThread:@selector(validationDidFail:) withObject:error waitUntilDone:YES];
}


-(void)readInfo{
    WordPressAppDelegate *appDelegate = [WordPressAppDelegate sharedWordPressApp];
    NSArray *catArray = [[NSArray alloc] init];
	NSFetchRequest *requestFetch = [[NSFetchRequest alloc] init];
	requestFetch.entity = [NSEntityDescription entityForName:@"Blog" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error2 = nil;
	catArray = [appDelegate.managedObjectContext executeFetchRequest:requestFetch error:&error2];
	[requestFetch release];
    
    Blog *myBlog = [catArray lastObject];
    
    [WPReachability sharedReachability].hostName = myBlog.hostURL;
    
    [appDelegate setCurrentBlog:myBlog];
    
    NSLog(@"%s Blog *myBlog = %@",__FUNCTION__,myBlog.blogName);
    
    PostsViewController *myPostsViewController = [[PostsViewController alloc] init];
    [myPostsViewController setBlog:myBlog];
    [myPostsViewController syncPosts];
    
    
	NSFetchRequest *requestFetch2 = [[NSFetchRequest alloc] init];
	requestFetch2.entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error22 = nil;
	allCatArray2 = [appDelegate.managedObjectContext executeFetchRequest:requestFetch2 error:&error22];
	[requestFetch2 release];
    [cat1 removeAllObjects];
    [cat2 removeAllObjects];
    
    for (Post *newPost in allCatArray2) {
        for (Category *newCat in newPost.categories){
            if (([newCat.parentID intValue]==0) && (![cat1 containsObject:newCat.categoryName])){
                [self countryWithPost:newCat.categoryName numberOfPost:[newCat.posts count]];
                [cat1 addObject:newCat.categoryName];
                [cat2 addObject:newCat];
            }
        }
    } 
    [self fetchingDone];
    
}
- (void)validationSuccess:(NSString *)xmlrpc {
    WordPressAppDelegate *appDelegate = [WordPressAppDelegate sharedWordPressApp];
    NSLog(@"hasSubsites: %@", subsites);
    
    if (subsites) {
        NSMutableDictionary *newBlog = [NSMutableDictionary dictionaryWithDictionary:[subsites objectAtIndex:0]];
        [newBlog setObject:self.username forKey:@"username"];
        [newBlog setObject:self.password forKey:@"password"];
        [newBlog setObject:xmlrpc forKey:@"xmlrpc"];
        
        self.blog = [Blog createFromDictionary:newBlog withContext:appDelegate.managedObjectContext];
        [self.blog dataSave];
        NSLog(@"%s subsites",__FUNCTION__);
    }
    [self isConnectedToTabloid:1];
    [self readInfo];
}

- (void)validationDidFail:(id)wrong {
    [self isConnectedToTabloid:0];
    [self readInfo];
    if (wrong) {
        if ([wrong isKindOfClass:[UITableViewCell class]]) {
            ((UITableViewCell *)wrong).textLabel.textColor = WRONG_FIELD_COLOR;
        } else if ([wrong isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)wrong;
			NSString *message;
			if ([error code] == 403) {
				message = NSLocalizedString(@"Please update your credentials and try again.", @"");
			} else {
				message = [error localizedDescription];
			}
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry, can't log in", @"")
																message:message
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"Need Help?", @"")
                                                      otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
            [alertView show];
            [alertView release];            
        }
        
    }    
    
	[self.navigationItem setHidesBackButton:NO animated:NO];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
	switch(buttonIndex) {
		case 0: {
			HelpViewController *helpViewController = [[HelpViewController alloc] init];
			WordPressAppDelegate *appDelegate = (WordPressAppDelegate *)[[UIApplication sharedApplication] delegate];
			
			if (DeviceIsPad()) {
				helpViewController.isBlogSetup = YES;
				[self.navigationController pushViewController:helpViewController animated:YES];
			}
			else
				[appDelegate.navigationController presentModalViewController:helpViewController animated:YES];
			
			[helpViewController release];
			break;
		}
		case 1:
			//ok
			break;
		default:
			break;
	}
}


#pragma mark - TabloidWelcomePage Delegate

-(void)isConnectedToTabloid:(NSInteger)yesNo
{
    NSLog(@"yesNo = %d", yesNo);
    if(yesNo == 1)
        loadingScreenLabel.text = @"Fetching posts...";
    else
        loadingScreenLabel.text = @"Failed to connect to Tabloid";
}

-(void)countryWithPost:(NSString*)country numberOfPost:(NSInteger)count
{
    //NSLog(@"country = %@", country);
    //[cat1 addObject:country];
    NSUInteger indexArray = [flagArrays indexOfObject:country];
    indexArray++;
    NSLog(@"indexArray = %d", indexArray);
    UIImageView *myImage = (UIImageView *)[self.view viewWithTag:indexArray];
    myImage.alpha = 0;
    
    loadingScreenLabel.text = [[NSString alloc] initWithFormat:@"Fetching posts...%@", country];
    
    if(count > 0)
    {
        NSString *countString = [[NSString alloc] initWithFormat:@"%d", count];
        CustomBadge *customBadge1 = [CustomBadge customBadgeWithString:countString
                                                       withStringColor:[UIColor whiteColor] 
                                                        withInsetColor:[UIColor redColor] 
                                                        withBadgeFrame:YES 
                                                   withBadgeFrameColor:[UIColor whiteColor] 
                                                             withScale:1.0
                                                           withShining:YES];
        CGFloat myPosition = myImage.frame.origin.x + myImage.frame.size.width - 30;
        [customBadge1 setFrame:CGRectMake(myPosition,myImage.frame.origin.y-30, 60,60)];
        UIGraphicsBeginImageContextWithOptions((customBadge1.frame.size), FALSE, [[UIScreen mainScreen] scale]);
        [customBadge1.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *badgeAsImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *imageView = [[UIImageView alloc] initWithImage:badgeAsImage];
        imageView.frame = CGRectMake(customBadge1.frame.origin.x,customBadge1.frame.origin.y,customBadge1.frame.size.width, customBadge1.frame.size.height);
        
        if(indexArray > 0 && indexArray < 16)
            [layer1 addSubview:imageView];
        if(indexArray >=16 && indexArray <26)
            [layer2 addSubview:imageView];
        if(indexArray >=26)
            [layer3 addSubview:imageView];
    }
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:myImage.frame];
    //[button1 setBackgroundColor:[UIColor redColor]];
    [button1 addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];	
    button1.tag = indexArray+100;
    [mainScrollView addSubview:button1];

}

-(void)fetchingDone
{
    loadingScreenLabel.text = @"Done!";
    NSTimer *myTimer;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(removeLoadingScreen) userInfo:nil repeats:NO];
}
  
-(void)removeLoadingScreen
{  
    loadingScreen.hidden = YES;
}

@end
