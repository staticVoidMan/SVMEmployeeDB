//
//  SVMEmployeeDetailsVC.m
//  SVMEmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMEmployeeDetailsVC.h"

#import "SVMSharedSettings.h"

@interface SVMEmployeeDetailsVC ()
{
    IBOutlet UILabel *lblEmployeeID;
    IBOutlet UILabel *lblEmployeeName;
    IBOutlet UILabel *lblDesignation;
    IBOutlet UILabel *lblDepartment;
    
    IBOutlet UIImageView *imgVProfileImage;
}
@end

@implementation SVMEmployeeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

-(void)updateUI {
    [lblEmployeeID setText:self.employee.employeeID];
    [lblEmployeeName setText:[NSString stringWithFormat:@"%@ %@"
                              , self.employee.firstName
                              , self.employee.lastName]];
    [lblDesignation setText:self.employee.designationTitle];
    [lblDepartment setText:self.employee.department];
    
    NSString *strProfileImageUrl = [self.employee.profileImageUrl stringByReplacingOccurrencesOfString:@"100x100"
                                                                                            withString:@"300x300"];    ;
    [SVMSharedSettings downloadImageAtURL:strProfileImageUrl
                             forImageView:imgVProfileImage
                           withEmployeeID:self.employee.employeeID];
}

@end
