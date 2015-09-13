//
//  ExtraDetail.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "ExtraDetail.h"

@implementation ExtraDetail

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.atmID forKey:@"atmID"];
    [encoder encodeInt:self.r1 forKey:@"r1"];
    [encoder encodeInt:self.r2 forKey:@"r2"];
    [encoder encodeInt:self.r3 forKey:@"r3"];
    [encoder encodeBool:self.a1 forKey:@"a1"];
    [encoder encodeBool:self.a2 forKey:@"a2"];
    [encoder encodeBool:self.a3 forKey:@"a3"];
    [encoder encodeInt:self.fails forKey:@"fails"];
    [encoder encodeInteger:self.tot_tran forKey:@"tot_tran"];
    [encoder encodeObject:self.peakTime forKey:@"peakTime"];
    
}

-(id)initWithCoder:(NSCoder*)decoder
{
    if(self = [super init])
    {
        self.atmID = [decoder decodeObjectForKey:@"atmID"];
        self.r1 = [decoder decodeIntForKey:@"r1"];
        self.r2 = [decoder decodeIntForKey:@"r2"];
        self.r3 = [decoder decodeIntForKey:@"r3"];
        self.a1 = [decoder decodeBoolForKey:@"a1"];
        self.a2 = [decoder decodeBoolForKey:@"a2"];
        self.a3 = [decoder decodeBoolForKey:@"a3"];
        self.fails = [decoder decodeIntForKey:@"fails"];
        self.tot_tran = [decoder decodeIntegerForKey:@"tot_tran"];
        self.peakTime = [decoder decodeObjectForKey:@"peakTime"];
    }
    
    return self;
}

@end
