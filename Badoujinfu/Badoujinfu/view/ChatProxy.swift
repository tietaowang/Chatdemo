//
//  ViewController.swift
//  Badoujinfu
//
//  Created by pierre on 16/5/6.
//  Copyright © 2016年 pierre. All rights reserved.
//

import UIKit


class ChatProxy:AnyObject, AsyncSocketDelegate {
    
    var socket:AsyncSocket? ;
    
    class  var  ChatProxyShare:ChatProxy {
        
        struct Static {
            static  var onceToken: dispatch_once_t = 0
            static var instance: ChatProxy? = nil
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            Static.instance = ChatProxy()
        }
        return Static.instance!
    }
    
    func   start(){
        print("----ChatProxy  init----------")
        self.socket =   AsyncSocket.init(delegate: self)
        do{
            try self.socket!.connectToHost("192.168.11.124", onPort: 6482, withTimeout:10)
        }catch {
            
            print("----链接错误----------")
        }

    }
    
    init(){
        
        
  
    }
    
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("----链接成功-----------")
        sendms("wtt:88|5558|王铁涛")
        self.socket?.readDataWithTimeout(-1, tag: 0)
    }
    
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        var message = String.init(data: data, encoding: NSUTF8StringEncoding);
        print("----结束数据----------",  message)
        self.socket?.readDataWithTimeout(-1, tag: 0)
         NSNotificationCenter.defaultCenter().postNotificationName("messageNotification", object:message )
        
        // 发送通知 消息接收到消息
        
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            
//    
//       }
        
    }
    
    func sendms(msg: String) {
        var data = msg.dataUsingEncoding(NSUTF8StringEncoding) // "wtt:88|5558|王铁涛".dataUsingEncoding(NSUTF8StringEncoding)
        print("-发送信息---" ,msg)
        self.socket?.writeData(data, withTimeout: -1, tag: 0)
        
    }
}

