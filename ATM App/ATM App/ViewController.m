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

#import "AtmObject.h"
#import "ExtraDetail.h"
#import "User.h"
#import "Atm_Usr.h"
#import "Atm_Trans.h"


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
        [self prepareEntireDataBase];
        NSLog(@"first launch work done");
        
    }
}

/*-(void)viewDidAppear:(BOOL)animated
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
}*/

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

-(void)prepareEntireDataBase
{
    [self initATM];
    [self initExtraDetails];
    [self initUsers];
    [self initAtm_UsrDB];
    [self initAtm_TransDB];
}

//initializing all atms

-(void)initATM
{
    /*AtmObject *a1 = [[AtmObject alloc] init];
    a1.atmID = @"ALH_1";
    a1.bank = @"Allahabad Bank";
    a1.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a1.status = @"Working";
    a1.dist = @"";
    a1.address = @"";
    
    AtmObject *a2 = [[AtmObject alloc] init];
    a2.atmID = @"ALH_2";
    a2.bank = @"Allahabad Bank";
    a2.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a2.status = @"NotWorking";
    a2.dist = @"";
    a2.address = @"";
    
    AtmObject *a3 = [[AtmObject alloc] init];
    a3.atmID = @"SB_1";
    a3.bank = @"SBI";
    a3.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a3.status = @"Working";
    a3.dist = @"";
    a3.address = @"";
    
    AtmObject *a4 = [[AtmObject alloc] init];
    a4.atmID = @"SB_2";
    a4.bank = @"SBI";
    a4.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a4.status = @"NotWorking";
    a4.dist = @"";
    a4.address = @"";
    
    AtmObject *a5 = [[AtmObject alloc] init];
    a5.atmID = @"SB_3";
    a5.bank = @"SBI";
    a5.services = [[NSMutableArray alloc] initWithObjects:@"", nil];
    a5.status = @"Unknown";
    a5.dist = @"";
    a5.address = @"";*/
    
    AtmObject *a1 = [[AtmObject alloc] init];
    a1.atmID = @"ALH_1";
    a1.bank = @"Allahabad Bank";
    a1.services = [[NSMutableArray alloc] initWithObjects:@"Cash Deposit",@"Check Deposit", nil];
    a1.status = @"Working";
    a1.dist = @"1.1 Km";
    a1.address = @"Jayanagar 3rd Block 7th main";
    
    AtmObject *a2 = [[AtmObject alloc] init];
    a2.atmID = @"ALH_2";
    a2.bank = @"Allahabad Bank";
    a2.services = [[NSMutableArray alloc] initWithObjects:@"Water Bill Payment",@"Cash Deposit", nil];
    a2.status = @"NotWorking";
    a2.dist = @"1.6 Km";
    a2.address = @"Basavanagudi";
    
    AtmObject *a3 = [[AtmObject alloc] init];
    a3.atmID = @"SB_1";
    a3.bank = @"SBI";
    a3.services = [[NSMutableArray alloc] initWithObjects:@"Electricity Bill Payment",@"Water Bill Payment", @"Cash Deposit", nil];
    a3.status = @"Working";
    a3.dist = @"2.5 Km";
    a3.address = @"Jayanagar 3rd block 14th main ";
    
    AtmObject *a4 = [[AtmObject alloc] init];
    a4.atmID = @"SB_2";
    a4.bank = @"SBI";
    a4.services = [[NSMutableArray alloc] initWithObjects:@"Check Deposit",@"Account Opening", nil];
    a4.status = @"NotWorking";
    a4.dist = @"2.3 Km";
    a4.address = @"Gandhi Bazaar ";
    
    AtmObject *a5 = [[AtmObject alloc] init];
    a5.atmID = @"SB_3";
    a5.bank = @"SBI";
    a5.services = [[NSMutableArray alloc] initWithObjects:@"Electricity Bill Payment",@"Cash Deposit",@"Check Deposit", nil];
    a5.status = @"Unknown";
    a5.dist = @"2.0 Km";
    a5.address = @"Nagasandra Circle";
    
    NSMutableArray *atms = [[NSMutableArray alloc] initWithObjects:a1,a2,a3,a4,a5, nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:atms];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"AllAtms"];
    
    NSLog(@"Atm objects are set.");
}

-(void)initExtraDetails
{
    ExtraDetail *e1 = [[ExtraDetail alloc] init];
    e1.atmID = @"SB_1";
    e1.r1 = 2;
    e1.r2 = 5;
    e1.r3 = 3;
    e1.a1 = YES;
    e1.a2 = YES;
    e1.a3 = NO;
    e1.tot_tran = 56000;
    e1.fails = 0;
    e1.peakTime = @"14-16";
    
    ExtraDetail *e2 = [[ExtraDetail alloc] init];
    e2.atmID = @"SB_2";
    e2.r1 = 2;
    e2.r2 = 7;
    e2.r3 = 2;
    e2.a1 = YES;
    e2.a2 = NO;
    e2.a3 = NO;
    e2.tot_tran = 106000;
    e2.fails = 0;
    e2.peakTime = @"10-12";

    ExtraDetail *e3 = [[ExtraDetail alloc] init];
    e3.atmID = @"SB_3";
    e3.r1 = 13;
    e3.r2 = 7;
    e3.r3 = 9;
    e3.a1 = YES;
    e3.a2 = YES;
    e3.a3 = YES;
    e3.tot_tran = 800000;
    e3.fails = 2;
    e3.peakTime = @"16-17";

    ExtraDetail *e4 = [[ExtraDetail alloc] init];
    e4.atmID = @"ALH_1";
    e4.r1 = 11;
    e4.r2 = 5;
    e4.r3 = 3;
    e4.a1 = YES;
    e4.a2 = YES;
    e4.a3 = NO;
    e4.tot_tran = 300000;
    e4.fails = 1;
    e4.peakTime = @"15-16";

    ExtraDetail *e5 = [[ExtraDetail alloc] init];
    e5.atmID = @"ALH_2";
    e5.r1 = 9;
    e5.r2 = 5;
    e5.r3 = 3;
    e5.a1 = YES;
    e5.a2 = NO;
    e5.a3 = YES;
    e5.tot_tran = 560000;
    e5.fails = 3;
    e5.peakTime = @"17-18";

    NSMutableArray *extraDetails = [[NSMutableArray alloc] initWithObjects:e1,e2,e3,e4,e5, nil];
    NSData *mydata = [NSKeyedArchiver archivedDataWithRootObject:extraDetails];
    [[NSUserDefaults standardUserDefaults] setObject:mydata forKey:@"ExtraDet"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Extra details are set");
}

-(void)initUsers
{
    User *u1 = [[User alloc] init];
    u1.userId= @"Ankur";
    u1.password = @"123";
    //NSData *U1 = [NSKeyedArchiver archivedDataWithRootObject:u1];
    
    User *u2 = [[User alloc] init];
    u2.userId= @"Abhishek";
    u2.password = @"456";
    //NSData *U2 = [NSKeyedArchiver archivedDataWithRootObject:u2];
    
    User *u3 = [[User alloc] init];
    u3.userId= @"Nikhil";
    u3.password = @"789";
    //NSData *U3 = [NSKeyedArchiver archivedDataWithRootObject:u3];
    
    NSMutableArray *users = [[NSMutableArray alloc] initWithObjects:u1,u2,u3, nil];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:users] forKey:@"Users"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Users saved");
}

-(void)initAtm_UsrDB
{
    /*Atm_Usr *au1 = [[Atm_Usr alloc] init];
    au1.userId = @"Ankur";
    au1.atmId = @"SB_1";
    au1.feedStatus = @"";
    
    Atm_Usr *au2 = [[Atm_Usr alloc] init];
    au2.userId = @"Abhishek";
    au2.atmId = @"SB_1";
    au2.feedStatus = @"";
    
    Atm_Usr *au3 = [[Atm_Usr alloc] init];
    au3.userId = @"Nikhil";
    au3.atmId = @"ALH_1";
    au3.feedStatus = @"";
    
    NSMutableArray *AtmUsr = [[NSMutableArray alloc] initWithObjects:au1,au2,au3, nil];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:AtmUsr];
    [[NSUserDefaults standardUserDefaults] setObject:myData forKey:@"AtmUsr"];
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    
   // NSLog(@"Atm and User Details are saved");
}

-(void)initAtm_TransDB
{
    Atm_Trans *at1 = [[Atm_Trans alloc] init];
    at1.atmId = @"SB_1";
    at1.tr_amt = 4000;
    
    Atm_Trans *at2 = [[Atm_Trans alloc] init];
    at2.atmId = @"SB_1";
    at2.tr_amt = 2400;
    
    Atm_Trans *at3 = [[Atm_Trans alloc] init];
    at3.atmId = @"SB_1";
    at3.tr_amt = 1200;
    
    Atm_Trans *at4 = [[Atm_Trans alloc] init];
    at4.atmId = @"SB_1";
    at4.tr_amt = 800;
    
    Atm_Trans *at5 = [[Atm_Trans alloc] init];
    at5.atmId = @"SB_1";
    at5.tr_amt = 3200;
    
    Atm_Trans *at6 = [[Atm_Trans alloc] init];
    at6.atmId = @"ALH_1";
    at6.tr_amt = 4800;
    
    Atm_Trans *at7 = [[Atm_Trans alloc] init];
    at7.atmId = @"ALH_1";
    at7.tr_amt = 3300;
    
    Atm_Trans *at8 = [[Atm_Trans alloc] init];
    at8.atmId = @"ALH_1";
    at8.tr_amt = 2000;
    
    Atm_Trans *at9 = [[Atm_Trans alloc] init];
    at9.atmId = @"ALH_1";
    at9.tr_amt = 2500;
    
    Atm_Trans *at10 = [[Atm_Trans alloc] init];
    at10.atmId = @"ALH_1";
    at10.tr_amt = 1400;
    
    Atm_Trans *at11 = [[Atm_Trans alloc] init];
    at11.atmId = @"SB_3";
    at11.tr_amt = 3900;
    
    Atm_Trans *at12 = [[Atm_Trans alloc] init];
    at12.atmId = @"SB_2";
    at12.tr_amt = 1800;
    
    Atm_Trans *at13 = [[Atm_Trans alloc] init];
    at13.atmId = @"ALH_2";
    at13.tr_amt = 1900;
    
    Atm_Trans *at14 = [[Atm_Trans alloc] init];
    at14.atmId = @"SB_3";
    at14.tr_amt = 2100;
    
    Atm_Trans *at15 = [[Atm_Trans alloc] init];
    at15.atmId = @"SB_3";
    at15.tr_amt = 4100;
    
    Atm_Trans *at16 = [[Atm_Trans alloc] init];
    at16.atmId = @"SB_2";
    at16.tr_amt = 2600;
    
    Atm_Trans *at17 = [[Atm_Trans alloc] init];
    at17.atmId = @"ALH_2";
    at17.tr_amt = 1100;
    
    NSMutableArray *AtmTrans = [[NSMutableArray alloc] initWithObjects:at1,at2,at3,at4,at5,at6,at7,at8,at9,at10,at11,at12,at13,at14, nil];
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:AtmTrans];
    [[NSUserDefaults standardUserDefaults] setObject:myData forKey:@"AtmTrans"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Atm transaction data is stored.");
}

@end
