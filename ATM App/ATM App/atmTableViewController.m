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
#import "AtmObject.h"

@interface atmTableViewController () <UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *atms;
@property (strong, nonatomic) NSArray *atmForAb;
@property (strong, nonatomic) NSArray *atmForNik;
@property (strong, nonatomic) NSArray *atmForAnk;
@property (strong, nonatomic) NSArray *curUser;

@end

@implementation atmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*self.atms = [[NSArray alloc] initWithObjects:@"Allahabad ATM",@"HDFC ATM",@"SBI ATM",@"Axis Bank ATM",@"HSBC ATM", nil];
    self.dist = [[NSArray alloc] initWithObjects:@"1.3",@"1.7",@"2.3",@"2.45",@"3.7", nil];
    self.address = [[NSArray alloc] initWithObjects:@"Near BMS College Of Engineering",@"In front of Ganesh Temple, Hanumanthnagar",@"Nagasandra Circle 2nd Block 12th Main",@"Bansankari Police Station",@"Jaynagar 3rd block 14th main", nil];
    self.status = [[NSArray alloc] initWithObjects:@"W",@"W",@"W",@"NW",@"W", nil];*/
    
    [self initATMs];
    self.atmForAb = [[NSArray alloc] initWithObjects:@"2",@"0", nil];
    self.atmForAnk = [[NSArray alloc] initWithObjects:@"1", @"3", nil];
    self.atmForNik = [[NSArray alloc] initWithObjects:@"0",@"1",@"4",nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.loginId isEqualToString:@"Abhishek"])
    {
        self.curUser = [[NSArray alloc] initWithArray:self.atmForAb];
        return self.atmForAb.count;
    }
    
    else if ([self.loginId isEqualToString:@"Ankur"])
    {
        self.curUser = [[NSArray alloc] initWithArray:self.atmForAnk];
        return self.atmForAnk.count;
    }
    
    else if([self.loginId isEqualToString:@"Nikhil"])
    {
        self.curUser = [[NSArray alloc] initWithArray:self.atmForNik];
        return self.atmForNik.count;
    }
    else
        return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    userModeCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSInteger i = [[NSString stringWithFormat:@"%@",[self.curUser objectAtIndex:indexPath.row]] integerValue];

    AtmObject *atm = [self.atms objectAtIndex:i];
    
    cell.atmNameLabel.text = atm.atmID;
    cell.distanceLabel.text = atm.dist;
    cell.addressLabel.text = atm.address;
    
    if([atm.status isEqualToString:@"Working"])
        cell.statusImageView.image = [UIImage imageNamed:@"working.png"];
    else if([atm.status isEqualToString:@"NotWorking"])
        cell.statusImageView.image = [UIImage imageNamed:@"notWorking.png"];
    else
        cell.statusImageView.image = [UIImage imageNamed:@"unavailable.png"];
        
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    detailForUserViewController *DFUVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailForUser"];
    DFUVC = [segue destinationViewController];
    NSInteger i = [[self.curUser objectAtIndex:indexPath.row] integerValue];
    AtmObject *atm = [self.atms objectAtIndex:i];
    DFUVC.title = atm.atmID;
    DFUVC.myAtm = atm;
    DFUVC.userId = self.loginId;
}

-(void)initATMs
{
    NSData *atmData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AllAtms"];
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:atmData];
    self.atms = [[NSArray alloc] initWithArray:array];
    
    NSLog(@"atm db accessed");
}

@end
