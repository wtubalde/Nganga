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
@synthesize label;
@synthesize tableres;

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
            //const char *sql_insert = "INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')";
            //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
            // const char *insert_stmt = [insertStmt UTF8String];
            
            sqlite3_exec(dataDB, sql_stmt, NULL, NULL, &error);
           // sqlite3_exec(dataDB, sql_insert, NULL ,NULL , &error);
            //sqlite3_exec(dataDB, temp_stmt, NULL, NULL, &error);
            sqlite3_close(dataDB);
        }
    }
}



//formating results on table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cellType";
    NSString *dollars = @"Cost - $";
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cellType";
   
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    mydata *aPlan = [arrayOfData objectAtIndex:indexPath.row];
    NSString *dollars = @"Cost - $hhhhhhhhhhjsdhjfhsdkjfksdhfkjhsdjkf\n --\n--hskjdhfkjsdhfjkshjkdfh";
    NSString *concat = @"";
    NSString *plan = aPlan.planName;
    NSString *date = aPlan.date;
    NSString *costValue = [NSString stringWithFormat:@"%.2f", aPlan.cost];
    

    
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 //initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    initWithTitle:plan message:[dollars stringByAppendingString:costValue] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
    trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:trailsController animated:YES];
    [trailsController release];
}*/




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

//querying
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
   
    
    label.text = @"Updated!";
}

//CLoseKeyboard on touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event    {
    [super touchesBegan:touches withEvent:event];
    [[self dateField]resignFirstResponder];
    [[self costField]resignFirstResponder];
    [[self plannameField]resignFirstResponder];
}

//adding data
- (IBAction)addDatabutton:(id)sender {
    
    
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &dataDB)== SQLITE_OK) {
        
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('%s', '%s', '%d')",[self.plannameField.text UTF8String],[self.dateField.text UTF8String],[self.costField.text intValue]];
        //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
        const char *insert_stmt = [insertStmt UTF8String];
        
        if (sqlite3_exec(dataDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Person Added");
            
            mydata *person  = [[mydata alloc] init];
            
            [person setPlanName:self.plannameField.text];
            [person setDate:self.dateField.text];
            [person setCost:[self.costField.text intValue]];
            
            [arrayOfData addObject: person];
        }
    }
    sqlite3_close(dataDB);
     [[self tableres]reloadData];
    label.text = @"Data Added";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.*/
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:@"ReloadTableView" object:nil];
    }
    return self;
}

- (void)reloadTableView:(NSNotification*)notification
{
    [tableres reloadData];
}



@end


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
