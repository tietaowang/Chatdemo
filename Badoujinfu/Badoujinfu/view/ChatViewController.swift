//
//  ChatViewController.swift
//  Badoujinfu
//
//  Created by tietaowang on 16/5/17.
//  Copyright © 2016年 pierre. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate ,AsyncSocketDelegate{
    @IBOutlet weak var chatInput: UITextField!
    var  user:User!
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var chatTableView: UITableView!
    
    var sendArray = [(message : String,msgType:Int)]();
    
    var  srcFrame:CGPoint!
    
    var socket:AsyncSocket? ;
    

    required init?(coder aDecoder: NSCoder) {
        
      
       super.init(coder: aDecoder)
        
        print("----ChatProxy  init----------")
        self.socket =   AsyncSocket.init(delegate: self)
        do{
            
            try self.socket!.connectToHost("192.168.0.101", onPort: 8995, withTimeout:10)
        
        }catch {
        
            print("----链接错误----------")
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.estimatedRowHeight = 80;
        self.chatTableView.rowHeight = UITableViewAutomaticDimension;
        self.chatTableView.backgroundColor = UIColor.yellowColor()

        self.srcFrame = self.view.frame.origin
        self.chatTableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        self.chatInput.returnKeyType =  UIReturnKeyType.Send
        self.chatInput.delegate = self;
        self.chatTableView.dataSource = self;
        self.chatTableView.delegate = self;
        self.chatTableView.registerNib(Utils.getNIB("ChatCell"), forCellReuseIdentifier: "ChatCell")
    
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardShow:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
     var tapGecognizer =   UITapGestureRecognizer.init(target: self, action: "hiddenKeyboard")
        ///Users/tietaowang/Downloads/wcaht/WebContent
        self.chatTableView.addGestureRecognizer(tapGecognizer)
       
        
    }
    func  hiddenKeyboard(){
        UIApplication.sharedApplication().keyWindow?.endEditing(true)

    }
    
    func keyboardShow(notification:NSNotification)
    {
        var dic:NSDictionary  =  notification.userInfo!
        var size =  dic.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue.size
            keyBoardView.frame.origin.y = keyBoardView.frame.origin.y - size!.height
      
        
    }
    func keyboardHide(notification:NSNotification){
        var dic:NSDictionary  =  notification.userInfo!
        var size =  dic.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue.size
          keyBoardView.frame.origin.y = keyBoardView.frame.origin.y + size!.height
       }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return sendArray.count;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let  cell:ChatCell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell;
        
           var yunzu =   self.sendArray[ indexPath.row ]
            if(yunzu.msgType == 0){
                cell.serverPortrailts.alpha = 0;
                cell.serverPortrailts.hidden = true
            }else{
                  cell.mePortrailts.alpha = 0;
                 cell.mePortrailts.hidden = true
             }
           cell.msgType = yunzu.msgType
            cell.chatInfo.text =  yunzu.message
        cell.backgroundColor = UIColor.redColor()
     
     
        return cell;
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        // wtt:88 协议
        sendms("wtt:88|"+user.account+"|"+user.name+"|"+textField.text!)
    
        self.sendArray.append((message: textField.text!, msgType: 0))
        self.chatTableView.beginUpdates()
       
        self.chatTableView.insertRowsAtIndexPaths([NSIndexPath.init(forRow: self.sendArray.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.chatTableView.endUpdates();
        return true;
    }
//    
     override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
    
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("----链接成功-----------")
        sendms("wtt:88|"+user.account+"|"+user.name+"|")
        self.socket?.readDataWithTimeout(-1, tag: 0)
    }
    
 
    
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        
      
        let message = String.init(data: data , encoding: NSUTF8StringEncoding)!
     
        self.socket?.readDataWithTimeout(-1, tag: 0)

        self.sendArray.append((message: message , msgType: 1))
        
        self.chatTableView.beginUpdates()
        
        self.chatTableView.insertRowsAtIndexPaths([NSIndexPath.init(forRow: self.sendArray.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.chatTableView.endUpdates();

      
        
    }
    
    func sendms(msg: String) {
        var data = msg.dataUsingEncoding(NSUTF8StringEncoding) // "wtt:88|5558|王铁涛".dataUsingEncoding(NSUTF8StringEncoding)
        print("-发送信息---" ,msg)
        self.socket?.writeData(data, withTimeout: -1, tag: 0)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
         UIApplication.sharedApplication().keyWindow?.endEditing(true)
 
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){


    }

}