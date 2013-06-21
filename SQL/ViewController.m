//
//  ViewController.m
//  SQL
//
//  Created by Wenzel Jay Tubalde on 6/20/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController (){
    NSMutableArray *arrayOfData;
    sqlite3 *dataDB;
    NSString *dbPathString;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayOfData = [[NSMutableArray alloc]init];
    [[self tableres]setDelegate:self];
    [[self tableres]setDataSource:self];
    [self createOrOpenDB];
    
}

- (void)createOrOpenDB{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString =[docPath stringByAppendingPathComponent:@"data.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        //create db here
        if (sqlite3_open(dbPath, &dataDB)==SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            sqlite3_exec(dataDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(dataDB);
            
        } 
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayOfData count];
}
//formating results on table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    data *aPerson = [arrayOfData objectAtIndex:indexPath.row];

    cell.textLabel.text = aPerson.name ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", aPerson.age];

    return cell;
}

//adding data
-(IBAction)addPersonButton :(id)sender{
    
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &dataDB)== SQLITE_OK) {
       
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS(NAME,AGE) values ('%s', '%d')",[self.nameField.text UTF8String],[self.ageField.text intValue]];
        const char *insert_stmt = [insertStmt UTF8String];
        
        if (sqlite3_exec(dataDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
             NSLog(@"Person Added");
                   
                   data *person  = [[data alloc] init];
                   
                   [person setName:self.nameField.text];
                [person setAge:[self.ageField.text intValue]];
                   
                   [arrayOfData addObject: person];
        }
    }
        sqlite3_close(dataDB);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)qbutton:(id)sender {
    
    
}


- (IBAction)deletePersonButton:(id)sender {
}
@end
