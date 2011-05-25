#import "UIKit+KGOAdditions.h"


@implementation UIImage (KGOAdditions)

// fetch first matching image by override priority:
// local ipad assets (ipad/%@), local assets (%@), kurogo assets (kurogo/%@)
+ (UIImage *)imageWithPathName:(NSString *)pathName {
    UIImage *image = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"ipad/%@", pathName]];
    }
    if (!image) {
        image = [UIImage imageNamed:pathName];
    }
    if (!image) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"kurogo/%@", pathName]];
    }
    return image;
}

+ (UIImage *)blankImageOfSize:(CGSize)size
{
    // this is from the QuartzCache sample code for Mac OS X Tiger.
    // TODO: this seems to create noisy pixels
    
    int bitsPerComponent = 8;
    int componentsPerPixel = 4; // argb
    
    int bitsPerPixel = bitsPerComponent * componentsPerPixel;
    
    size_t bytesPerRow = ceil(bitsPerPixel * size.width / 32) * 4;
    size_t skipBytes = bytesPerRow - size.width * 4;
    size_t dataSize = bytesPerRow * size.height;
    unsigned char *data = malloc(dataSize);
    
    if (data == NULL) {
        return nil;
    }
    
    unsigned char *p = data;
    
    for (int i = 0; i < size.height; i++) {
        for (int j = 0; j < size.width; j++) {
            *p++ = 0x00; // A
            *p++ = 0xff; // R
            *p++ = 0xff; // G
            *p++ = 0xff; // B
        }
        p += skipBytes;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaFirst;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, dataSize, NULL);
    CGImageRef imageRef = CGImageCreate(size.width, size.height, bitsPerComponent, bitsPerPixel,
                                        bytesPerRow, colorSpace, bitmapInfo,
                                        provider, NULL, false, kCGRenderingIntentDefault);
    CFRelease(colorSpace);
    CFRelease(provider);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    free(data);
    
    return image;
}

@end

@implementation UIColor (KGOAdditions)

/* this function was borrowed for use at MIT from Ars Technica.
 * full source at https://github.com/ars/uicolor-utilities
 * modified in KGO to handle alpha channel using Android RRGGBBAA syntax
 *
 * acceptable formats are
 * @"0099FF" @"#0099FF" @"0x0099FF" @"AA0099FF" @"#AA0099FF" @"0xAA0099FF"
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString  
{  
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 - 8 characters
    if ([cString length] < 6) return nil;
    
    // strip 0X and # if they appear
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    NSUInteger length = [cString length];
    if (length != 6 && length != 8) return nil;
    
    NSRange range = NSMakeRange(0, 2);
    
    // get alpha if exists
    CGFloat alpha = 1.0f;
    if (length == 8) {
        unsigned int a;
        [[NSScanner scannerWithString:[cString substringWithRange:range]] scanHexInt:&a];
        alpha = (float) a / 255.0f;
        range.location += 2;
    }
    
    // Separate into r, g, b substrings
    NSString *rString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end

@implementation UIImageView (KGOAdditions)

- (void)showLoadingIndicator {
	self.animationImages = [NSArray arrayWithObjects:
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_01.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_02.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_03.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_04.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_05.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_06.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_07.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_08.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_09.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_10.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_11.png"],
							[UIImage imageWithPathName:@"common/loading-animation/iPhoneBusybox_12.png"],
							nil];
	
	[self startAnimating];
}

- (void)hideLoadingIndicator {
	[self stopAnimating];
	self.animationImages = nil;
}

@end


@implementation UILabel (KGOAdditions)

+ (UILabel *)multilineLabelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
	CGSize labelSize = [text sizeWithFont:font
                        constrainedToSize:CGSizeMake(width, 1000)
                            lineBreakMode:UILineBreakModeWordWrap];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, labelSize.height)] autorelease];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.backgroundColor = [UIColor clearColor];

    return label;
}

@end

@implementation UIWebView (KGOAdditions)

- (void)loadTemplate:(KGOHTMLTemplate *)template values:(NSDictionary *)values {
    NSString *htmlString = [template stringWithReplacements:values];
    [self loadHTMLString:htmlString baseURL:[template baseURL]];
}

@end


