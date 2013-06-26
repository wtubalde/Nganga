//
//  ViewController.h
//  SQL
//
//  Created by Wenzel Jay Tubalde on 6/20/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "data.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableres;
- (IBAction)qbutton:(id)sender;

@end
