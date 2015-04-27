//
//  Account.m
//  Shutdown
//
//  Created by Niklas Riekenbrauck on 17.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "Account.h"
#import "PDKeychainBindings.h"


@implementation Account

@dynamic username;
@dynamic identifier;
@dynamic adress;
@dynamic systemType;
@dynamic shutdownType;
@dynamic name;

-(void)setPassword:(NSString*)password {
    PDKeychainBindings *keychain = [PDKeychainBindings sharedKeychainBindings];
    [keychain setString:password forKey:[self.identifier stringValue]];
}

-(NSString*)password {
    PDKeychainBindings *keychain = [PDKeychainBindings sharedKeychainBindings];
    return [keychain stringForKey:[self.identifier stringValue]];
}

- (void)prepareForDeletion{
    PDKeychainBindings *keychain = [PDKeychainBindings sharedKeychainBindings];
    [keychain removeObjectForKey:[self.identifier stringValue]];
}


@end
