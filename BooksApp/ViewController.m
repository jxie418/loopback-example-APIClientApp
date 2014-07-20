//
//  ViewController.m
//  ModelsApp1
//
//  Created by chandrikagole on 1/14/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FileDetailViewController.h"
#define prototypeName @"Documents"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@end

@implementation ViewController {
    NSArray *files;
}


@synthesize tableView;
@synthesize myTextField;
//unwind seque
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}

// To pass data through seque into the detailed view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showFileDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FileDetailViewController *destViewController = segue.destinationViewController;
        destViewController.obj_id = indexPath.row;
    }
    
}

// To delete a row
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    void (^findErrorBlock)(NSError *) = ^(NSError *error)
    {
        NSLog( @"Error No model found with ID %@", error.description);
    };
    
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model){
        void (^removeErrorBlock)(NSError *) = ^(NSError *error){
            NSLog(@"Error on save %@", error.description);
        };
        void (^removeSuccessBlock)() = ^(){
            NSLog(@"Success with deletion");
            [self getFiles];
        };
        [model destroyWithSuccess:removeSuccessBlock failure:removeErrorBlock];
        
    };
    
    
    LBModelRepository *bug = [[AppDelegate adapter] repositoryWithModelName:prototypeName];
    
    [bug findById:[NSNumber numberWithInteger:indexPath.row+1] success:findSuccessBlock failure:findErrorBlock];
    
}




// To select a row and get an alert that you have selected the file. This isnt necessary. Just to learn how to enable alerts
/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 NSString *selectedRowInfo = @"You've selected a file : ";
 if (  [ [[self.tableData objectAtIndex:indexPath.row] class] isSubclassOfClass:[LBModel class]])
 {
 LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
 selectedRowInfo = [selectedRowInfo stringByAppendingString:[model objectForKeyedSubscript:@"title"]];
 UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Row Selected" message:selectedRowInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [messageAlert show];
 // To select and leave a check mark
 UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
 cell1.accessoryType = UITableViewCellAccessoryCheckmark;
 //
 }
 }
 */

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

// To display data in the table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (  [ [[self.tableData objectAtIndex:indexPath.row] class] isSubclassOfClass:[LBModel class]])
    {
        LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@",
                               [model objectForKeyedSubscript:@"name"]];
        //        cell.imageView.image = [UIImage imageNamed:@"button.png"];
    }
    return cell;
}
//

- (NSArray *) tableData
{
    if (!_tableData)_tableData = [[NSArray alloc] init];
    return _tableData;
}
- (void) getFiles
{
    // Error block
    void (^loadErrorBlock)(NSError *) = ^(NSError *error){
        NSLog(@"Error on load %@", error.description);
    };
    // Success block
    void (^loadSuccessblock)(NSArray *) = ^(NSArray *models){
        //NSLog(@"Success files %@", models);
        NSLog(@"Success count %d", models.count);
        self.tableData = models;
        [self.myTable reloadData];
    };
    
    LBModelRepository *allfiles = [[AppDelegate adapter] repositoryWithModelName:prototypeName]; // This line gets the Loopback model "file" through the apapter defined in AppDelegate
    [allfiles allWithSuccess:loadSuccessblock failure:loadErrorBlock]; // Logical line 1. Get allfiles. If connection to server fails load the failure block, if it passes, call the success bloack and pass allfiles to it.
};


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getFiles];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionGetFiles:(id)sender {
    [self getFiles];
    
}

- (IBAction)getAppInfo:(id)sender {
    UIAlertView *getAppInfo = [[UIAlertView alloc]
                               initWithTitle:@"Equinox Files app" message:@"Files app" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];    
    // Display the Hello World Message
    [getAppInfo show];
}

@end
