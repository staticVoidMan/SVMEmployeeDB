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
        
        NSManagedObject *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee"
                                                                  inManagedObjectContext:context];
        
        [employee setValue:obj[@"employee_id"]          forKey:@"employeeID"];
        [employee setValue:obj[@"first_name"]           forKey:@"firstName"];
        [employee setValue:obj[@"last_name"]            forKey:@"lastName"];
        [employee setValue:obj[@"profile_pic_url"]      forKey:@"profileImageUrl"];
        [employee setValue:obj[@"designation_title"]    forKey:@"designationTitle"];
        [employee setValue:obj[@"department"]           forKey:@"department"];
        
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
