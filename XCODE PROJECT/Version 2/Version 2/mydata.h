//
//  mydata.h
//  Version 2
//
//  Created by Wenzel Jay Tubalde on 6/27/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mydata : NSObject

@property(nonatomic, strong)NSString *planName;
@property(assign)int startDate;
@property(assign)int endDate;
@property(assign)float cost;
@property(assign)float kwUsed;
@property(assign)int discount;
@property(nonatomic, strong)NSString *details;


@end
