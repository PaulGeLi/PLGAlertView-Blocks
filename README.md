# PLGAlertView-Blocks
A category for UIAlertView and UIActionSheet, which can help you use block ranther than delegate to handle click events  
# Usage
首先，将分类UIAlertView+Block和UIActionSheet+Block的头文件导入项目
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
