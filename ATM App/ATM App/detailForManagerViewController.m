//
//  detailForManagerViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForManagerViewController.h"

@interface detailForManagerViewController ()

@end

@implementation detailForManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.atmObject.address);
    self.statusLabel.text = self.atmObject.status;
    self.totTransLabel.text = [NSString stringWithFormat:@"%ld", self.atmObject.tot_trans];
    self.peakTimeLabel.text = self.atmObject.peakTime;
    self.failureLabel.text = [NSString stringWithFormat:@"%d",self.atmObject.failures];
    self.r1Label.text = [NSString stringWithFormat:@"%d",self.atmObject.r1];
    self.r2Label.text = [NSString stringWithFormat:@"%d",self.atmObject.r2];
    self.r3Label.text = [NSString stringWithFormat:@"%d",self.atmObject.r3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
