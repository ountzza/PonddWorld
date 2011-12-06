//
//  DepartmentViewController.m
//  WordPress
//
//  Created by Varut Aphimanchindakul on 12/6/54 BE.
//  Copyright (c) 2554 WordPress. All rights reserved.
//

#import "DepartmentViewController.h"
#import "PostTableViewController.h"

@implementation DepartmentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
-(void)getArray:(NSMutableArray*)array andAll:(NSMutableArray *)array2
{
    departmentItems = array;
    [self.tableView reloadData];
    NSLog(@"here");
    NSLog(@"departmentCount = %d", [departmentItems count]);
    departmentItemsFull = array2;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"hereeereErerere");
    return [departmentItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [departmentItems objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    WordPressAppDelegate *appDelegate = [WordPressAppDelegate sharedWordPressApp];
    NSFetchRequest *requestFetch2 = [[NSFetchRequest alloc] init];
	requestFetch2.entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error22 = nil;
	NSArray *allCatArray2 = [appDelegate.managedObjectContext executeFetchRequest:requestFetch2 error:&error22];
	[requestFetch2 release];
    NSMutableArray *cat5, *cat6;
    cat5 = [[NSMutableArray alloc] init];
    cat6 = [[NSMutableArray alloc] init];
    /////////////////////////////////////////////////////////////////////////
        [cat5 removeAllObjects];
        [cat6 removeAllObjects];
        
        Category*selectedCat = [departmentItemsFull objectAtIndex:indexPath.row];
        NSLog(@"%s selectedCat = %@",__FUNCTION__,selectedCat.categoryName);
        for (Post *newPost in allCatArray2) {
            
            //    NSSet *allCatInPost = newPost.categories;
            if ([newPost.categories containsObject:selectedCat]) {
                NSLog(@"%s newPost.postTitle = %@",__FUNCTION__,newPost.postTitle);
                [cat5 addObject:newPost.postTitle];
                [cat6 addObject:newPost];
            }
            
        }
        [selectedCat release];
    
    PostTableViewController *postTableVC = [[PostTableViewController alloc] initWithNibName:@"PostTableViewController" bundle:nil];
    postTableVC.navigationItem.title = @"Projects";
    [postTableVC getArray:cat5 andAll:cat6];
    postTableVC.contentSizeForViewInPopover = CGSizeMake(300, 500);
    [self.navigationController pushViewController:postTableVC animated:YES];
    [postTableVC release];
}

@end
