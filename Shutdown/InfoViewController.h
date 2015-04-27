//
//  InfoViewController.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 03.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UITableViewController <UITextFieldDelegate>

- (IBAction)doneAction:(UIBarButtonItem *)sender;
- (IBAction)switchValueChanged:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *startupSwitch;
@end
