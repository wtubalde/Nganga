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
@synthesize searchField;

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

/****************Database Creation and Checking if Already Existing************/
-(void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"PLANS.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        if (sqlite3_open(dbPath, &dataDB)==SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PLANS (PLANID INTEGER PRIMARY KEY AUTOINCREMENT, PLANNAME TEXT, STARTDATE INTEGER, ENDINGDATE INTEGER,COST REAL, KWUSED INTEGER, DISCOUNTS INTEGER)";
            //const char *sql_stmt2 = "CREATE TABLE IF NOT EXISTS PLANDETAIL (DETAILID INTEGER PRIMARY KEY AUTOINCREMENT, PLANNAME TEXT, KWUSED INTEGER, PERFECTDISCOUT)";
            //const char *sql_insert = "INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')";
            //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
            // const char *insert_stmt = [insertStmt UTF8String];
            
            sqlite3_exec(dataDB, sql_stmt, NULL, NULL, &error);
            //sqlite3_exec(dataDB, sql_stmt2, NULL, NULL, &error);
            //sqlite3_exec(dataDB, sql_insert, NULL ,NULL , &error);
            //sqlite3_exec(dataDB, temp_stmt, NULL, NULL, &error);
            sqlite3_close(dataDB);
        }
    }
}



/***************Formating results on table****************/
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.textLabel.text = aPlan.date;
    //cell.accessoryView.backgroundColor =  [NSString stringWithFormat:@"TEST"];
    //NSString *testext = @"JAY";
    //UIImage *image = [UIImage imageNamed:@"icon.png"]; //or wherever you take your image from
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    //cell.accessoryView = @"";
    //[imageView release];
    
    
    return cell;
}

/************Getting info from tapped cellview**************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cellType";
   
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    mydata *aPlan2 = [arrayOfData objectAtIndex:indexPath.row];

    NSString *plan = aPlan2.planName;
   // NSString *startDate = [NSString stringWithFormat: @"%d", aPlan2.startDate];
    NSString *startDate = aPlan2.startDate;
    //NSString *endingDate = [NSString stringWithFormat: @"%d", aPlan2.endDate];
    NSString *endingDate = aPlan2.endDate;
    //NSString *costValue = [NSString stringWithFormat: @"%.2f", aPlan2.cost];
    NSString *discount = [NSString stringWithFormat:@"%d", aPlan2.discount];
    
    NSString *cellMessage = [NSString stringWithFormat: @"From %@ to %@\nPeak(####kWh) = $####\nOff Peak(####kWh) = $####\nSupply(####kWh) = $####\n\n%@\nRate Freeze - # - Day Time Use\n[Citipower Network]\nhttp://www.originenergy.com.au/******\nA %@%% discount of the energy usage charges will apply if your bill is paid by direct debit.", startDate, endingDate, plan, discount];

    //NSString *sentence = [NSString stringWithFormat: @"This is a story about a %@ dog and a %@ that was always high. They both lived in a %@ in the middle of nowhere. Today, the %@ %@ over the dog. The dog got angry and bit the %@ %@ times. The end.",adj,noun,place,noun,verb,noun,number];
    //storyTV.text = sentence;

    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 //initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    initWithTitle:@"Message" message:cellMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
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


- (IBAction)mysearch:(id)sender {
    
    NSString *qsearch = searchField.text;
    sqlite3_stmt *statement;
    //result.text = searchField.text;
    
    if (sqlite3_open([dbPathString UTF8String],&dataDB)==SQLITE_OK) {
        [arrayOfData removeAllObjects];
        
        
        NSString *nsquery = [[NSString alloc] initWithFormat:@"SELECT * FROM PLANS WHERE PLANNAME LIKE '%%%@%%'", qsearch];
        const char* query_sql = [nsquery UTF8String];
        
        if(sqlite3_prepare(dataDB, query_sql, -1, &statement, NULL)==SQLITE_OK){
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *PlanName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString  *costString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString   *StartDateString    = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *EndingDateString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *Discount = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                
                mydata *myquery = [[mydata alloc]init];
                
                [myquery setPlanName:PlanName];
                [myquery setStartDate:StartDateString];
                [myquery setCost:[costString floatValue]];
                [myquery setEndDate:EndingDateString];
                [myquery setDiscount:[Discount intValue]];
                
                //[person setAge:[ageString intValue]];
                
                [arrayOfData addObject:myquery];
            }
        }
    }
    [[self tableres]reloadData];
    label.text = @"Results:";
}

/***************Querying(Updating)****************/
- (IBAction)qbutton:(id)sender {
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String],&dataDB)==SQLITE_OK) {
        [arrayOfData removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM PLANS"];
        const char* query_sql = [querySql UTF8String];
        
        if(sqlite3_prepare(dataDB, query_sql, -1, &statement, NULL)==SQLITE_OK){
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *PlanName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString  *costString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString   *StartDateString    = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *EndingDateString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *Discount = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                
                mydata *plandata = [[mydata alloc]init];
                
                [plandata setPlanName:PlanName];
                [plandata setStartDate:StartDateString];
                [plandata setCost:[costString floatValue]];
                [plandata setEndDate:EndingDateString];
                [plandata setDiscount:[Discount intValue]];
                
                [arrayOfData addObject:plandata];
            }
        }
    }
    [[self tableres]reloadData];
   
    label.text = @"Updated!";
}

/*************CLoseKeyboard on touch***************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event    {
    [super touchesBegan:touches withEvent:event];
    [[self searchField]resignFirstResponder];
    //[[self costField]resignFirstResponder];
    //[[self plannameField]resignFirstResponder];
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:@"ReloadTableView" object:nil];
    }
    return self;
}



/***************searching Code******************/


@end


/*********Something**********/
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
 trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
 [[self navigationController] pushViewController:trailsController animated:YES];
 [trailsController release];
 }*/




/*********adding data Code***********/
/*- (IBAction)addDatabutton:(id)sender {
    
    
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &dataDB)== SQLITE_OK) {
        
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,STARTDATE,COST) values ('%s', '%s', '%d')",[self.plannameField.text UTF8String],[self.dateField.text UTF8String],[self.costField.text intValue]];
        //NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PLANS(PLANNAME,DATE,COST) values ('IngeniSUPER PLAN', '08-22-2013', '299.99')"];
        const char *insert_stmt = [insertStmt UTF8String];
        
        if (sqlite3_exec(dataDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Person Added");
            
            mydata *person  = [[mydata alloc] init];
            
            [person setPlanName:self.plannameField.text];
            [person setStartDate:self.dateField.text];
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
    // Dispose of any resources that can be recreated.
}*/





