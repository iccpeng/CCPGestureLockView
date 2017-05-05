#import <UIKit/UIKit.h>
/** 图片的宽度 */
UIKIT_EXTERN CGFloat const imageWidthAndHeight;
/** 行数与列数*/
UIKIT_EXTERN NSInteger const rowAndColCount;
/** 左侧边距*/
UIKIT_EXTERN CGFloat const leftMargin;
/** 右侧边距*/
UIKIT_EXTERN CGFloat const rightMargin;
/** 右侧边距*/
UIKIT_EXTERN CGFloat const topMargin;
/** 最少的密码个数*/
UIKIT_EXTERN CGFloat const minNumCode;

typedef enum  {
    illegalSetting,//不合规定的设置
    differentSetting,//设置不同
} errorStyle;

#define CCPScreenH [UIScreen mainScreen].bounds.size.height
#define CCPScreenW [UIScreen mainScreen].bounds.size.width
#define buttonCount rowAndColCount * rowAndColCount
/**
 *  存储信息
 */
#define USERDEFAULTSET(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
/**
 *  取出value
 */
#define USERDEFAULTS(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

/**
 * 删除value
 */
#define USERDEFAULTREMOVE(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
/**
 *  立即同步
 */
#define USERDEFAULTSYNCHRONIZE  [[NSUserDefaults standardUserDefaults] synchronize]



