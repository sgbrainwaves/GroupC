//
//  detailForUserViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForUserViewController.h"

@interface detailForUserViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *facilities;
@end

@implementation detailForUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.cornerRadius = 3.0;
    
    self.facilities = [[NSArray alloc] initWithObjects:@"Electricity Bill Payment",@"Check Deposit",@"Cash Deposit",@"Water Bill Payment", @"Passbook Printing",@"Account Opening", nil];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.facilities.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.facilities objectAtIndex:indexPath.row];
    return cell;
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
