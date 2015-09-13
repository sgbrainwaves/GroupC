//
//  User.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "User.h"

@implementation User

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.password forKey:@"password"];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    if(self = [super init])
    {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.password = [decoder decodeObjectForKey:@"password"];
    }
    return self;
}
@end
