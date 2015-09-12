//
//  ViewController.m
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import "ViewController.h"
#import "userModeViewController.h"
#import "managerModeViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *usrMdButton;
@property (weak, nonatomic) IBOutlet UIButton *mgMdButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.usrMdButton.layer.borderWidth = 1.0;
    self.usrMdButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.usrMdButton.layer.cornerRadius = 5.0;
    
    self.mgMdButton.layer.borderWidth = 1.0;
    self.mgMdButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.mgMdButton.layer.cornerRadius = 5.0;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"notFirstLaunch"])
    {
        NSLog(@"not the first launch");
        //move to next view controller
          //stay on the same view controller.
    }
    else
    {
        //set bool value for later launch.
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirstLaunch"];
        NSLog(@"first launch work done");
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    NSString *mode = [[NSUserDefaults standardUserDefaults] valueForKey:@"mode"];
    
    if([mode isEqualToString:@"UserMode"])
    {
        [self performSegueWithIdentifier:@"goToUserMode" sender:self];
        //userModeViewController *UMVC = [self.storyboard instantiateViewControllerWithIdentifier:@"User"];
        //[self presentViewController:UMVC animated:YES completion:nil];
        NSLog(@"usermode segue performed");
    }
    
    else if([mode isEqualToString:@"ManagerMode"])
    {
        [self performSegueWithIdentifier:@"goToManagerMode" sender:self];
        //managerModeViewController *MMVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Manager"];
        //[self presentViewController:MMVC animated:YES completion:nil];
        NSLog(@"managermode segue performed");
    }
    
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userMode:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"UserMode" forKey:@"mode"];
    NSLog(@"user mode is set");
}

- (IBAction)managerMode:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"ManagerMode" forKey:@"mode"];
    NSLog(@"manager mode is set");
}

@end
