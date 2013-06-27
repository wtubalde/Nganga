//
//  ViewController.m
//  SQL
//
//  Created by Wenzel Jay Tubalde on 6/20/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "FirstViewController.h"
#import <UIKit/UIKit.h>

@interface FirstViewController (){
    NSMutableArray *arrayOfData;
    sqlite3 *dataDB;
    NSString *dbPathString;
}

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    arrayOfData = [[NSMutableArray alloc]init];
    [[self tableres]setDelegate:self];
    [[self tableres]setDataSource:self];
    [self createOrOpenDB];
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    
}

-(void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"SETONE.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        if (sqlite3_open(dbPath, &dataDB)==SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PLANS (PLANID INTEGER PRIMARY KEY AUTOINCREMENT, PLANNAME TEXT, DATE INTEGER, COST REAL)";
            
            //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
            // const char *insert_stmt = [insertStmt UTF8String];
            
            sqlite3_exec(dataDB, sql_stmt, NULL, NULL, &error);
            //sqlite3_exec(dataDB, insert_stmt, NULL ,NULL , &error);
            //sqlite3_exec(dataDB, temp_stmt, NULL, NULL, &error);
            sqlite3_close(dataDB);
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfData count];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index     {
    return 1;
}

//formating results on table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cellType";
    NSString *dollars = @"$";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    mydata *aPlan = [arrayOfData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aPlan.planName ;
    NSString *costValue = [NSString stringWithFormat:@"%.2f", aPlan.cost];
    cell.detailTextLabel.text = [dollars stringByAppendingString:costValue];
    // cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", aPlan.cost];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //cell.textLabel.text = aPlan.date;
    //cell.accessoryView.backgroundColor =  [NSString stringWithFormat:@"TEST"];
    //NSString *testext = @"JAY";
    //UIImage *image = [UIImage imageNamed:@"icon.png"]; //or wherever you take your image from
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    //cell.accessoryView = @"";
    //[imageView release];
    
    
    return cell;
}

//adding data
-(IBAction)addPersonButton :(id)sender{
    /*
     char *error;
     if (sqlite3_open([dbPathString UTF8String], &dataDB)== SQLITE_OK) {
     
     
     //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,AGE) values ('%s', '%d')",[self.nameField.text UTF8String],[self.ageField.text intValue]];
     NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
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
     // Dispose of any resources that can be recreated.*/
}


//query
- (IBAction)qbutton:(id)sender {
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String],&dataDB)==SQLITE_OK) {
        [arrayOfData removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM PLANS"];
        const char* query_sql = [querySql UTF8String];
        
        if(sqlite3_prepare(dataDB, query_sql, -2, &statement, NULL)==SQLITE_OK){
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *PlanName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString  *costString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString   *Date    = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                mydata *plandata = [[mydata alloc]init];
                
                [plandata setPlanName:PlanName];
                [plandata setDate:Date];
                [plandata setCost:[costString floatValue]];
                
                [arrayOfData addObject:plandata];
            }
        }
    }
    [[self tableres]reloadData];
    
}

//CLoseKeyboard on touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event    {
    [super touchesBegan:touches withEvent:event];
}

//searching
//- (IBAction)search:(id)sender {
/*
 NSString *qsearch = searchField.text;
 sqlite3_stmt *statement;
 result.text = searchField.text;
 
 if (sqlite3_open([dbPathString UTF8String],&dataDB)==SQLITE_OK) {
 [arrayOfData removeAllObjects];
 
 
 NSString *nsquery = [[NSString alloc] initWithFormat:@"SELECT * FROM PERSONS WHERE NAME LIKE '%@'", qsearch];
 const char* query_sql = [nsquery UTF8String];
 if(sqlite3_prepare(dataDB, query_sql, -1, &statement, NULL)==SQLITE_OK){
 while (sqlite3_step(statement)==SQLITE_ROW) {
 NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
 NSString  *ageString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
 
 data *person = [[data alloc]init];
 
 [person setName:name];
 [person setAge:[ageString intValue]];
 
 [arrayOfData addObject:person];
 }
 }
 }
 [[self tableres]reloadData];*/
//}
@end
