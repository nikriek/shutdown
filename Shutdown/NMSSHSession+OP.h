//
//  NMSSHSession+OP.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 05.01.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <NMSSH/NMSSH.h>
typedef enum OperatingSystem:NSInteger {
    kMacOSX,
    kLinux,
    kSynology
} OperatingSystem;

typedef enum ShutdownType:NSInteger {
    kShutdown = 1,
    kHibernate = 2
} ShutdownType;

@interface NMSSHSession (OP)

+(NSString*)commandForOP:(OperatingSystem)op shutdownType:(ShutdownType)shutdowntype;
+(NSArray*)systemTypes;

@end
