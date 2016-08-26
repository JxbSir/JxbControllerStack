# JxbControllerStack
ViewController dealloc check


#Cocoapods
```objc
pod 'JxbControllerStack', '~> 1.5'
```

#引入头文件
```objc
#import "JxbControllStackApi.h"
```


#开启监控
```objc
#if DEBUG
    [[JxbControllerStack sharedInstance] enable];
#endif
```

#当控制器释放是，请添加以下函数，请在基类中实现
```obcj
- (void)dealloc {
#if DEBUG
    [[JxbControllerStack sharedInstance] removeController:self.uniqueId onTabIndex:self.tabIndex];
#endif
}
```

#当检测到VC没有释放时，立即Pop错误
![](https://raw.githubusercontent.com/JxbSir/JxbControllerStack/master/1.jpg)
