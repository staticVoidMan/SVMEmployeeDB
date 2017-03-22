//
//  SVMCoreDataHelper.m
//  SVMEmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMCoreDataHelper.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Employee+CoreDataProperties.h"

@implementation SVMCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    return context;
}

+(void)saveEmployeeDatabase:(NSArray *)array {    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSManagedObjectContext *context = [SVMCoreDataHelper managedObjectContext];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        Employee *employee = [[Employee alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        employee.employeeID         = obj[@"employee_id"];
        employee.firstName          = obj[@"first_name"];
        employee.lastName           = obj[@"last_name"];
        employee.profileImageUrl    = obj[@"profile_pic_url"];
        employee.designationTitle   = obj[@"designation_title"];
        employee.department         = obj[@"department"];
        
        NSError *error = nil;
        if([context save:&error] == NO) {
            NSLog(@"Unable to save: %@\nError:%@ %@"
                  , obj
                  , error
                  , error.localizedDescription);
        }
    }];
}

+(NSArray *)getEmployeeDatabase {
    NSManagedObjectContext *context = [SVMCoreDataHelper managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    NSError *error = nil;
    NSArray *arrEmployees = [context executeFetchRequest:request
                                                   error:&error];
    return arrEmployees;
}

@end
