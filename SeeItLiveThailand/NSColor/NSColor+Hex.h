//
//  NSColor+Hex.h
//
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSColor (Hex)

+ (NSColor*) colorWithCSS: (NSString*) css;
+ (NSColor*) colorWithHex: (NSUInteger) hex;

- (uint)hex;
- (NSString*)hexString;
- (NSString*)cssString;

@end
