# RZFlowButtonView
A view with flowlayout buttons to click.

App搜索页面经常用到关键词提示,例如手机淘宝的【历史搜索】，网易云音乐的【热门搜索】。为了方便使用，我写了一个可以流式布局按钮的view并封装。

【文末附运行效果及demo】

### 思考
1.需要哪些样式？

* 按钮带圆角，有边框；
* 按钮宽度根据标题长度自适应；
* 按钮之间可以调整间距。

2.流式布局的核心是什么？

* 核心逻辑：当 当前按钮宽度在视图水平方向放得下时就把按钮添加在当前水平方向，当 当前按钮宽度在视图水平方向放不下时就换一行添加。

### 实现

1. 自定义一个view，view上的按钮根据传进来的关键词数组循环创建。
2. 将上一个按钮做标记，创建当前按钮时根据上一个按钮的位置设置当前按钮位置。
~~~
if (i == 0) {
btn.frame = CGRectMake(self.padding, self.padding, rect.size.width + 15, rect.size.height + 15);
}else {
CGFloat leftWidth = CGRectGetWidth(self.frame) - btnPrev.frame.origin.x - btnPrev.frame.size.width - self.padding * 2;
if (leftWidth > rect.size.width) {
btn.frame = CGRectMake(CGRectGetMaxX(btnPrev.frame) + self.padding, btnPrev.frame.origin.y, rect.size.width + 15, rect.size.height + 15);
}else {
btn.frame = CGRectMake(self.padding, CGRectGetMaxY(btnPrev.frame) + self.padding, rect.size.width + 15, rect.size.height + 15);
}
}
~~~
3. 利用layer设置按钮圆角、边框等样式。

~~~
btn.layer.cornerRadius = 12;
btn.layer.masksToBounds = YES;
btn.layer.borderWidth = 1;
btn.layer.borderColor = self.borderColor.CGColor;
~~~

4. 标记按钮，利用block（也可以选择代理）将按钮作为参数传出,进行点击事件操作。
~~~
- (void)onBtnClick:(UIButton *)btn {
if (self.clickBlock) {
self.clickBlock(btn);
}
}
~~~

### 注意
1. view的高度在创建完最后一个按钮后才能确定，所以在for循环中别忘了最后设置一下view的高度。
~~~
//最后一个按钮时设置视图高度
if (i == self.words.count - 1) {
CGRect aRect = self.frame;
aRect.size.height = CGRectGetMaxY(btn.frame) + 10;
self.frame = aRect;
}
~~~
2. 为了更方面使用，封装view时可以留出属性接口方便对其设置。
~~~
/* 可单独设置样式,不设置则为默认样式
* words 词汇数组
* btnColor 按钮背景色
* titleColor 文字颜色
* borderColor 按钮边框颜色
* padding 按钮间隔
* wordHeight 词汇高度
* fontSize 字体大小
*/
@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) UIColor *btnColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat wordHeight;
@property (nonatomic, assign) CGFloat fontSize;
~~~
3. 你也可以在自定义view时的初始化方法中添加好默认设置，如果使用时不想过多设置，可以使用默认效果。
~~~
//初始化:默认设置
- (instancetype)init {
if (self = [super init]) {
self.btnColor = [UIColor whiteColor];
self.titleColor = [UIColor blackColor];
self.borderColor = [UIColor lightGrayColor];
self.padding = 10;
self.wordHeight = 25;
self.fontSize = 15;
}
return self;
}
~~~
4. 在block中将button作为唯一参数即可，标题可以通过button.currentTitle获取，拿到button可以做的事情更多，例如改变选中按钮的颜色等等。
~~~
- (void)onBtnClick:(UIButton *)btn {
if (self.clickBlock) {
self.clickBlock(btn);
}
}
~~~

![效果](https://github.com/RachalZhou/MarkdownPhotos/blob/master/hotSearch.png?raw=true)
[完整demo](https://github.com/RachalZhou/RZFlowButtonView)
### 总结
这个效果只要理解了**流式布局**的核心逻辑，处理起来就很简单了。最后为了方便使用，封装时注意一些细节即可。
