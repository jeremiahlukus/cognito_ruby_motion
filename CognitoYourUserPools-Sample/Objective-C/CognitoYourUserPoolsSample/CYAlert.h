//
//  CYAlert.h
//  CognitoYourUserPoolsSample
//
//  Created by Jeremiah Parrack on 8/3/19.
//  Copyright © 2019 Behroozi, David. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CYAlert : NSObject

- (NSDictionary*) show: (NSDictionary*) args;

-(id) startPasswordAuthentication;


@end
