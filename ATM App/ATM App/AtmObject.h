//
//  AtmObject.h
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AtmObject : NSObject

@property (strong, nonatomic) NSString *atmID;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *status;
@property long tot_trans;
@property (strong, nonatomic) NSString *peakTime;
@property int failures;
@property int r1;
@property int r2;
@property int r3;

@end
