//
//  mgAtmTableViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "mgAtmTableViewController.h"
#import "mgModeCustomCell.h"
#import "AtmObject.h"
#import "detailForManagerViewController.h"

@interface mgAtmTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *alAtms;
@property (strong, nonatomic) NSArray *sbiAtms;
@property (strong, nonatomic) NSArray *ATMs;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation mgAtmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareDataBase];
    //self.ATMs = [[NSArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.bankName isEqualToString:@"Allahabad Bank"])
    {
        self.ATMs = [[NSArray alloc] initWithArray:self.alAtms];
        return self.alAtms.count;
    }
    else if ([self.bankName isEqualToString:@"SBI"])
    {
        self.ATMs = [[NSArray alloc] initWithArray:self.sbiAtms];
        return self.sbiAtms.count;
    }
    else
        return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mgModeCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    AtmObject *atm = [self.ATMs objectAtIndex:indexPath.row];
    cell.atmNameLabel.text = [NSString stringWithFormat:@"%@_%@",self.bankName, atm.atmID];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    detailForManagerViewController *DFMVC = [self.storyboard instantiateViewControllerWithIdentifier:@"managerDetailView"];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DFMVC = [segue destinationViewController];
    DFMVC.atmObject = [self.ATMs objectAtIndex:indexPath.row];
}


/*
 @property (strong, nonatomic) NSString *atmID;
 @property (strong, nonatomic) NSString *address;
 @property (strong, nonatomic) NSString *status;
 @property long tot_trans;
 @property (strong, nonatomic) NSString *peakTime;
 @property int failures;
 @property int r1;
 @property int r2;
 @property int r3;
 */

-(void)prepareDataBase
{
    /*AtmObject *a1 = [[AtmObject alloc] init];
    a1.atmID = @"1";
    a1.address = @"Near Basavangudi Police Station";
    a1.status = @"working";
    a1.tot_trans = 800000;
    a1.peakTime = @"8-10";
    a1.failures = 0;
    a1.r1 = 12;
    a1.r2 = 7;
    a1.r3 = 3;
    
    AtmObject *a2 = [[AtmObject alloc] init];
    a2.atmID = @"2";
    a2.address = @"Bull Temple Road";
    a2.status = @"unavailable";
    a2.tot_trans = 650000;
    a2.peakTime = @"18-20";
    a2.failures = 1;
    a2.r1 = 5;
    a2.r2 = 2;
    a2.r3 = 2;
    
    AtmObject *a3 = [[AtmObject alloc] init];
    a3.atmID = @"3";
    a3.address = @"Near Prestige Hotel Jayanagar";
    a3.status = @"failure";
    a3.tot_trans = 70000;
    a3.peakTime = @"13-15";
    a3.failures = 3;
    a3.r1 = 23;
    a3.r2 = 3;
    a3.r3 = 1;
    
    AtmObject *a4 = [[AtmObject alloc] init];
    a4.atmID = @"4";
    a4.address = @"Majestic Bus Stand";
    a4.status = @"working";
    a4.tot_trans = 900000;
    a4.peakTime = @"18-20";
    a4.failures = 0;
    a4.r1 = 9;
    a4.r2 = 7;
    a4.r3 = 5;
    
    AtmObject *a5 = [[AtmObject alloc] init];
    a5.atmID = @"5";
    a5.address = @"Chamarajpet";
    a5.status = @"working";
    a5.tot_trans = 600000;
    a5.peakTime = @"18-20";
    a5.failures = 1;
    a5.r1 = 13;
    a5.r2 = 9;
    a5.r3 = 7;
    
    AtmObject *a6 = [[AtmObject alloc] init];
    a6.atmID = @"6";
    a6.address = @"Near Aloft hotel Whitefield";
    a6.status = @"failure";
    a6.tot_trans = 400000;
    a6.peakTime = @"11-13";
    a6.failures = 2;
    a6.r1 = 5;
    a6.r2 = 4;
    a6.r3 = 3;
    
    AtmObject *a7 = [[AtmObject alloc] init];
    a7.atmID = @"7";
    a7.address = @"Near Iskon temple Yeshwantpur";
    a7.status = @"unavailable";
    a7.tot_trans = 30000;
    a7.peakTime = @"16-18";
    a7.failures = 1;
    a7.r1 = 18;
    a7.r2 = 9;
    a7.r3 = 7;
    
    self.alAtms = [[NSArray alloc] initWithObjects:a1,a2,a3, nil];
    self.sbiAtms = [[NSArray alloc] initWithObjects:a4,a5, nil];
    self.hdfcAtms = [[NSArray alloc] initWithObjects:a6,a7, nil];*/
    
    /*
     @property (strong, nonatomic) NSString *atmID;
     @property (strong, nonatomic) NSString *bank;
     @property (strong, nonatomic) NSMutableArray *services;
     @property (strong, nonatomic) NSString *address;
     @property (strong, nonatomic) NSString *status;
     @property (strong, nonatomic) NSString *dist;
     */
    
    AtmObject *a1 = [[AtmObject alloc] init];
    a1.atmID = @"ALH_1";
    a1.bank = @"Allahabad Bank";
    a1.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a1.status = @"Working";
    a1.dist = @"1.1 Km";
    a1.address = @"Jayanagar 3rd Block 7th main";
    
    AtmObject *a2 = [[AtmObject alloc] init];
    a2.atmID = @"ALH_2";
    a2.bank = @"Allahabad Bank";
    a2.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a2.status = @"NotWorking";
    a2.dist = @"1.6 Km";
    a2.address = @"Basavanagudi";
    
    AtmObject *a3 = [[AtmObject alloc] init];
    a3.atmID = @"SB_1";
    a3.bank = @"SBI";
    a3.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a3.status = @"Working";
    a3.dist = @"2.5 Km";
    a3.address = @"Jayanagar 3rd block 14th main ";
    
    AtmObject *a4 = [[AtmObject alloc] init];
    a4.atmID = @"SB_2";
    a4.bank = @"SBI";
    a4.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a4.status = @"NotWorking";
    a4.dist = @"2.3 Km";
    a4.address = @"Gandhi Bazaar ";
    
    AtmObject *a5 = [[AtmObject alloc] init];
    a5.atmID = @"SB_3";
    a5.bank = @"SBI";
    a5.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a5.status = @"Unknown";
    a5.dist = @"2.0 Km";
    a5.address = @"Nagasandra Circle";
    
    self.alAtms = [[NSArray alloc] initWithObjects:a1,a2, nil];
    self.sbiAtms = [[NSArray alloc] initWithObjects:a3,a4,a5, nil];
}

@end
