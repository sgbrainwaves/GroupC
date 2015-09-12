//
//  detailForManagerViewController.h
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtmObject.h"

@interface detailForManagerViewController : UIViewController

@property (strong, nonatomic) AtmObject *atmObject;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totTransLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *failureLabel;
@property (weak, nonatomic) IBOutlet UILabel *r1Label;
@property (weak, nonatomic) IBOutlet UILabel *r2Label;
@property (weak, nonatomic) IBOutlet UILabel *r3Label;

@end
