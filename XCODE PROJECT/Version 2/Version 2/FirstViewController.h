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
@property (weak, nonatomic) IBOutlet UILabel *label;
//- (IBAction)addDatabutton:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextField *plannameField;
//@property (weak, nonatomic) IBOutlet UITextField *dateField;
//@property (weak, nonatomic) IBOutlet UITextField *costField;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)mysearch:(id)sender;



@end
