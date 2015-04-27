//
//  NMSSHSession+OP.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 05.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NMSSHSession+OP.h"

@implementation NMSSHSession (OP)

+(NSString*)commandForOP:(OperatingSystem)op shutdownType:(ShutdownType)shutdowntype {
    switch (shutdowntype) {
        case kShutdown:
            switch (op) {
                case kMacOSX:
                    return @"osascript -e 'tell application \"System Events\" to shut down'";
                    break;
                case kLinux:
                    return @"sudo shutdown -h now";
                    break;
                case kSynology:
                    return @"poweroff";
                    break;
                    
                default:
                    return nil;
                    break;
            }
            break;
            
        case kHibernate:
            switch (op) {
                case kMacOSX:
                    return @"osascript -e 'tell application \"System Events\" to sleep'";
                    break;
                case kLinux:
                    return @"sudo pm-hibernate";
                    break;
                    
                default:
                    return nil;
                    break;
            }
            break;
    
        default:
            return nil;
            break;
    }
    
}

+(NSArray*)systemTypes {
    return [[NSArray alloc] initWithObjects:@"Mac OS X",@"Linux",@"Synology NAS", nil];
}



@end
