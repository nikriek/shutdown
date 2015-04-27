//
//  SystemType.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemType : NSObject
typedef enum ShutdownType:NSInteger {
    kShutdown = 1,
    kHibernate = 2
} ShutdownType;

+(NSString*)commandForShutdownType:(ShutdownType)shutdowntype;

@end
