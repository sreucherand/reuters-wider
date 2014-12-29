//
//  CSAttributedLabel.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 02/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAttributedLabel.h"

#import <QuartzCore/QuartzCore.h>
#import <Availability.h>
#import <objc/runtime.h>

static inline NSAttributedString * NSAttributedStringBySettingColorFromContext(NSAttributedString *attributedString, UIColor *color) {
    if (!color) {
        return attributedString;
    }
    
    NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
    
    [mutableAttributedString enumerateAttribute:(NSString *)kCTForegroundColorFromContextAttributeName inRange:NSMakeRange(0, [mutableAttributedString length]) options:0 usingBlock:^(id value, NSRange range, __unused BOOL *stop) {
        BOOL usesColorFromContext = (BOOL)value;
        if (usesColorFromContext) {
            [mutableAttributedString setAttributes:[NSDictionary dictionaryWithObject:color forKey:(NSString *)kCTForegroundColorAttributeName] range:range];
            [mutableAttributedString removeAttribute:(NSString *)kCTForegroundColorFromContextAttributeName range:range];
        }
    }];
    
    return mutableAttributedString;
}

static inline CGSize CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints(CTFramesetterRef framesetter, NSAttributedString *attributedString, CGSize size, NSUInteger numberOfLines) {
    CFRange rangeToSize = CFRangeMake(0, (CFIndex)[attributedString length]);
    CGSize constraints = CGSizeMake(size.width, CGFLOAT_MAX);
    
    if (numberOfLines == 1) {
        constraints = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    } else if (numberOfLines > 0) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0.0f, 0.0f, constraints.width, CGFLOAT_MAX));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
        
        if (CFArrayGetCount(lines) > 0) {
            NSInteger lastVisibleLineIndex = MIN((CFIndex)numberOfLines, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            rangeToSize = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        
        CFRelease(frame);
        CFRelease(path);
    }
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, rangeToSize, NULL, constraints, NULL);
    
    return CGSizeMake(ceil(suggestedSize.width), ceil(suggestedSize.height));
}

@interface CSAttributedLabel ()

@property (strong, nonatomic) NSArray *links;
@property (strong, nonatomic) NSTextCheckingResult *activeLink;
@property (strong, nonatomic) NSDictionary *attributes;

@property (copy, nonatomic) NSAttributedString *renderedAttributedText;

@end

@implementation CSAttributedLabel {
@private
    BOOL _needsFramesetter;
    CTFramesetterRef _framesetter;
    CGPoint _middlePoint;
}

@synthesize attributedText = _attributedText;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    
    self.links = [NSArray array];
}

- (void)dealloc {
    if (_framesetter) {
        CFRelease(_framesetter);
    }
}

#pragma mark - Display

- (void)layoutSubviews {
    [super layoutSubviews];

    self.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
    
    [super layoutSubviews];
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [mutableAttributedString addAttributes:self.attributes range:NSMakeRange(0, [self.attributedText length])];
    
    self.attributedText = mutableAttributedString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Attributes

- (NSDictionary *)attributes {
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
    [mutableAttributes setObject:self.font forKey:(NSString *)kCTFontAttributeName];
    [mutableAttributes setObject:self.textColor forKey:(NSString *)kCTForegroundColorAttributeName];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineSpacing = 0;
    paragraphStyle.minimumLineHeight = self.lineHeight;
    paragraphStyle.maximumLineHeight = self.lineHeight;
    
    if (self.numberOfLines == 1) {
        paragraphStyle.lineBreakMode = self.lineBreakMode;
    } else {
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    [mutableAttributes setObject:paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
    
    return [NSDictionary dictionaryWithDictionary:mutableAttributes];
}

#pragma mark - Text methods

- (void)setText:(NSString *)text {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:self.attributes];
    
    self.attributedText = mutableAttributedString;
}

- (void)setAttributedText:(NSAttributedString *)string {
    if ([string isEqualToAttributedString:_attributedText]) {
        return;
    }
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[(.*?)\\]\\((\\S+)(\\s+(\"|\')(.*?)(\"|\'))?\\)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regex matchesInString:[string string] options:0 range:NSMakeRange(0, [string length])];
    
    for (NSTextCheckingResult *result in results) {
        NSString *title = [[string string] substringWithRange:[result rangeAtIndex:1]];
        NSString *url = [[string string] substringWithRange:[result rangeAtIndex:2]];
        
        [mutableString replaceCharactersInRange:result.range withString:title];
        [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(result.range.location, [result rangeAtIndex:1].length)];
        
        [self addLinkToURL:[NSURL URLWithString:url] withRange:NSMakeRange(result.range.location, [result rangeAtIndex:1].length)];
    }
    
    [super setAttributedText:mutableString];
    
    _attributedText = [mutableString copy];
    
    [self setNeedsFramesetter];
    [self setNeedsDisplay];
}

- (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    
    [self setNeedsDisplay];
}

- (NSAttributedString *)renderedAttributedText {
    if (!_renderedAttributedText) {
        self.renderedAttributedText = NSAttributedStringBySettingColorFromContext(self.attributedText, self.textColor);
    }
    
    return _renderedAttributedText;
}

#pragma mark - Framesetter

- (void)setNeedsFramesetter {
    self.renderedAttributedText = nil;
    
    _needsFramesetter = YES;
}

- (CTFramesetterRef)framesetter {
    if (_needsFramesetter) {
        @synchronized(self) {
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.renderedAttributedText);
            
            [self setFramesetter:framesetter];
            
            _needsFramesetter = NO;
            
            if (framesetter) {
                CFRelease(framesetter);
            }
        }
    }
    
    return _framesetter;
}

- (void)setFramesetter:(CTFramesetterRef)framesetter {
    if (framesetter) {
        CFRetain(framesetter);
    }
    
    if (_framesetter) {
        CFRelease(_framesetter);
    }
    
    _framesetter = framesetter;
}

#pragma mark - Characters location

- (NSTextCheckingResult *)linkAtPoint:(CGPoint)point {
    return [self linkAtCharacterIndex:[self characterIndexAtPoint:point]];
}

- (NSTextCheckingResult *)linkAtCharacterIndex:(CFIndex)idx {
    NSEnumerator *enumerator = [self.links reverseObjectEnumerator];
    NSTextCheckingResult *result = nil;
    
    while ((result = [enumerator nextObject])) {
        if (NSLocationInRange((NSUInteger)idx, result.range)) {
            return result;
        }
    }
    
    return nil;
}

- (CFIndex)characterIndexAtPoint:(CGPoint)p {
    if (!CGRectContainsPoint(self.bounds, p)) {
        return NSNotFound;
    }
    
    CGRect textRect = (CGRect){.origin=CGPointZero, .size=CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints([self framesetter], self.attributedText, self.bounds.size, self.numberOfLines)};
    
    if (!CGRectContainsPoint(textRect, p)) {
        return NSNotFound;
    }
    
    p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y);
    p = CGPointMake(p.x, textRect.size.height - p.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    CTFrameRef frame = CTFramesetterCreateFrame([self framesetter], CFRangeMake(0, 0), path, NULL);
    
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    CFIndex idx = NSNotFound;
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = (CGFloat)floor(lineOrigin.y - descent);
        CGFloat yMax = (CGFloat)ceil(lineOrigin.y + ascent);
        
        if (p.y > yMax) {
            break;
        }
        
        if (p.y >= yMin) {
            if (p.x >= lineOrigin.x && p.x <= lineOrigin.x + width) {
                _middlePoint = CGPointMake(p.x, textRect.size.height-yMax+(yMax-yMin)/2);
                CGPoint relativePoint = CGPointMake(p.x - lineOrigin.x, p.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range {
    NSMutableArray *mutableLinks = [NSMutableArray arrayWithArray:self.links];
    
    [mutableLinks addObject:[NSTextCheckingResult linkCheckingResultWithRange:range URL:url]];
    
    self.links = [NSArray arrayWithArray:mutableLinks];
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    self.activeLink = [self linkAtPoint:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.activeLink) {
        UITouch *touch = [touches anyObject];
        
        if (self.activeLink != [self linkAtPoint:[touch locationInView:self]]) {
            self.activeLink = nil;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.activeLink) {
        NSTextCheckingResult *result = self.activeLink;
        self.activeLink = nil;
        
        if ([self.delegate respondsToSelector:@selector(didSelectLinkWithURL:atPoint:)]) {
            [self.delegate performSelector:@selector(didSelectLinkWithURL:atPoint:) withObject:result.URL withObject:[NSValue valueWithCGPoint:_middlePoint]];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.activeLink) {
        self.activeLink = nil;
    }
}

@end