//
//  Atm_Usr.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "Atm_Usr.h"

@implementation Atm_Usr

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.atmId forKey:@"atmId"];
    [encoder encodeObject:self.feedStatus forKey:@"feedStatus"];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    if(self = [super init])
    {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.atmId = [decoder decodeObjectForKey:@"atmId"];
        self.feedStatus = [decoder decodeObjectForKey:@"feedStatus"];
    }
    return self;
}

@end
