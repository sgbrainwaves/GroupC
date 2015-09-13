//
//  detailForManagerViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForManagerViewController.h"
#import "ExtraDetail.h"
#import "Atm_Trans.h"

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
- (IBAction)updateDenomination:(id)sender
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"AtmTrans"];
    NSArray *transArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    int x = 0;
    int y = 0;
    int z = 0;
    for(int i = 0; i < transArray.count; i++)
    {
        Atm_Trans *at = [transArray objectAtIndex:i];
        
        if([at.atmId isEqualToString:self.atmObject.atmID])
        {
            long ta = at.tr_amt;
            x += ta/1000;
            if(ta%1000 == 0){
                x--;y++;z+=5;
            } else {
                int count = ta%1000;
                y += count/500;
                if(count%500 == 0){
                    y--;z+=5;
                } else {
                    z += (count%500)/100;
                }
            }
        }
    }
    int t = [self HCFwithpara1:x andpara2:y];
    int res = [self HCFwithpara1:t andpara2:z];
    x = x/res; //for 1000:r3
    y = y/res; //for 500:r2
    z = z/res; //for 100:r1
    
    NSData *exdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExtraDet"];
    NSArray *exArray = [NSKeyedUnarchiver unarchiveObjectWithData:exdata];
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithArray:exArray];
    int num = -1;
    for(int j = 0; j < mutArray.count; j++)
    {
        ExtraDetail *ed = [mutArray objectAtIndex:j];
       if([self.atmObject.atmID isEqualToString:ed.atmID])
       {
           num = j;
           break;
       }
    }
    
    ExtraDetail *samp = [mutArray objectAtIndex:num];
    samp.r1 = z;
    samp.r2 = y;
    samp.r3 = x;
    
    [mutArray replaceObjectAtIndex:num withObject:samp];
    
    NSData *pushData = [NSKeyedArchiver archivedDataWithRootObject:mutArray];
    [[NSUserDefaults standardUserDefaults] setObject:pushData forKey:@"ExtraDet"];
    [self viewDidLoad];
}

-(int)HCFwithpara1:(int)a andpara2:(int)b
{
    if(a == b)
        return a;
    else if(a<b)
        return [self HCFwithpara1:a andpara2:b-a];
    else
        return [self HCFwithpara1:a-b andpara2:b];
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
