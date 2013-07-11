//
//  CplanViewController.h
//  Version 2
//
//  Created by Wenzel Jay Tubalde on 7/11/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "mydata.h"

@interface CPlanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableres;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end
