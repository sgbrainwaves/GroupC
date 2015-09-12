//
//  userModeViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "userModeViewController.h"
#import "atmTableViewController.h"

@interface userModeViewController ()

@end

@implementation userModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchForTheLocation:(id)sender
{
    atmTableViewController *ATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"atm TVC"];
    ATVC.locationName = @"xyz";
    [self.navigationController pushViewController:ATVC animated:YES];
    NSLog(@"using provided location");
}
- (IBAction)useTheCurrentLocation:(id)sender
{
    atmTableViewController *ATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"atm TVC"];
    ATVC.locationName = @"xyz";
    [self.navigationController pushViewController:ATVC animated:YES];
    NSLog(@"using current location");
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
