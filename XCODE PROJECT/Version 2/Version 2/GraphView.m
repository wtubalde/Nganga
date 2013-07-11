//
//  GraphView.m
//  Graph1
//
//  Created by Gov on 7/9/13.
//  Copyright (c) 2013 Openkit. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

float data[] = {0.58f,0.2f, 0.4f, 0.3f, 0.9f};



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



// draw bar

//, 0.85, 0.11, 0.75, 0.53, 0.75, 0.53, 0.44, 0.88, 0.77};

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    // Draw the background image
    // UIImage *image = [UIImage imageNamed:@"background.png"];
	//CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    //CGContextDrawImage(context, imageRect, image.CGImage);
    
    /*CGContextSetLineWidth(context, 0.6);
	CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    
    // How many lines?
    int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    
    // Here the lines go
    for (int i = 0; i <= howMany; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
		CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
		CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash*/
    
    
    
    
    
    
    
    
    //Draw the bars
    
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    for (int i=0; i < sizeof(data)/sizeof(float); i++)
    {
        
        float barX = kOffsetX + kStepX + i * kStepX - kBarWidth / 2;
        float barY = kBarTop + maxBarHeight - maxBarHeight * data[i];
        float barHeight = maxBarHeight * data[i];
        
        CGRect barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
        
        
        
        //Drawing graph average price label text
        
        CGContextRef context3 = UIGraphicsGetCurrentContext();
        CGContextSelectFont(context3, "Helvetica", 15, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context3, kCGTextFill);
        CGContextSetFillColorWithColor(context3, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
        NSString *theText6 = @"";
        CGContextShowTextAtPoint(context3, 80, 100, [theText6 cStringUsingEncoding:NSUTF8StringEncoding], [theText6 length]);
        CGContextSetTextMatrix (context3, CGAffineTransformMake(1.0, 0.0, 0.0, -0.9, 0.0, 0.0));
        NSString *theText7 = @"Per Day";
        CGContextShowTextAtPoint(context3, 1, 200, [theText7 cStringUsingEncoding:NSUTF8StringEncoding], [theText7 length]);
        
        NSString *theText8 = @"Per Day";
        CGContextShowTextAtPoint(context3, 65, 200, [theText8 cStringUsingEncoding:NSUTF8StringEncoding], [theText8 length]);
        
        NSString *theText9 = @"Per Day";
        CGContextShowTextAtPoint(context3, 130, 200, [theText9 cStringUsingEncoding:NSUTF8StringEncoding], [theText9 length]);
        
        NSString *theText10 = @"Per Day";
        CGContextShowTextAtPoint(context3, 195, 200, [theText10 cStringUsingEncoding:NSUTF8StringEncoding], [theText10 length]);
        
        CGContextRef context4 = UIGraphicsGetCurrentContext();
        CGContextSelectFont(context4, "Helvetica", 20, kCGEncodingMacRoman);
       
        NSString *theText11 = [NSString stringWithFormat:@"$%.2f", data[0]];
        CGContextShowTextAtPoint(context4, 3, 170, [theText11 cStringUsingEncoding:NSUTF8StringEncoding], [theText11 length]);
        
        NSString *theText12 = [NSString stringWithFormat:@"$%.2f", data[1]];
        CGContextShowTextAtPoint(context4, 70, 170, [theText12 cStringUsingEncoding:NSUTF8StringEncoding], [theText12 length]);
        
        NSString *theText13 = [NSString stringWithFormat:@"$%.2f", data[2]];
        CGContextShowTextAtPoint(context4, 135, 170, [theText13 cStringUsingEncoding:NSUTF8StringEncoding], [theText13 length]);
        
        NSString *theText14 = [NSString stringWithFormat:@"$%.2f", data[3]];
        CGContextShowTextAtPoint(context4, 195, 170, [theText14 cStringUsingEncoding:NSUTF8StringEncoding], [theText14 length]);
        NSString *theText15 = [NSString stringWithFormat:@"$%.2f", data[4]];
        CGContextShowTextAtPoint(context4, 260, 170, [theText15 cStringUsingEncoding:NSUTF8StringEncoding], [theText15 length]);
        CGContextSetTextMatrix(context4, CGAffineTransformRotate(CGAffineTransformMake(-1.0, 0.0, 0.0, -7.0, 0.0, 0.0), M_PI / 2));
        
       
        
        //Drawing graph titlelabel text
        
        CGContextRef context2 = UIGraphicsGetCurrentContext();
        CGContextSelectFont(context2, "Helvetica", 30, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context2, kCGTextFill);
        CGContextSetFillColorWithColor(context2, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor]);
        NSString *theText = @"";
        CGContextShowTextAtPoint(context2, 4, 300, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        CGContextSetTextMatrix(context2, CGAffineTransformRotate(CGAffineTransformMake(-1, 0.0, 0.0, 0.7, 0.0, 0.0), M_PI / 2));
        
        NSString *theText1 = @"2013";
        CGContextShowTextAtPoint(context2, 30, 315, [theText1 cStringUsingEncoding:NSUTF8StringEncoding], [theText1 length]);
        
        NSString *theText2 = @"WINTER";
        CGContextShowTextAtPoint(context2, 100, 280, [theText2 cStringUsingEncoding:NSUTF8StringEncoding], [theText2 length]);
        
        NSString *theText3 = @"MAY";
        CGContextShowTextAtPoint(context2, 166, 310, [theText3 cStringUsingEncoding:NSUTF8StringEncoding], [theText3 length]);
        
        NSString *theText4 = @"LAST WEEK";
        CGContextShowTextAtPoint(context2, 220, 240, [theText4 cStringUsingEncoding:NSUTF8StringEncoding], [theText4 length]);
        
        NSString *theText5 = @"TODAY";
        CGContextShowTextAtPoint(context2, 295, 290, [theText5 cStringUsingEncoding:NSUTF8StringEncoding], [theText5 length]);
        
        CGContextSetTextMatrix(context2, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -8.0, 0.0, 0.0), M_PI / 2));
        
        
        
        
        /* UIFont * font = [UIFont fontWithName:@"American Typewriter" size:60];
         CGFloat fontHeight = font.pointSize;
         CGFloat yOffset = (rect.size.height - fontHeight) / 2.0;
         
         CGRect textRect = CGRectMake(0, 190, 130, fontHeight);//(0, yOffset, rect.size.width, fontHeight);
         NSString * s = @"hello";
         [s drawInRect: textRect withFont: font lineBreakMode: UILineBreakModeClip
         alignment: UITextAlignmentCenter];*/
        
        
        /*UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
         radius:30
         startAngle:0
         endAngle:(22.0f/7.0f)
         clockwise:YES];
         
         path.lineCapStyle = kCGLineCapRound;
         path.lineWidth = 10.0f;
         [[UIColor blackColor] setStroke];
         [path stroke];*/
        
        
        
        
       CGContextSetBlendMode(context3, kCGBlendModeExclusion);
        [self drawBar:barRect context:context];
    }
    
}

- (void)drawBar:(CGRect)rect context:(CGContextRef)ctx
{
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    // Prepare the resources
    CGFloat components[12] = {0.9, 0.9, 0.9, 1,  // Start color
        0.9, 0.9, 0.9, 1, // Second color
        0.9, 0.9, 0.9, 1,}; // End color
    CGFloat locations[3] = {0.0, 0.33, 1.0};
    size_t num_locations = 3;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    // Create and apply the clipping path
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    // Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
    // Release the resources
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
}





@end
