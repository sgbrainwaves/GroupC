//
//  Atm_Usr.h
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Atm_Usr : NSObject <NSCoding>

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *atmId;
@property (strong, nonatomic) NSString *feedStatus;

@end
