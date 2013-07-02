//
//  GraphicsViewControllerView.m
//  CurrentEnrg
//
//  Created by Gov on 7/2/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "GraphicsViewControllerView.h"

@implementation GraphicsViewControllerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) enumerateFont{
    for(NSString *familyName in [UIFont familyNames]){
        NSLog(@"Font Family = %@", familyName);}
}



-(void)drawRect:(CGRect)rect{
    
    UIColor *magentaColor = [UIColor colorWithRed:0.0f
                                            green:0.0f
                                             blue:0.5f
                                            alpha:1.0f];
    [magentaColor set];
    
    
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    
    NSString *myString = @"Hope 8 gives u heal";
    [myString drawInRect:CGRectMake(160,80,150,150) withFont:helveticaBold];
    //[myString drawAtPoint:CGPointMake(20,80) withFont:helveticaBold];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
