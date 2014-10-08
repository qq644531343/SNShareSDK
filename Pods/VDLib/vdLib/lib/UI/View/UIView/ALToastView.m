//
//  ALToastView.h
//
//  Created by libo libo on 17.07.13.
//  Copyright 2013 libo. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "ALToastView.h"

//toast的大小
#define ToastWidth 100.0f
#define ToastHeight 67

// Set visibility duration
static CGFloat kDuration = 2;

static BOOL enableRotation = NO;


// Static toastview queue variable
static NSMutableArray *toasts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@interface ALToastView ()

@property (nonatomic, readonly) UILabel *textLabel;

- (void)fadeToastOut;
+ (void)nextToastInView:(UIView *)parentView;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@implementation ALToastView

@synthesize textLabel = _textLabel;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

- (id)initWithText:(NSString *)text {
	if ((self = [self initWithFrame:CGRectZero])) {
		// Add corner radius
		self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
		self.layer.cornerRadius = 5.0f;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		
		// Init and add label
		_textLabel = [[UILabel alloc] init];
		_textLabel.text = text;
        _textLabel.numberOfLines = 2;
        _textLabel.clipsToBounds = YES;
		_textLabel.font = [UIFont systemFontOfSize:13];
		_textLabel.textColor = [UIColor whiteColor];
		_textLabel.adjustsFontSizeToFitWidth = NO;
		_textLabel.backgroundColor = [UIColor clearColor];
		//[_textLabel sizeToFit];
		
		[self addSubview:_textLabel];
		//_textLabel.frame = CGRectOffset(_textLabel.frame, (110 - _textLabel.frame.size.width)/2.0f, 27);
        
        CGSize textsize;
        if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0f) {
            textsize = [text sizeWithFont:_textLabel.font constrainedToSize:CGSizeMake(7*13, 100) lineBreakMode:NSLineBreakByCharWrapping];
        }else {
            textsize = [text sizeWithFont:_textLabel.font constrainedToSize:CGSizeMake(7*13, 100) lineBreakMode:NSLineBreakByWordWrapping];
        }
        
        float tmpheight = 0.0f;
        if (textsize.height <= 16.0f) {
            _textLabel.textAlignment = NSTextAlignmentCenter;
            tmpheight = 16.0f;
        }else {
            tmpheight = 32.0f;
            _textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        _textLabel.frame = CGRectMake((ToastWidth - 7*13)/2.0f, (ToastHeight - tmpheight)/2.0f, 7*13, tmpheight);
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotaion:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [self performSelector:@selector(layoutSubviews:) withObject:[NSNumber numberWithBool:NO] afterDelay:.1];
	}
	
	return self;
}

-(void)layoutSubviews:(BOOL)res {
    
//    if (enableRotation == NO) {
//        return;
//    }
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:res ? 0.25 : 0];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.height/2, 320/2 + self.tag);
    }else if(orientation == UIInterfaceOrientationPortrait) {
        self.center = CGPointMake(self.superview.center.x, self.superview.center.y + self.tag);
    }
    [UIView commitAnimations];
    
}


-(void)rotaion:(NSNotification *)noti {
    
//    if (enableRotation== NO) {
//        return;
//    }
    
    [self layoutSubviews:YES];
}

- (void)dealloc {
    
	[_textLabel release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
	[super dealloc];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text {
    return [self toastInView:parentView withText:text offSetY:0];
}

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text offSetY:(float)y
{
    // Add new instance to queue
	ALToastView *view = [[ALToastView alloc] initWithText:text];
    
	CGFloat lWidth = view.textLabel.frame.size.width;
	CGFloat lHeight = view.textLabel.frame.size.height;
	CGFloat pWidth = parentView.frame.size.width;
	CGFloat pHeight = parentView.frame.size.height;
	
	// Change toastview frame
	view.frame = CGRectMake((pWidth - lWidth - 20) / 2.,pHeight - lHeight - 60,
                            lWidth + 20,lHeight + 10);
    
    view.frame = CGRectMake(0 ,0 , ToastWidth, ToastHeight);
    view.center = CGPointMake(parentView.center.x, parentView.center.y);
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + y,
                            view.frame.size.width, view.frame.size.height);
    view.tag = y;
	view.alpha = 0.0f;
	
	if (toasts == nil) {
		toasts = [[NSMutableArray alloc] initWithCapacity:1];
		[toasts addObject:view];
		[ALToastView nextToastInView:parentView];
	}
	else {
		[toasts addObject:view];
	}
	
    [view release];
    return view;

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

- (void)fadeToastOut {
	// Fade in parent view
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction
     
                     animations:^{
                         self.alpha = 0.f;
                     }
                     completion:^(BOOL finished){
                         UIView *parentView = self.superview;
                         [self removeFromSuperview];
                         
                         // Remove current view from array
                         [toasts removeObject:self];
                         if ([toasts count] == 0) {
                             [toasts release];
                             toasts = nil;
                         }
                         else
                             [ALToastView nextToastInView:parentView];
                     }];
}

+(void)setDuration:(float)dat{
    kDuration = dat;
}

+(void)enableRotaion:(BOOL)rotaion {
    enableRotation = rotaion;
}

+ (void)nextToastInView:(UIView *)parentView {
    
    [self deleteArrayRepeat:toasts];
    
    if (parentView == nil && [toasts count] > 0) {
        [toasts removeAllObjects];
        [toasts release];
        toasts = nil;
        return;
    }
    
	if ([toasts count] > 0) {
        
        ALToastView *view = [toasts objectAtIndex:0];
        
		// Fade into parent view
		[parentView addSubview:view];
        
        [view layoutSubviews:NO];
        
        [UIView animateWithDuration:0.5  delay:0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             view.alpha = 1.0;
                         } completion:^(BOOL finished){}];
        
        // Start timer for fade out
        [view performSelector:@selector(fadeToastOut) withObject:nil afterDelay:[toasts count] > 1 ? 1.0f:kDuration];
    }
}

+(void)deleteArrayRepeat:(NSMutableArray *)array
{
    if (array.count <= 1) {
        return;
    }
    
    for (int i = (int)array.count - 1; i >= 0; i --) {
        NSString *str = [(ALToastView *)[array objectAtIndex:i] textLabel].text;
        for (int j = 0; j < i; j++) {
            if ([str isEqualToString:[(ALToastView *)[array objectAtIndex:j] textLabel].text]) {
                [[array objectAtIndex:j] textLabel].text = @"";
            }
        }
    }
    
    for (int i = 0; i < array.count; i++) {
        if ([[[array objectAtIndex:i] textLabel].text isEqualToString:@""]) {
            [array removeObjectAtIndex:i];
            i--;
        }
    }
}


@end
