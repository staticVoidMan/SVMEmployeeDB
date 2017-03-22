//
//  SVMCoreDataHelper.h
//  SVMEmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SVMCoreDataHelper : NSObject

+(NSManagedObjectContext *)managedObjectContext;
+(void)saveEmployeeDatabase:(NSArray *)array;
+(NSArray *)getEmployeeDatabase;

@end
