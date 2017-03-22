//
//  SVMSharedSettings.m
//  SVMEmployeeDB
//
//  Created by Amin Siddiqui on 21/03/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMSharedSettings.h"

#import "SVMEmployee.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@implementation SVMSharedSettings

+(NSArray *)getEmployeeDatabaseJSONFromDisk {
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"employee" ofType:@"json"];
    
    NSError *error = nil;
    NSArray *arrEmployeeDatabase = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath]
                                                                   options:kNilOptions
                                                                     error:&error];
    return arrEmployeeDatabase;
}

+(void)downloadImageAtURL:(NSString *)strURL forImageView:(__weak UIImageView *)imageView withEmployeeID:(NSString *)strEmployeeID {
    //to track imageView incase cell is reused
    [imageView setImage:[UIImage imageNamed:@"default_profile_image"]];
    [imageView setAccessibilityIdentifier:strEmployeeID];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLSessionDownloadTask *download = [[NSURLSession sharedSession] downloadTaskWithURL:url
                                                                         completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                             if ([imageView.accessibilityIdentifier isEqualToString:strEmployeeID]) {
                                                                                 UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
                                                                                 
                                                                                 //Update image on main thread
                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                     [imageView setImage:image];
                                                                                 });
                                                                             }
                                                                             else {
                                                                                 NSLog(@"Discarding image as cell was reused");
                                                                             }
                                                                         }];
    [download resume];
}

@end
