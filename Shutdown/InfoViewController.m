//
//  InfoViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 03.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "InfoViewController.h"
#import "PDKeychainBindings.h"
#import "NMSSHSession+OP.h"

@interface InfoViewController ()

@end

@implementation InfoViewController {
    PDKeychainBindings *keychain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.startupSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"shouldExexcuteOnStartup"]];
    
    keychain = [PDKeychainBindings sharedKeychainBindings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneAction:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"shouldExexcuteOnStartup"];
}

- (IBAction)switchedSegmentedValue:(UISegmentedControl *)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:@"op"];

}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath ] setSelected:NO];
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"showAck" sender:self];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showGuide" sender:self];
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"showContact" sender:self];
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"pushAllDevices" sender:self];
    }
}
@end
