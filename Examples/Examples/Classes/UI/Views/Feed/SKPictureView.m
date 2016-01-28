//
// Created by Hammer on 1/27/16.
// Copyright (c) 2016 奇迹空间. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "SKPictureView.h"
#import "Image.h"

static CGFloat const kSpace = 4;

@interface SKPictureView ()
@property(nonatomic, strong) NSArray *imageViews;
@end

@implementation SKPictureView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupViews];
  }
  return self;
}

- (void)setupViews {
}

- (void)updateConstraints {
  NSUInteger column = [self column:self.imageViews];
  CGFloat itemW = [self itemWidthData:self.data];
  CGFloat itemH = itemW;

  [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *_Nonnull imageView, NSUInteger idx, BOOL *_Nonnull stop) {
    NSUInteger columnIndex = idx % column;
    NSUInteger rowIndex = idx / column;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(@(rowIndex * (kSpace + itemH)));
      make.left.mas_equalTo(@(columnIndex * (kSpace + itemW)));
      make.width.mas_equalTo(@(itemW));
      make.height.mas_equalTo(@(itemH));
    }];
  }];
  [super updateConstraints];
}

- (void)setData:(NSArray *)data {
  _data = data;
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
  NSMutableArray *temp = [NSMutableArray new];
  [self.data enumerateObjectsUsingBlock:^(Image *image, NSUInteger idx, BOOL *stop) {
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    imageView.hidden = NO;
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:image.url placeholderImage:[UIImage imageNamed:@"avatar"]];
    [temp addObject:imageView];
  }];
  self.imageViews = [temp copy];

  [self updateConstraintsIfNeeded];
  [self setNeedsUpdateConstraints];
}

- (NSUInteger)column:(NSArray *)data {
  NSUInteger count = data.count;
  if (count <= 3 || count > 4) {
    return 3;
  }

  if (count == 4) {
    return 2;
  }
  return 1;
}

- (CGFloat)itemWidthData:(NSArray *)data {
  if (data.count == 1) {
    return 120;
  } else {
    return 80;
  }
}

- (CGFloat)height {
  NSUInteger count = self.data.count;
  NSUInteger row = count % 3 == 0 ? count / 3 : (count / 3 + 1);

  CGFloat itemW = [self itemWidthData:self.data];
  CGFloat itemH = itemW;

  return row * itemH + (row - 1) * kSpace;
}

- (CGFloat)width {
  NSUInteger column = [self column:self.imageViews];
  CGFloat itemW = [self itemWidthData:self.data];
  CGFloat itemH = itemW;

  return column * itemH + (column - 1) * kSpace;
}

@end