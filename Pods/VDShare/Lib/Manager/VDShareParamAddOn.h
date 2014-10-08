/*!
 @header 
 @abstract VDShareParam的扩展字段，一些特殊要求，无法通用VDShareParam，添加一个扩展部分的字段<br />
 可以不设置
 */
#import <Foundation/Foundation.h>

@interface VDShareParamAddOn : NSObject

@property (nonatomic,retain) NSArray *picIDList;

@end
