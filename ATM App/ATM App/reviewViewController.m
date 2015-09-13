//
//  reviewViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "reviewViewController.h"
#import "Atm_Usr.h"

@interface reviewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *reviews;
@property (strong, nonatomic) NSMutableArray *filteredRev;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noRevLabel;

@end

@implementation reviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"AtmUsr"];
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.reviews = [[NSArray alloc] initWithArray:array];
    [self filterReview];
    
    if(self.filteredRev.count > 0)
    {
        self.tableView.hidden = NO;
        self.noRevLabel.hidden = YES;
    }
    
    else
    {
        self.tableView.hidden = YES;
        self.noRevLabel.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredRev.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Atm_Usr *au = [self.filteredRev objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@",au.userId, au.atmId];
    cell.detailTextLabel.text = au.feedStatus;
    
    return cell;
}

-(void)filterReview
{
    self.filteredRev = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < self.reviews.count; i++)
    {
        Atm_Usr *au = [self.reviews objectAtIndex:i];
        
        if([au.atmId isEqualToString:self.atmId])
        {
            [self.filteredRev addObject:au];
        }
    }
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
