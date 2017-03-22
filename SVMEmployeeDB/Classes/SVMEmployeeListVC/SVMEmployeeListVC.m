//
//  SVMEmployeeListVC.m
//  EmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMEmployeeListVC.h"

#import "SVMEmployee.h"
#import "SVMEmployeeCell.h"

#import "SVMEmployeeDetailsVC.h"

#import "SVMSharedSettings.h"
#import "SVMCoreDataHelper.h"

@interface SVMEmployeeListVC () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tvEmployeeList;
    
    NSArray *arrDatasource;
}
@end

@implementation SVMEmployeeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDatasource];
}

-(void)createDatasource {
    arrDatasource = [SVMCoreDataHelper getEmployeeDatabase];
    
    if (arrDatasource.count == 0) {
        NSArray *arrEmployeeDatabase = [SVMSharedSettings getEmployeeDatabaseJSONFromDisk];
        [SVMCoreDataHelper saveEmployeeDatabase:arrEmployeeDatabase];
        
        arrDatasource = [SVMCoreDataHelper getEmployeeDatabase];
    }
    
    [tvEmployeeList reloadData];
}

#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDatasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SVMEmployee *employee = arrDatasource[indexPath.row];
    
    SVMEmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVMEmployeeCell"];
    
    NSString *strName = [NSString stringWithFormat:@"%@ %@"
                         , employee.firstName
                         , employee.lastName];
    [cell.lblName setText:strName];
    
    [cell.lblDesignation setText:employee.designationTitle];
    if ([employee.designationTitle containsString:@"Developer"]) {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    }
    else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    [SVMSharedSettings downloadImageAtURL:employee.profileImageUrl
                             forImageView:cell.imgVProfilePic
                           withEmployeeID:employee.employeeID];
    
    return cell;
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    SVMEmployee *employee = arrDatasource[indexPath.row];
    [self performSegueWithIdentifier:@"segueSVMEmployeeDetailsVC"
                              sender:employee];
}

#pragma mark - UIStoryboard Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueSVMEmployeeDetailsVC"]) {
        SVMEmployeeDetailsVC *vc = segue.destinationViewController;
        vc.employee = sender;
    }
}

@end
