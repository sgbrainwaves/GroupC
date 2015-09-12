//
//  detailForUserViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForUserViewController.h"

@interface detailForUserViewController ()

@end

@implementation detailForUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)broadcastStatus:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atm Status" message:@"Are you sure about status of ATM?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
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
