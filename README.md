# YBActionSheet

### 可自定义的样式
* 可自定义标题是否显示，有标题就显示没标题就不显示；
* 可自定义消息是否显示，有消息就显示没有显示就不显示；
* 可自定义取消按钮的显示，有取消按钮标题就显示没有就不显示；
* 可自定义ActionSheet左右两边的留白；默认为0
* 可自定义ActionSheet的圆角半径；默认为0
* 可自定义ActionSheet的最大高度于屏幕高度的占比；默认为0.8，当内容很多时就可以滑动；
* 可自定义点击灰色背景是否dismiss ActionSheet；默认为YES
* 可自定义点击列表中的每一项是否dismiss ActionSheet；默认为YES
* 当然最重要的是：可自定义ActionSheet每项列表中每一列的显示样式；

尽管配置项很多，但是使用起来相当方便。

### 代码结构
![代码结构](http://upload-images.jianshu.io/upload_images/1368996-8a3c3c5070bb9507.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* Core分组中的YBActionSheet是ActionSheet的核心，可以使用此部分来自定义你想要的任何样式的ActionSheet。

* PActionSheet是显示图片的ActionSheet。是在核心代码YBActionSheet的基础上封装出来的可直接使用的控件。

* PTActionSheet是图文混排的ActionSheet。也是在核心代码YBActionSheet的基础上封装出来的可直接使用的控件。

* TActionSheet是纯文本的ActionSheet。也是在核心代码YBActionSheet的基础上封装出来的可直接使用的控件。


**下面看一下我自定义的三种ActionSheet的样式**


1.纯图片 | 2.纯文本 | 3.图文混排
------------|-------------|----------------

![actionSheet2.gif](http://upload-images.jianshu.io/upload_images/1368996-9a123a5dc4946dd1.gif?imageMogr2/auto-orient/strip)


### 如果您觉得还不错请您留下您的Star，感谢您的鼓励
