//
//  ViewController.h
//  Version 2
//
//  Created by Wenzel Jay Tubalde on 6/27/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "mydata.h"

@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableres;

- (IBAction)qbutton:(id)sender;

@end
