//
//  NewDeviceViewController.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 17.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "NMSSHSession+OP.h"

@interface NewDeviceViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shutdownTypeControl;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, readwrite) OperatingSystem systemType;

- (IBAction)pushedCancel:(UIBarButtonItem *)sender;
- (IBAction)pushedSave:(UIBarButtonItem *)sender;

@end
