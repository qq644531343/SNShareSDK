#import <UIKit/UIKit.h>

//简化，直接设置不透明，半透明，全透明
typedef enum {
    eVDShareWindowStyleNone,
    eVDShareWindowStyleHalfTransparent,
    eVDShareWindowStyleWholeTransparent,
} eVDShareWindowStyle;

//接口部分，用来处理一些动画之类的需求
@protocol VDShareWindowDelegate <NSObject>
@optional
-(void) onLoad;
-(void) onShow;
-(void) onRemove;

@end

@interface VDShareWindow : UIWindow
{}
@property (nonatomic,retain) UIView *innerView;
@property (nonatomic,retain) id<VDShareWindowDelegate> dele;

-(void) appendView:(UIView *) view;
-(void) setDelegate:(id<VDShareWindowDelegate>) delegate;


- (void) setWindowStyle:(eVDShareWindowStyle) style;

- (void) show;
- (void) dismiss;

@end
