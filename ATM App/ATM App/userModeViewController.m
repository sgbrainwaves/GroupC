//
//  userModeViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "userModeViewController.h"
#import "atmTableViewController.h"

@interface userModeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *rangeButton;

@end

@implementation userModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@ is login id",self.loginId);
    
    self.searchButton.layer.cornerRadius = 5.0;
    self.locationButton.layer.cornerRadius = 5.0;
    self.rangeButton.layer.cornerRadius = 5.0;
    self.locationTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchForTheLocation:(id)sender
{
    atmTableViewController *ATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"atm TVC"];
    ATVC.loginId = self.loginId;
    [self.navigationController pushViewController:ATVC animated:YES];
    NSLog(@"using provided location");
}
- (IBAction)useTheCurrentLocation:(id)sender
{
    atmTableViewController *ATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"atm TVC"];
    ATVC.loginId = self.loginId;
    [self.navigationController pushViewController:ATVC animated:YES];
    NSLog(@"using current location");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
