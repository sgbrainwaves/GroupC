//
//  detailForManagerViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForManagerViewController.h"
#import "ExtraDetail.h"

@interface detailForManagerViewController ()

@end

@implementation detailForManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.atmObject.address);
    self.statusLabel.text = self.atmObject.status;
    NSString *atmid = self.atmObject.atmID;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExtraDet"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    ExtraDetail *ed = [[ExtraDetail alloc] init];
    for(int i = 0; i < array.count; i++)
    {
        ExtraDetail *ED = [array objectAtIndex:i];
        
        if([ED.atmID isEqualToString:atmid])
        {
            ed = ED;
            break;
        }
    }
    
    self.totTransLabel.text = [NSString stringWithFormat:@"%ld", ed.tot_tran];
    self.peakTimeLabel.text = ed.peakTime;
    self.failureLabel.text = [NSString stringWithFormat:@"%d",ed.fails];
    self.r1Label.text = [NSString stringWithFormat:@"%d",ed.r1];
    self.r2Label.text = [NSString stringWithFormat:@"%d",ed.r2];
    self.r3Label.text = [NSString stringWithFormat:@"%d",ed.r3];
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
