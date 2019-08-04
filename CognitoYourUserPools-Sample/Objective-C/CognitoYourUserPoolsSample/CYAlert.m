// CYAlert.m
#import "CYAlert.h"

@implementation CYAlert

- (NSDictionary*) show: (NSDictionary*) args {
    //setup service config
    //AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:CognitoIdentityUserPoolRegion credentialsProvider:ni
    
//    id serviceClass = [args objectForKey: @"serviceClass"];
//
//    id cognitoConfigurationClass= [args objectForKey: @"cognitoConfigurationClass"];
//    id poolId = [args objectForKey: @"poolId"];
//
//    id awsCognitoIdentityClass = [args objectForKey: @"awsCognitoIdentityClass"];
//
//    [awsCognitoIdentityClass registerCognitoIdentityUserPoolWithConfiguration:serviceClass
//                                                        userPoolConfiguration:nil
//                                                                       forKey:@"UserPool"
//     ];
//
//
//    id pool = [awsCognitoIdentityClass CognitoIdentityUserPoolForKey:@"UserPool"];
//
//
//    id poolDelegateHandler = [args objectForKey: @"poolDelegateHandler"];
//    [pool setValue:poolDelegateHandler
//            forKey:@"delegate"];
//
//
//    NSLog(@"%@", [args objectForKey: @"serviceClass"]);
//    UIAlertView *alert = [[UIAlertView alloc] init];
//    alert.title = @"This is Objective-C";
//    alert.message = @"Mixing and matching!";
//    [alert addButtonWithTitle:@"OK"];
//    [alert show];
//    [alert release];
    return nil;
}

-(id) startPasswordAuthentication {
    NSLog(@"HEY CYAlert");
    return nil;
}

@end
