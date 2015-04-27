//
//  ViewController.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 03.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <NMSSH/NMSSH.h>


@interface ViewController : UIViewController <NMSSHSessionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *shutdownButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)sendShutdown:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
