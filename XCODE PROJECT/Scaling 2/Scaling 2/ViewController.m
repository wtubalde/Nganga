//
//  ViewController.m
//  Scaling 2
//
//  Created by Wenzel Jay Tubalde on 7/8/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sclaeaction:(id)sender {
    
        [_first resignFirstResponder];
        [_second resignFirstResponder];
        [_third resignFirstResponder];
        [_fourth resignFirstResponder];
        [_fifth resignFirstResponder];
    
    
    int a,b,c,d,e;
     a = [_first.text intValue];
     b = [_second.text intValue];
     c = [_third.text intValue];
     d = [_fourth.text intValue];
     e = [_fifth.text intValue];
    
    
    int myarray[] = {a,b,c,d,e};
    int temp=0;
    for (int count=0; count<5; count++) {
        if(myarray[count]>temp)
            temp=myarray[count];
    }

    int max = temp;
    //_label.text = [NSString stringWithFormat:@"%d", max];
    
    NSString *numberofchar = [NSString stringWithFormat:@"%d", max];
    //number = input.text;
    //int count = numberofchar.length;
    
    //_label.text = [NSString stringWithFormat:@"%d", count];
    
    if(max )
    
    
}
@end
