# CCPGestureLockView

#### 手势解锁

### DEMO GIF：

![Image text](http://upload-images.jianshu.io/upload_images/1764698-5824042391011fb4.gif?imageMogr2/auto-orient/strip)

### DEMO 描述：
```
手势解锁
```
### DEMO方法介绍：
```
/**
 *  划线的宽度
 */
```
@property (nonatomic,assign) CGFloat lineWidth;
```
/**
 *  划线的颜色
 */
```
@property (nonatomic,strong) UIColor *lineColor;
```
/**
 *  需要匹配的密码字符串
 */
```
@property (nonatomic,copy) NSString *goalString;
```
/**
 *  获取手势密码
 */
```
@property (nonatomic, copy)void (^getCodeStringBlock)(NSString *codeString);
```
/**
 *  比对成功后的回调
 */
```
-- (void)gestureLockView:(CCPGestureLockView *)gestureLockView successCodeString:(NSString *)successString;
```
