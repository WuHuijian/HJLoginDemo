//
//  NSArray+HJImages.h
//  HJExampleProjectDemo
//
//  Created by WHJ on 2018/2/8.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (HJImages)

+ (NSArray *)hj_imagesWithLocalGif:(NSString *)gifName;

+ (NSArray *)hj_imagesWithLocalGif:(NSString *)gifName expectSize:(CGSize)size;

@end
