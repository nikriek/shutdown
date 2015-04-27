//
//  Account.h
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 17.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSNumber * systemType;
@property (nonatomic, retain) NSNumber * shutdownType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) NSString *password;
@property (nonatomic, assign) BOOL *mainDevice;

@end
