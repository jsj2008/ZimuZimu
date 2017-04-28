//
//  PLPixelBuffer.h
//  PLMediaStreamingKit
//
//  Created by WangSiyu on 28/09/2016.
//  Copyright © 2016 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PLPixelBuffer : NSObject

@property(nonatomic, assign) CVPixelBufferRef pixelBuffer;

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
