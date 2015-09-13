//
//  ExtraDetail.h
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtraDetail : NSObject <NSCoding>

@property (strong, nonatomic) NSString *atmID;
@property int r1;
@property int r2;
@property int r3;
@property BOOL a1;
@property BOOL a2;
@property BOOL a3;
@property long tot_tran;
@property int fails;
@property (strong, nonatomic) NSString *peakTime;

@end
