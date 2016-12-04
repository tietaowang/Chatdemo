//
//  CocoaAsyncSocket.h
//  CocoaAsyncSocket
//
//  Created by Derek Clarkson on 10/08/2015.
//  Copyright © 2015 Robbie Hanson. All rights reserved.
//

@import Foundation;

//! Project version number for CocoaAsyncSocket.
FOUNDATION_EXPORT double cocoaAsyncSocketVersionNumber;

//! Project version string for CocoaAsyncSocket.
FOUNDATION_EXPORT const unsigned char cocoaAsyncSocketVersionString[];
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"


NSData* getData(){
    NSString *requestStrFrmt =  @"发送到服务端数据";
 
    NSData *requestData = [requestStrFrmt dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    Byte *testByte = (Byte *)[requestData bytes];
    
    
    
    Byte bytes[requestData.length+1];
    
    for(int i=0;i<[requestData length];i++){
        
        bytes[i]=testByte[i];
        
    }
    
    bytes[requestData.length]=0;
    
    
    
    
    
    NSData *adata = [[NSData alloc] initWithBytes:bytes length:requestData.length+1];
    return adata;
}



