//
//  detailForUserViewController.h
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtmObject.h"

@interface detailForUserViewController : UIViewController

@property (strong, nonatomic) AtmObject *myAtm;
@property (strong, nonatomic) NSString *userId;

@end
