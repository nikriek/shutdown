//
//  ViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 03.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//
#import "NMSSHSession+OP.h"
#import "ViewController.h"
#import "PDKeychainBindings.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController {
    PDKeychainBindings *keychain;
    BOOL shouldExecuteOnStartup;
}
NSString* const startupDefaultsConstant = @"shouldExexcuteOnStartup";


- (void)viewDidLoad
{
    [super viewDidLoad];
	keychain = [PDKeychainBindings sharedKeychainBindings];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:startupDefaultsConstant] == nil) {
        [defaults setBool:NO forKey:startupDefaultsConstant];
    } else {
        shouldExecuteOnStartup = [defaults boolForKey:startupDefaultsConstant];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    if ([self dataInKeychain] == NO) {
        self.infoLabel.text = NSLocalizedString(@"NO_CREDENTIALS", nil);
        [self.shutdownButton setEnabled:NO];
        [self performSegueWithIdentifier:@"showInfo" sender:self];
    } else {
        [self.shutdownButton setEnabled:YES];
        if (shouldExecuteOnStartup == YES) {
            [self sendShutdown:self.shutdownButton];
            shouldExecuteOnStartup = NO;
        }
    }
}

-(BOOL)dataInKeychain {
    NSString *username = [keychain stringForKey:@"user"];
    NSString *host = [keychain stringForKey:@"host"];
    NSString *pass = [keychain stringForKey:@"pass"];
    if (username == nil ||
        pass == nil ||
        host == nil ) {
        return NO;
    } else if ([username isEqualToString:@""] ||
               [host isEqualToString:@""] ||
               [pass isEqualToString:@""]){
        return NO;
    } else {
        return YES;
    }
}

/*
-(BOOL)isAuthorized {
    if (authorized == YES) {
        [self.shutdownButton setEnabled:YES];
        return YES;
    } else {
        NSString *username = [keychain stringForKey:@"user"];
        NSString *host = [keychain stringForKey:@"host"];
        
        session = [NMSSHSession connectToHost:host
                                 withUsername:username];
        
        if (session.isConnected) {
            NSString *pass = [keychain stringForKey:@"pass"];
            [session authenticateByPassword:pass];
            
            [session authenticateByKeyboardInteractiveUsingBlock:^NSString*(NSString *request){
                NSLog(@"request");
                return pass;
            }];
            if (session.isAuthorized) {
                self.infoLabel.text = @"Connection was successful";
                authorized = YES;
                [self.shutdownButton setEnabled:YES];
                return YES;
            } else {
                self.infoLabel.text = @"Could not authorize client";
                authorized = NO;
                [self.shutdownButton setEnabled:NO];
                return NO;
            }
        } else {
            self.infoLabel.text = @"Connection failed";
            authorized = NO;
            [self.shutdownButton setEnabled:NO];
            return NO;
        }
    }
 
 UIImageView *imageView = self.shutdownButton.imageView;
 CABasicAnimation* animation;
 if ([self.view.layer animationForKey:@"SpinAnimation"] == nil) {
 animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
 animation.fromValue = [NSNumber numberWithFloat:0.0f];
 animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
 animation.duration = 2.0f;
 animation.repeatCount = INFINITY;
 [imageView.layer addAnimation:animation forKey:@"SpinAnimation"];
 }
 [imageView.layer removeAnimationForKey:@"SpinAnimation"];

 
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendShutdown:(UIButton *)sender {
    // Audio
    AudioServicesPlaySystemSound(0x450);
    
    // GUI
    [self.activityIndicator startAnimating];
    [self.shutdownButton setEnabled:NO];
    
    // Eigentliche Action
    NSString *user = [keychain stringForKey:@"user"];
    NSString *host = [keychain stringForKey:@"host"];
    OperatingSystem op = [[NSUserDefaults standardUserDefaults] integerForKey:@"op"];

    [self sendShutdownForHost:host withOP:op username:user success:^(NSString* successString) {
        self.infoLabel.text = successString;
        [self.activityIndicator stopAnimating];
        [self.shutdownButton setEnabled:YES];
    } failure:^(NSString *failureString) {
        self.infoLabel.text = failureString;
        [self.activityIndicator stopAnimating];
        [self.shutdownButton setEnabled:YES];
    }];
}

-(void)sendShutdownForHost:(NSString*)host withOP:(OperatingSystem)op username:(NSString*)user success:(void(^)(NSString* successString))successBlock failure:(void(^)(NSString* failureString))failureBlock {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NMSSHSession *session = [NMSSHSession connectToHost:host
                                               withUsername:user];
        session.delegate = self;
        if (session.isConnected) {
            if (op == kLinux || op == kSynology) {
                [session authenticateByPassword:[keychain stringForKey:@"pass"]];
            } else if (op == kMacOSX ) {
                [session authenticateByKeyboardInteractive];
            }
            if (session.isAuthorized) {
                NSError *error = nil;
               
                NSString __unused *response = [session.channel execute:[NMSSHSession commandForOP:op] error:&error];
                
                [session disconnect];
                if (error == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        successBlock(NSLocalizedString(@"SUCCESS", nil));
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        NSLog(@"Error: %@",error.localizedDescription);
                        failureBlock(error.localizedDescription);
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    failureBlock(NSLocalizedString(@"AUTH_FAILED", nil));
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                failureBlock(NSLocalizedString(@"CONNECTION_FAILED", nil));
            });
        }
    });
}

#pragma mark - NMSSHSessionDelegate 
- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request {
    NSLog(@"Request: %@",request);
    //Gibt immer das Passwort zurück
    return [keychain stringForKey:@"pass"];

}

- (BOOL)session:(NMSSHSession *)session shouldConnectToHostWithFingerprint:(NSString *)fingerprint {
    return YES;
}
@end
