//
//  SVMSharedSettings.h
//  SVMEmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SVMEmployee;
@class UIImageView;

@interface SVMSharedSettings : NSObject

+(NSArray *)getEmployeeDatabaseJSONFromDisk;
+(void)downloadImageAtURL:(NSString *)strURL forImageView:(__weak UIImageView *)imageView withEmployeeID:(NSString *)strEmployeeID;

@end
