//
//  FileDetailViewController.m
//  FilesApp
//
//  Created by chandrikagole on 1/18/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import "FileDetailViewController.h"
#import <UIKit/UIKit.h>
#define prototypeName @"Documents"

@interface FileDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@end


@implementation FileDetailViewController

// These strings are used to pass data from the main view controller to the detail VC through the segue
@synthesize obj_id;
@synthesize nameTxt;
@synthesize authorTxt;
@synthesize sizeTxt;
@synthesize descriptionTxt;
@synthesize lastModifiedTxt;
@synthesize dateCreatedTxt;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error No model found with ID %@", error.description);
    };
    
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model) {
        //destViewController.obj_id = indexPath.row;
        self.nameText.text=[model objectForKeyedSubscript:@"name"];
        self.authorText.text=[model objectForKeyedSubscript:@"created_by"];
        self.descriptionText.text=[model objectForKeyedSubscript:@"type"];
        self.sizeText.text=[model objectForKeyedSubscript:@"size"];
        self.lastModifiedText.text  =[model objectForKeyedSubscript:@"last_modified"];
        self.dateCreatedText.text=[model objectForKeyedSubscript:@"date_created"];
        
    };
    
    
    LBModelRepository *prototype = [[AppDelegate adapter] repositoryWithModelName:prototypeName];
    [prototype findById:[NSNumber numberWithInt:obj_id+1] success:findSuccessBlock failure:findErrorBlock ];
    
    self.view.backgroundColor = [UIColor grayColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
