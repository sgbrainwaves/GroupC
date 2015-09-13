//
//  Atm_Trans.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "Atm_Trans.h"

@implementation Atm_Trans

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.atmId forKey:@"atmId"];
    [encoder encodeInteger:self.tr_amt forKey:@"tr_amt"];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    if(self = [super init])
    {
        self.atmId = [decoder decodeObjectForKey:@"atmId"];
        self.tr_amt = [decoder decodeIntegerForKey:@"tr_amt"];
    }
    return self;
}

@end
