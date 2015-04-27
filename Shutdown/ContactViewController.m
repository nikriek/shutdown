//
//  ContactViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 05/01/14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath ] setSelected:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSURL *tweetbotURL = [NSURL URLWithString:@"tweetbot:///user_profile/182883251"];
        NSURL *twitterURL =[NSURL URLWithString:@"twitter://user?screen_name=nikriek"];
        if ([[UIApplication sharedApplication] canOpenURL:tweetbotURL]) {
            [[UIApplication sharedApplication] openURL:tweetbotURL];
        } else if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
            [[UIApplication sharedApplication] openURL:twitterURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/nikriek"]];
        }
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        NSString *url =  @"mailto:shutdown@nikriek.de";
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://nikriek.de/shutdown"]];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/idAPP_ID?at=792612686"]];
    }
}


@end
