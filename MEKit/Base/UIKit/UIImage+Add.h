//
//  UIImage+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/26.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (Add)

+ (nullable UIImage *)imageWithSmallGIFData:(NSData *)data scale:(CGFloat)scale;
+ (BOOL)isAnimatedGIFData:(NSData *)data;
+ (BOOL)isAnimatedGIFFile:(NSString *)path;
+ (nullable UIImage *)imageWithPDF:(id)dataOrPath;
+ (nullable UIImage *)imageWithPDF:(id)dataOrPath size:(CGSize)size;
+ (nullable UIImage *)imageWithEmoji:(NSString *)emoji size:(CGFloat)size;
+ (nullable UIImage *)imageWithColor:(UIColor *)color;
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (nullable UIImage *)imageWithSize:(CGSize)size drawBlock:(void(^)(CGContextRef context))drawBlock;
- (BOOL)hasAlphaChannel;

- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips;
- (nullable UIImage *)imageByResizeToSize:(CGSize)size;
- (nullable UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;
- (nullable UIImage *)imageByCropToRect:(CGRect)rect;
- (nullable UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(nullable UIColor *)color;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius;
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                    borderWith:(CGFloat)borderWitdth
                                   borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)imageByRoundCornerRadiusn:(CGFloat)radius
                                        corners:(UIRectCorner)corners
                                    borderWidth:(CGFloat)borderWidth
                                    borderColor:(nullable UIColor *)borderColor
                                 borderLineJoin:(CGLineJoin)borderLineJoin;

- (nullable UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;
- (nullable UIImage *)imageByRotateLeft90;
- (nullable UIImage *)imageByRotateRight90;
- (nullable UIImage *)imageByRotate180;
- (nullable UIImage *)imageByFlipVertical;
- (nullable UIImage *)imageByFlipHorizontal;

- (nullable UIImage *)imageByTintColor:(UIColor *)color;
- (nullable UIImage *)imageByGrayscales;

- (nullable UIImage *)imageByBlurSoft;
- (nullable UIImage *)imageByBlurLight;
- (nullable UIImage *)imageByBlurExtralLight;
- (nullable UIImage *)imageByBlurDark;
- (nullable UIImage *)imageByBlurWithTint:(UIColor *)tintColor;
- (nullable UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;

@end
NS_ASSUME_NONNULL_END
