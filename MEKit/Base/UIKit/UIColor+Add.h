//
//  UIColor+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/26.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
// HSL H:色相  S:饱和度  L:明亮度
extern void YY_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *l);

extern void YY_HSL2RGB(CGFloat h, CGFloat s, CGFloatl,
                       CGFloat *r, CGFloat *g, CGFloat *b);

// HSB H:色相  S:饱和度  B:明亮度
extern void YY_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *v);

extern void YY_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void YY_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                        CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);

extern void YY_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                        CGFloat *r, CGFloat *g, CGFloat *b);

extern void YY_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                       CGFloat *hh, CGFloat *ss, CGFloat *ll);

extern void YY_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *hh, CGFloat *ss, CGFloat *bb);

#ifdef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif


@interface UIColor (Add)




@end
NS_ASSUME_NONNULL_END
