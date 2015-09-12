//
//  mgModeCustomCell.h
//  ATM App
//
//  Created by Nikhil Anurag on 12/09/15.
//  Copyright (c) 2015 Nikhil Anurag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mgModeCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *atmNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
