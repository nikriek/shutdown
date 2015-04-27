//
//  AckViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 03.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "AckViewController.h"
#import "NSAttributedStringMarkdownParser.h"

@interface AckViewController ()

@end

@implementation AckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *markdown = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Ack" ofType:@"markdown"] encoding:NSUTF8StringEncoding error:nil];
    NSAttributedStringMarkdownParser *parser = [NSAttributedStringMarkdownParser new];
    NSAttributedString *string = [parser attributedStringFromMarkdownString:markdown];
    self.textView.attributedText = string;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
