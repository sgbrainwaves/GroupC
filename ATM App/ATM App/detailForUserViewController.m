//
//  detailForUserViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "detailForUserViewController.h"
#import "ExtraDetail.h"
#import "reviewViewController.h"
#import "Atm_Usr.h"

@interface detailForUserViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *facilities;

@property (weak, nonatomic) IBOutlet UIImageView *HImageView;
@property (weak, nonatomic) IBOutlet UIImageView *FHImageView;

@property (weak, nonatomic) IBOutlet UIImageView *THImageView;

@property (strong, nonatomic) NSString *newstatus;

@end

@implementation detailForUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.layer.borderColor = [UIColor grayColor].CGColor;
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.cornerRadius = 3.0;
    self.newstatus = @"";
    
    //find all extra details
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExtraDet"];
    NSArray *ED= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    for(int i = 0; i < ED.count; i++)
    {
        ExtraDetail *ed = [ED objectAtIndex:i];
        if([ed.atmID isEqualToString:self.myAtm.atmID])
        {
            NSLog(@"%@ is the id and %d %d %d",ed.atmID, ed.a1, ed.a2, ed.a3);
            if(ed.a1)
                self.HImageView.image = [UIImage imageNamed:@"tick.png"];
            else
                self.HImageView.image = [UIImage imageNamed:@"cross.png"];
            
            if(ed.a2)
                self.FHImageView.image = [UIImage imageNamed:@"tick.png"];
            else
                self.FHImageView.image = [UIImage imageNamed:@"cross.png"];

            
            if(ed.a3)
                self.THImageView.image = [UIImage imageNamed:@"tick.png"];
            else
                self.THImageView.image = [UIImage imageNamed:@"cross.png"];

            break;
        }
    }
    
    self.facilities = [[NSArray alloc] initWithArray:self.myAtm.services];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)statusChosen:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if(selectedSegment == 0)
    {
        self.newstatus = @"No Cash";
    }
    else if (selectedSegment == 1)
    {
        self.newstatus = @"Server Down";
    }
    else if (selectedSegment == 2)
    {
        self.newstatus = @"Out Of Order";
    }
    else
        self.newstatus = @"Just Kidding";
    
    NSLog(@"%@ is the new status.",self.newstatus);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atm Status" message:@"Are you sure about status of ATM?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    
    if([[alert buttonTitleAtIndex:1] isEqualToString:@"Yes"])
    {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"AtmUsr"];
        NSMutableArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if(array == nil)
            array = [[NSMutableArray alloc] init];
        Atm_Usr *au = [[Atm_Usr alloc] init];
        au.atmId = self.myAtm.atmID;
        au.feedStatus = self.newstatus;
        NSLog(@"%@ is stored as status",au.feedStatus);
        au.userId = self.userId;
        [array addObject:au];
        NSData *Data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [[NSUserDefaults standardUserDefaults] setObject:Data forKey:@"AtmUsr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Informed status updated");
    }
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
- (IBAction)recentReview:(id)sender
{
    reviewViewController *RVC = [self.storyboard instantiateViewControllerWithIdentifier:@"review"];
    RVC.atmId = self.myAtm.atmID;
    [self.navigationController pushViewController:RVC animated:YES];
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
