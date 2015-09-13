//
//  userLoginViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 13/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "userLoginViewController.h"
#import "userModeViewController.h"
#import "User.h"

@interface userLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) NSArray *users;

@end

@implementation userLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginIdTextField.delegate = self;
    self.passwordField.delegate = self;
    
    [self initUserDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findMeATM:(id)sender
{
    NSString *logid = self.loginIdTextField.text;
    NSString *password = self.passwordField.text;
    int num = -1;
    for(int i = 0; i < self.users.count; i++)
    {
        User *user = [self.users objectAtIndex:i];
        if([logid isEqualToString:[NSString stringWithFormat:@"%@",user.userId]])
        {
            num = i;
            break;
        }
    }
    
    if(num >= 0)
    {
        User *user = [self.users objectAtIndex:num];
        if([password isEqualToString:user.password])
        {
            userModeViewController *UMVC = [self.storyboard instantiateViewControllerWithIdentifier:@"User"];
            UMVC.loginId = logid;
            [self.navigationController pushViewController:UMVC animated:YES];
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
            [alert show];
        }
            }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Login Id" message:@"" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
        [alert show];
    }
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

-(void)initUserDB
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Users"];
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    self.users = [[NSArray alloc] initWithArray:array];
    
    NSLog(@"User Db created");
}

@end
