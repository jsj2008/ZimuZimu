//
//  ZMSocketManager.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMSocketManager.h"
#import "GCDAsyncSocket.h"

@interface ZMSocketManager ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation ZMSocketManager

- (void)startConnect{
    // 1.与服务器通过三次握手建立连接
    NSString *host = @"192.168.3.10";
    int port = 8082;
    //创建一个socket对象
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    //连接
    
    NSError *error = nil;
    [_socket connectToHost:host onPort:port error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendMsh) userInfo:nil repeats:YES];
}
static int i = 0;
- (void)sendMsh{
    i = 5;
    NSData *data = [@"收到了吗" dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:2 tag:i];
}
#pragma mark -socket的代理
#pragma mark 连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功%s",__func__);
}
#pragma mark 断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSString *host = @"192.168.3.10";
    int port = 8082;
    
    NSError *error = nil;
    [_socket connectToHost:host onPort:port error:&error];
    if (error) {
        NSLog(@"%@",error);
    }

    if (err) {
        NSLog(@"连接失败");
    }else{
        NSLog(@"正常断开");
    }
}
#pragma mark 数据发送成功
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%s -- tag %i",__func__, i);
    
    [sock disconnect];
//    [self startConnect];
    //发送完数据手动读取，-1不设置超时
//    [sock readDataWithTimeout:-1 tag:tag];
}
#pragma mark 读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%s %@",__func__,receiverStr);
}
@end
