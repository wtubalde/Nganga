//
//  GraphicsViewControllerView.m
//  CurrentEnrg
//
//  Created by Gov on 7/2/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "GraphicsViewControllerView.h"
#import <QuartzCore/QuartzCore.h>


@interface GraphicsViewControllerView (){
    int count;
    
}

@end

@implementation GraphicsViewControllerView



- (void)viewDidLoad
{
    [self viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // arrayOfData = [[NSMutableArray alloc]init];
   // [[self tableres]setDelegate:self];
   // [[self tableres]setDataSource:self];
    //[self createOrOpenDB];
   
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector: userInfo:nil repeats:YES];
    
    
}


- (id)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(drawRect:) userInfo:nil repeats:YES];
    }
    return self;
    
}


-(void) enumerateFont{
    for(NSString *familyName in [UIFont familyNames]){
        NSLog(@"Font Family = %@", familyName);}
}



-(void)onTimer {
    
//[[self tableres]reloadData];
//count++;
//NSString *val = count;
//_countlabel.text = [NSString stringWithFormat:@"%2f", count];
   
    //[[self tableres]reloadData];
    // count++;
    //NSString *val = count;
   _countlabel.text = [NSString stringWithFormat:@"%d", count++];
    //_countlabel
    //
    
}



-(void)drawRect:(CGRect)rect{
    
    
    //[NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    CGContextRef currentContext1 = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIColor *startColor = [UIColor redColor];
    CGFloat *startColorComponents =
    (CGFloat *)CGColorGetComponents([startColor CGColor]);
    
    UIColor *endColor = [UIColor yellowColor];
    CGFloat *endColorComponents =
    (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    UIColor *end1Color = [UIColor blueColor];
    CGFloat *end1ColorComponents =
    (CGFloat *)CGColorGetComponents([end1Color CGColor]);
    
    
    
    
    CGFloat colorComponents[12] = {
        
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3], /*first color blue*/
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3], /*second color green*/
        
        end1ColorComponents[0],
        end1ColorComponents[1],
        end1ColorComponents[2],
        end1ColorComponents[3],/*third color red*/
        
        
        
        
    };
    
    CGFloat colorIndices[3] = {
        0.0f, /*color 0 components in the array*/
        0.5f, /*color 1 components in the array*/
        1.0f,/*color 2 components in the array*/
        
    };
    
    CGGradientRef gradient =
    CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&colorComponents,(const CGFloat *)&colorIndices, 3);
    
    CGColorSpaceRelease(colorSpace);
    
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGPoint startPoint, endPoint;
    
    startPoint = CGPointMake(0,100);//CGPointMake(screenBounds.size.width, startPoint.y);
    
    endPoint = CGPointMake(0, 415);//CGPointMake(0.0f, screenBounds.size.height / 0.35f);
    
    CGContextDrawLinearGradient(currentContext1, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    
    
    
    float x;
    
    
    
    //[myString drawAtPoint:CGPointMake(20,80) withFont:helveticaBold];
    
    [[UIColor brownColor] set];
    
    
    for (x=0; x<=500; x+=10.5) {
        //        NSString *val =
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(currentContext, 1.3f);
        CGContextMoveToPoint(currentContext, 0.0f, x);
        CGContextAddLineToPoint(currentContext, 340.0f, x);
        CGContextStrokePath(currentContext);
        
        
    }
    
    
    
    
    //create indicator
    float indicatorData[] = {-200.0f, -10.0f, -15.0f, -20.0f, -30.0f, -40.0f, -50.0f, -150.0f};
    
    //for (int y=0; y < sizeof(indicatorData); y++){
        
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rectangle = CGRectMake(0.0f, 340.0f, 50.0f, 70.0f);
    
    CGAffineTransform transform1 = CGAffineTransformMakeTranslation(0.0f, count);
    
    CGPathAddRect(path, &transform1, rectangle);
    
    CGContextRef   currentContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(currentContext, path);
    
    [[UIColor colorWithRed:0.40f green:0.70f blue:0.66f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke];
    
    CGContextSetLineWidth(currentContext, 3.0f);
    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
        CGPathRelease(path);
    //Bezier path for indicator curve line
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(69, 237)
                                                            radius:30
                                                        startAngle:-155
                                                          endAngle:(7.0f/22.0f)
                                                         clockwise:NO];
        
        path1.lineCapStyle = kCGLineCapRound;
        path1.lineWidth = 4.0f;
        [[UIColor brownColor] setStroke];
        [path1 stroke];

       // }
    
    //create text inside indicator
    UIColor *magentaColor = [UIColor colorWithRed:0.0f
                                            green:0.0f
                                             blue:0.5f
                                            alpha:1.0f];
    [magentaColor set];
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
    NSString *myString = @"";
    [myString drawInRect:CGRectMake(0,340,50,70) withFont:helveticaBold];
    
    
    
    //create minimum kw and max kw labels
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0f
                                          green:1.0f
                                           blue:1.0f
                                          alpha:1.0f];
    [whiteColor set];
    UIFont *helveticaBold1 = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    NSString *myString2 = @"5kW";
    [myString2 drawInRect:CGRectMake(270,110,50,70) withFont:helveticaBold1];
    
    NSString *myString1 = @"0kW";
    [myString1 drawInRect:CGRectMake(270,345,50,70) withFont:helveticaBold1];
    
    
    
    
    
    
    //create header
    CGMutablePathRef headerPath = CGPathCreateMutable();
    
    CGRect header = CGRectMake(0.0f, 40.0f, 320.0f, 60.0f);
    
    CGPathAddRect(headerPath, NULL, header);
    
    CGContextRef   headerContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(headerContext, headerPath);
    
    [[UIColor colorWithRed:0.18f green:0.28f blue:0.23f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke ];
    
    CGContextSetLineWidth(headerContext, 0.3f);
    
    CGContextDrawPath(headerContext, kCGPathFillStroke);
    
    CGPathRelease(headerPath);
    
    
    //create footer
    
    CGMutablePathRef footerPath = CGPathCreateMutable();
    
    CGRect footer = CGRectMake(0.0f, 367.0f, 320.0f, 70.0f);
    
    CGPathAddRect(footerPath, NULL, footer);
    
    CGContextRef   footerContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(footerContext, footerPath);
    
    [[UIColor colorWithRed:0.18f green:0.28f blue:0.23f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke ];
    
    CGContextSetLineWidth(footerContext, 0.3f);
    
    CGContextDrawPath(footerContext, kCGPathFillStroke);
    
    CGPathRelease(footerPath);
    
    
    //footer yellow line bar
    [[UIColor yellowColor] set];
    CGContextRef footerlineContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(footerlineContext, 2.0f);
    CGContextMoveToPoint(footerlineContext, 0.0f, 370.0f);
    CGContextAddLineToPoint(footerlineContext, 340.0f, 370.0f);
    CGContextStrokePath(footerlineContext);
    
    
    
    
    //create footer tariff, footer reading labels
    
    UIColor *dirtywhiteColor = [UIColor colorWithRed:1.0f
                                               green:1.0f
                                                blue:1.0f
                                               alpha:1.0f];
    [dirtywhiteColor set];
    int z = 30;
    NSString *footerReading = [[NSString alloc ] initWithFormat:@"Peak: %d c/kWh", z ];
    [footerReading drawInRect:CGRectMake(115,370,150,70) withFont:helveticaBold];
    UIFont *helveticaBold2 = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    NSString *tariffLabel = @"current tariff in use";
    [tariffLabel drawInRect:CGRectMake(115,390,150,70) withFont:helveticaBold2];
   
    
    
    // create rotated text for indicator 
    
    
    CGContextRef   context1 = UIGraphicsGetCurrentContext();
    CGContextSelectFont(context1, "Helvetica", 15, kCGEncodingMacRoman);
    
    CGContextSetTextDrawingMode(context1, kCGTextFill);
    CGContextSetFillColorWithColor(context1, [[UIColor colorWithRed:1.0f green:1 blue:1 alpha:1.0] CGColor]);
    NSString *theText = @"";
    CGContextShowTextAtPoint(context1, 100, 100, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    CGContextSetTextMatrix(context1, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0), M_PI / 2));
    NSString *theText1 = @"currently using";
    CGContextShowTextAtPoint(context1, 10, 400, [theText1 cStringUsingEncoding:NSUTF8StringEncoding], [theText1 length]);
    CGContextSetTextMatrix(context1, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0), M_PI / 2));
    
    NSString *theText2 = @"$1110.00/h";
    CGContextShowTextAtPoint(context1, 30, 400, [theText2 cStringUsingEncoding:NSUTF8StringEncoding], [theText2 length]);
    CGContextSetTextMatrix(context1, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0), M_PI / 2));
    

    

    
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
