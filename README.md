# PLGAlertView-Blocks
A category for UIAlertView and UIActionSheet, which can help you use block ranther than delegate to handle click events  
# How it Works
通过runtime我们可以动态的为分类添加一个数组，以block的形式响应事件，然后把控件的代理设置为self。之后在分类中实现代理方法，当点击事件发生的时候，从数组中取出响应事件，执行响应操作。
# Usage
首先，将分类加入项目，然后把分类UIAlertView+Block和UIActionSheet+Block的头文件导入项目
```
#import "UIAlertView+Block.h"
#import "UIActionSheet+Block.h"
```
当我们创建一个AlertView时我们可以使用下边的两种方法。  

创建一个UIAlertView：
```
UIAlertView *alertView = [UIAlertView alertViewWithTitle:@"提醒" message:@"确定退出" cancelButtonTitle:@"取消" cancelHandler:^{
  // 取消所做的操作
}];
[alertView addTitle:@"确定" handle:^{
// 点击确定所做的操作
}];
[alertView show];
```
创建UIActionSheet
```
UIActionSheet *sheet = [UIActionSheet actionSheetWithTitle:@"是否退出？" cancelButtonTitle:@"退出" cancelHandler:^{
//
} destructiveButtonTitle:@"其他" destructiveHandler:^{
//
}];
[sheet addTitle:@"退出" handle:^{
//
}];
[sheet showInView:self.view];
```
