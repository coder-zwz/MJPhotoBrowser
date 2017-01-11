# MJPhotoBrowser高性能图片浏览器，支付本地图片、网络图片、gif图片
##在MJPhotoBrowser源码的基础上修复了以下bug：
###1.在放大图时会出现加载高清图的小圆圈progressView 表示进度。如果进入还未完成，点击图片意图隐藏此时的view时，会crash 
###2.图片放大时图片太靠近底部的问题  
###3.双击小图片手势冲突会闪动的问题 
###4.双击大图浏览图片根据手指位置计算zoomRect的调整 
###5.由于MBProgressHUD和SDWebImage的升级导致部分警告的问题
