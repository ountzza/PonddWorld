//
//  TabloidWelcomePageVC.m
//  WordPress
//
//  Created by Varut Aphimanchindakul on 11/22/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import "TabloidWelcomePageVC.h"
#import "NSURL+IDN.h"

@implementation TabloidWelcomePageVC
@synthesize blog;
@synthesize password, username, url;
@synthesize table1,table2,table3,table4;
@synthesize postWebView;
@synthesize delegate;

NSMutableArray *cat1,*cat2,*cat3,*cat4,*cat5,*cat6,*cat7,*cat8;
NSArray *allCatArray2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {

        return [cat1 count];
    }
    if (tableView.tag==2) {
        return [cat3 count];
    }
    if (tableView.tag==3){
        return [cat5 count];
    }
else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (tableView.tag==1) {
        cell.textLabel.text = [cat1 objectAtIndex:indexPath.row];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if (tableView.tag==2) {
        cell.textLabel.text = [cat3 objectAtIndex:indexPath.row];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if(tableView.tag==3){
        cell.textLabel.text = [cat5 objectAtIndex:indexPath.row];
    }
    //cell.textLabel.text = @"xxx xxx";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WordPressAppDelegate *appDelegate = [WordPressAppDelegate sharedWordPressApp];
    NSFetchRequest *requestFetch2 = [[NSFetchRequest alloc] init];
	requestFetch2.entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error22 = nil;
	allCatArray2 = [appDelegate.managedObjectContext executeFetchRequest:requestFetch2 error:&error22];
	[requestFetch2 release];
    /////////////////////////////////////////////////////////////////////////
    if (tableView.tag==1) {
        [cat3 removeAllObjects];
        [cat4 removeAllObjects];
        Category*selectedCat = [cat2 objectAtIndex:indexPath.row];
        for (Post *newPost in allCatArray2) {
            for (Category *newCat in newPost.categories){
                if (([newCat.parentID intValue]==[selectedCat.categoryID intValue]) && (![cat3 containsObject:newCat.categoryName])){
                    [cat3 addObject:newCat.categoryName];
                    [cat4 addObject:newCat];
                }
                 
            }   
        }
        [table2 reloadData];
        table2.alpha=1;
    }
    /////////////////////////////////////////////////////////////////////////
    if (tableView.tag==2) {
        [cat5 removeAllObjects];
        [cat6 removeAllObjects];
 
        Category*selectedCat = [cat4 objectAtIndex:indexPath.row];
        NSLog(@"%s selectedCat = %@",__FUNCTION__,selectedCat.categoryName);
         NSLog(@"%s cat4 count = %d",__FUNCTION__,[cat4 count]);
        for (Post *newPost in allCatArray2) {
            
        //    NSSet *allCatInPost = newPost.categories;
            if ([newPost.categories containsObject:selectedCat]) {
                NSLog(@"%s newPost.postTitle = %@",__FUNCTION__,newPost.postTitle);
                [cat5 addObject:newPost.postTitle];
                [cat6 addObject:newPost];
            }
            
        }
        [selectedCat release];
        [table3 reloadData];
        table3.alpha=1;
    }
    /////////////////////////////////////////////////////////////////////////
    if(tableView.tag==3){
        Post *selectedPost = [cat6 objectAtIndex:indexPath.row];
        NSLog(@"newPost = %@", selectedPost.content);
        NSString *contentString = [selectedPost.content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];

        [postWebView loadHTMLString:contentString baseURL:nil];
    }
}


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
                [delegate countryWithPost:newCat.categoryName numberOfPost:[newCat.posts count]];
                [cat1 addObject:newCat.categoryName];
                [cat2 addObject:newCat];
            }
        }
    } 
    [table1 reloadData];
    [delegate fetchingDone];
    
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
    [delegate isConnectedToTabloid:1];
    [self readInfo];
}

- (void)validationDidFail:(id)wrong {
    [delegate isConnectedToTabloid:0];
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //    if (blog) {
    //        NSError *error = nil;
    //        self.url = blog.url;
    //        self.username = blog.username;
    //        self.password = [SFHFKeychainUtils getPasswordForUsername:blog.username andServiceName:blog.hostURL error:&error];
    //    }
    [self connectToTabloid];
    
    
    
    
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
    if(interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return NO;
	return YES;
}

@end
