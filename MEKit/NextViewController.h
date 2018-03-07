//
//  NextViewController.h
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Block)(BOOL);

@interface NextViewController : UIViewController
@property (nonatomic, copy) Block block;
@property (nonatomic, strong) NSString *myString;

@end
