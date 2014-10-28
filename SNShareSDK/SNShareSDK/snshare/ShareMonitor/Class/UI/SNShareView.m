//
//  SNShareView.m
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareView.h"
#import "SNShareManager.h"
#import "SNShareResModel.h"
#import "UIColor+VDColor.h"
#import "VDMacro.h"

@interface SNShareView ()

@property (nonatomic,weak) NSArray *itemsArray;

@end

@implementation SNShareView

@synthesize itemsArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView
{
    itemsArray = [SNShareManager sharedSNShareManager].resourceArray;
    int rows = (int)itemsArray.count / 3  + 1;
    int colos = (int)itemsArray.count%3;
    
    NSMutableArray *btns = [[NSMutableArray alloc] init];
    for (int i = 0; i < rows; i ++ ) {
        for (int j = 0; j < 3; j++) {
            
            if (i == rows-1 && j == colos) {
                break;
            }
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(46 + j*(50 + 39), 24+i*(50+41), 50, 50);
            btn.tag = i * 3 + j;
            SNShareResModel *model = [itemsArray objectAtIndex:i*3+j];
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png",model.img]] forState:UIControlStateNormal];
            //[btn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btns addObject:btn];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.origin.x - 5, btn.frame.origin.y + btn.frame.size.height + 5, 60, 22)];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.textColor = [UIColor colorWithARGB:0x555555];
            label.text = model.title;
            label.textAlignment = UITextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
        }
    }
    
    //取消
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    cancelBtn.frame = CGRectMake(0, self.frame.size.height - 44,self.frame.size.width, 44);
    cancelBtn.backgroundColor = [UIColor colorWithARGB:0x1f7eea];
    //[cancelBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
}

-(void)layoutSubviews
{
    
}

-(void)setDisplayType:(SNShareViewDisplayType)displayType
{
    _displayType = displayType;
    [self layoutSubviews];
}

@end
