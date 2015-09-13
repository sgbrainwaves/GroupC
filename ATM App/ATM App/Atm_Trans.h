//
//  Atm_Trans.h
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Atm_Trans : NSObject <NSCoding>

@property (strong, nonatomic) NSString *atmId;
@property long tr_amt;

@end
