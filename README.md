# MJPhotoBrowser高性能图片浏览器，支持本地图片、网络图片、gif图片
##在MJPhotoBrowser源码的基础上修复了以下bug：

###1.在放大图时会出现加载高清图的小圆圈progressView 表示进度。如果进入还未完成，点击图片意图隐藏此时的view时，会crash###
###2.图片放大时图片太靠近底部的问题###
###3.双击小图片手势冲突会闪动的问题###
###4.修复了双击图片可能会导致图片位移的问题### 
###5.由于MBProgressHUD和SDWebImage的升级导致部分警告的问题###

###主要功能:

![Image text](https://raw.githubusercontent.com/coder-zwz/MJPhotoBrowser/master/screenshots/Simulator0.png)

![Image text](https://raw.githubusercontent.com/coder-zwz/MJPhotoBrowser/master/screenshots/Simulator3.png)

####代码示例
```Objective-C

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 0.图片链接
    _urls = @[@"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg", @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg", @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg", @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg", @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    
	 // 1.创建9个UIImageView
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    CGFloat width = 80;
    CGFloat height = 80;
    CGFloat margin = 5;
    CGFloat startX = (self.view.frame.size.width - 3 * width - 2 * margin) * 0.5;
    CGFloat startY = 80;
    for (int i = 0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view addSubview:imageView];
        
        // 计算位置
        int row = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        // 下载图片
        [imageView setImageURLStr:_urls[i] placeholder:placeholder];
        
        // 事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = _urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
  
```
