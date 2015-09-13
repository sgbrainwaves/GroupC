//
//  AtmObject.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "AtmObject.h"

@implementation AtmObject

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.atmID forKey:@"atmID"];
    [encoder encodeObject:self.services forKey:@"services"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.bank forKey:@"bank"];
    [encoder encodeObject:self.dist forKey:@"dist"];
}

-(id)initWithCoder:(NSCoder*)decoder
{
   if(self = [super init])
   {
       self.atmID = [decoder decodeObjectForKey:@"atmID"];
       self.services = [decoder decodeObjectForKey:@"services"];
       self.address = [decoder decodeObjectForKey:@"address"];
       self.status = [decoder decodeObjectForKey:@"status"];
       self.bank = [decoder decodeObjectForKey:@"bank"];
       self.dist = [decoder decodeObjectForKey:@"dist"];
   }
    
    return self;
}

@end
