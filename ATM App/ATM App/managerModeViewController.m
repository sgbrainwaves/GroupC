//
//  managerModeViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "managerModeViewController.h"
#import "mgAtmTableViewController.h"

@interface managerModeViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSArray *ids;
@property (strong, nonatomic) NSArray *password;

@end

@implementation managerModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginIdTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.ids = [[NSArray alloc] initWithObjects:@"abc",@"xyz", nil];
    self.password = [[NSArray alloc] initWithObjects:@"123",@"456", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showAtmDetails:(id)sender
{
    //find which user is trying to login
    
    NSString *loginId = self.loginIdTextField.text;
    NSString *paswd = self.passwordTextField.text;
    int num = -1;
    
    for(int i = 0; i < self.ids.count; i++)
    {
        if([loginId isEqualToString:[NSString stringWithFormat:@"%@",[self.ids objectAtIndex:i]]])
        {
            num = i;
            break;
        }
    }
    
    if(num == -1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Login ID" message:@"" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if([paswd isEqualToString:[NSString stringWithFormat:@"%@",[self.password objectAtIndex:num]]])
    {
        mgAtmTableViewController *MATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"managerATMTable"];
        switch (num) {
            case 0:
                MATVC.bankName = @"Allahabad Bank";
                break;
                
            case 1:
                MATVC.bankName = @"SBI";
                break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:MATVC animated:YES    ];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
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
