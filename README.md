# CCPGestureLockView

#### 手势解锁

### DEMO GIF：

![gif](https://github.com/IMCCP/CCPGestureLockView/blob/master/CCPGestureLockView/CCPGestureLockView/gestureLock.gif)

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
 *  代理方法 比对成功后的回调
 */
```
\- (void)gestureLockView:(CCPGestureLockView *)gestureLockView successCodeString:(NSString *)successString;
```
