//
//  atmTableViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "atmTableViewController.h"
#import "userModeCustomCell.h"
#import "detailForUserViewController.h"

@interface atmTableViewController () <UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *atms;
@property (strong, nonatomic) NSArray *dist;
@property (strong, nonatomic) NSArray *address;
@property (strong, nonatomic) NSArray *status;

@end

@implementation atmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@ is the location", self.locationName);
    
    self.atms = [[NSArray alloc] initWithObjects:@"Allahabad ATM",@"HDFC ATM",@"SBI ATM",@"Axis Bank ATM",@"HSBC ATM", nil];
    self.dist = [[NSArray alloc] initWithObjects:@"1.3",@"1.7",@"2.3",@"2.45",@"3.7", nil];
    self.address = [[NSArray alloc] initWithObjects:@"Near BMS College Of Engineering",@"In front of Ganesh Temple, Hanumanthnagar",@"Nagasandra Circle 2nd Block 12th Main",@"Bansankari Police Station",@"Jaynagar 3rd block 14th main", nil];
    self.status = [[NSArray alloc] initWithObjects:@"W",@"W",@"W",@"NW",@"W", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.atms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    userModeCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.atmNameLabel.text = [self.atms objectAtIndex:indexPath.row];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@ Km",[self.dist objectAtIndex:indexPath.row]];
    cell.addressLabel.text = [self.address objectAtIndex:indexPath.row];
    
    if([[self.status objectAtIndex:indexPath.row] isEqualToString:@"W"])
        cell.statusImageView.image = [UIImage imageNamed:@"working.png"];
    else
        cell.statusImageView.image = [UIImage imageNamed:@"notWorking.png"];
        
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    detailForUserViewController *DFUVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailForUser"];
    DFUVC = [segue destinationViewController];
    DFUVC.title = [self.atms objectAtIndex:indexPath.row];
}


@end
