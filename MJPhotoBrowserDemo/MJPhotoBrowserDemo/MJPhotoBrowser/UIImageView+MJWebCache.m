//
//  UIImageView+MJWebCache.m
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "UIImageView+MJWebCache.h"

@implementation UIImageView (MJWebCache)
- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder
                     options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)setImageURLStr:(NSString *)urlStr placeholder:(UIImage *)placeholder
{
    [self setImageURL:[NSURL URLWithString:urlStr]
          placeholder:placeholder];
}
@end
