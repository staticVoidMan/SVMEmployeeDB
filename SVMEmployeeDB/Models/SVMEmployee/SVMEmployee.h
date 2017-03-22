//
//  SVMEmployee.h
//  EmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVMEmployee : NSObject

@property (nonatomic, strong) NSString *employeeID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *designationTitle;
@property (nonatomic, strong) NSString *department;

@end
