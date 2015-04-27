//
//  NewDeviceViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 17.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NewDeviceViewController.h"
#import "AppDelegate.h"
#import "Account.h"
#import "NMSSHSession+OP.h"

@interface NewDeviceViewController ()

@end

@implementation NewDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushedCancel:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushedSave:(UIBarButtonItem *)sender {
    if ([self missingConfiguration]) {
        [[[UIAlertView alloc] initWithTitle: NSLocalizedString(@"ERROR", nil) message: NSLocalizedString(@"MISSING_CONFIGURATION", nil) delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show ];
    } else {
        id appDelegate = (id)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        Account *account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
        
        [account setUsername:self.usernameField.text];
        [account setAdress:self.addressField.text];
        [account setSystemType:];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    }
}

-(BOOL)missingConfiguration {
    return
    !self.nameField.text ||
    self.nameField.text.length == 0 ||
    !self.addressField.text ||
    self.addressField.text.length == 0 ||
    !self.usernameField.text ||
    self.usernameField.text.length == 0 ||
    !self.passwordField.text ||
    self.passwordField.text.length == 0 ||
    self.shutdownType != 1 ||
    self.shutdownType != 2;
}
@end
