//
//  FileDetailViewController.h
//  FilesApp
//
//  Created by chandrikagole on 1/18/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <LoopBack/LBRESTAdapter.h>
#import <LoopBack/LBModel.h>





@interface FileDetailViewController : UIViewController

// These are feilds connected to the details view controller

@property (weak, nonatomic) IBOutlet UITextField *authorText;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *dateCreatedText;
@property (weak, nonatomic) IBOutlet UITextField *lastModifiedText;
@property (weak, nonatomic) IBOutlet UITextField *sizeText;


// These strings are used to pass data from the main view controller to the detail VC through the push segue
@property (nonatomic, weak) NSString *nameTxt;
@property (nonatomic, weak) NSString *authorTxt;
@property (nonatomic, weak) NSString *sizeTxt;
@property (nonatomic, weak) NSString *descriptionTxt;
@property (nonatomic, weak) NSString *lastModifiedTxt;
@property (nonatomic, weak) NSString *dateCreatedTxt;

@property (nonatomic) NSInteger obj_id;

@end



