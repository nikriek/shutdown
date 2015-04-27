//
//  GuideViewController.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 04.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "GuideViewController.h"
#import "NSAttributedStringMarkdownParser.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *markdown;
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"de"]) {
        markdown = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Guide_de" ofType:@"markdown"] encoding:NSUTF8StringEncoding error:nil];
    } else {
        markdown = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Guide" ofType:@"markdown"] encoding:NSUTF8StringEncoding error:nil];
    }

    NSAttributedStringMarkdownParser *parser = [NSAttributedStringMarkdownParser new];
    NSAttributedString *string = [parser attributedStringFromMarkdownString:markdown];
    self.textView.attributedText = string;
}

@end
