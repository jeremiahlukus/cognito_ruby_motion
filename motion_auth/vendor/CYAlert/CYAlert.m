// CYAlert.m
#import "CYAlert.h"

@implementation CYAlert

- (NSDictionary*) show: (NSDictionary*) args {
//setup service config
//AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:CognitoIdentityUserPoolRegion credentialsProvider:nil];


    NSLog(@"HEY im inited");
    id serviceClass = [args objectForKey: @"serviceClass"];

    id serviceConfiguration = [[serviceClass alloc] initWithRegion:1 credentialsProvider:nil];

    id awsCognitoIdentityClass = [args objectForKey: @"awsCognitoIdentityClass"];

    [awsCognitoIdentityClass registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration
 userPoolConfiguration:nil
 forKey:@"UserPool"
    ];


    id pool = [awsCognitoIdentityClass CognitoIdentityUserPoolForKey:@"UserPool"];


     [pool setValue:self
              forKey:@"delegate"];

    return nil;
}

-(id) startPasswordAuthentication {
    NSLog(@"HEY");
    return nil;
}

@end

