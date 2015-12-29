//
//  mainViewController.swift
//  深大课程表
//
//  Created by 赵希帆 on 15/11/14.
//  Copyright © 2015年 赵希帆. All rights reserved.
//

import UIKit

class WendesdayController : UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {
    //  @IBOutlet weak var webView: UIWebView!
    
    var view1 : UIView!
    var tv : UITableView!
    var timer : NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        view1  = UIView(frame: CGRectMake(0,0,kwidth,150))
        view1.backgroundColor = UIColor(red: 85.0/255, green: 204.0/255, blue: 228.0/255, alpha: 1)
        tv  = UITableView(frame: CGRectMake(0, 0, kwidth, kheight-64-64))
        self.tv.delegate = self
        self.tv.dataSource = self
        setuptable()
        self.tv.tableHeaderView = view1
        // self.view.addSubview(view)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loadtable", userInfo: nil, repeats: false)
        print(Wendesdaycourse.count)
        //  let url : NSURL! = NSURL(string: "http://www.baidu.com?stuid=\(stuid)&stuname=\(stuname)")
        //  let request : NSURLRequest = NSURLRequest(URL: url)
        // self.view.addSubview(webView)
        //   webView.loadRequest(request)
    }
    
    func loadtable(){
        manager.requestSerializer = zxf
        manager.responseSerializer = fxz
        //        manager.requestSerializer = zxf
        //        manager.responseSerializer = fxz
        // var studentid : String = stuid.text!
        // let userpwd : String = passwd.text!
        //let params : Dictionary<String,String> = ["stu_id" : stuid.text! , "stu_name" : passwd.text!]
        //Get方法访问接口
        //        let stuid1 : String = "2014140024"
        //        let stuname : String = "刘城"
        let params1 : Dictionary<String,String> = ["stu_id" : stuid , "stu_name" : stuname,"begin" : "2015-12-20","end" : "2015-12-27"]
        manager.GET("http://www.szucal.com/api/1204/schedule.php?", parameters: params1, success: {
            (operation: AFHTTPRequestOperation!,
            responseObject: AnyObject!) in
            //将返回的14天的课程数据的Json内容转为字典
            let responseDict = responseObject as! NSDictionary!
            //  print(responseDict)
            //  let responseDict = responseObject as! NSDictionary!
            //  print(responseDict)
            //判断，如果无返回数据则说明账号密码有误
            if(responseDict["schedule"] != nil)
            {
                let schedule1 = responseDict["schedule"] as! NSArray
                var i = 0;
                while(i<7){
                    let courses1 = schedule1[i] as! NSDictionary
                    let weekday : Int = courses1["weekday"] as! Int
                    if (weekday == 3){
                        let kecheng = courses1["courses"] as! NSArray
                        var p : Int = 0
                        for j in kecheng{
                            let kecheng_name = j["course_name"] as! String
                            let kecheng_begin = j["begin"] as! String
                            let kecheng_end = j["end"] as! String
                            let kecheng_locale = j["locale"] as! String
                            Wendesdaytime.insert("\(kecheng_begin)~\(kecheng_end)", atIndex: p)
                            Wendesdaylocal.insert(kecheng_locale, atIndex: p)
                            Wendesdaycourse.insert(kecheng_name, atIndex: p)
                            p++
                        }
                    }
                    
                    i++
                }
                if(Wendesdaycourse.count >= 0){
                    
                    self.timer?.invalidate()
                    self.tv.reloadData()
                    self.view.addSubview(self.tv)
                }
                
            }
            
            
            }, failure: {(operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //Handle Error
                print(error)
                print(operation.responseString)
                
        })
    
    }
    
    func setuptable(){
        var coursecount : UILabel = UILabel(frame: CGRectMake(kwidth/2-36,10,72,72))
        coursecount.text = "4"
        coursecount.textColor = UIColor.whiteColor()
        coursecount.font = UIFont.systemFontOfSize(72)
        coursecount.textAlignment = .Center
        self.view1.addSubview(coursecount)
        var lesson : UILabel = UILabel(frame: CGRectMake(kwidth/2-80,30,288,144))
        lesson.text = "lessons"
        lesson.textColor = UIColor.whiteColor()
        lesson.font = UIFont.systemFontOfSize(54)
        lesson.textAlignment = .Left
        self.view1.addSubview(lesson)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = "cell"
        var cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: Cell)
        // cell.textLabel?.text = "岗位实践(4)"
        
        let label : UILabel = UILabel(frame: CGRectMake(0,14,kwidth,36))
        label.textAlignment = .Center
        cell.contentView.addSubview(label)
        if Wendesdaycourse.count < 6{
            if(indexPath.row < Wendesdaycourse.count)
            {
                label.text = Wendesdaycourse[indexPath.row]
                print(Wendesdaycourse[indexPath.row])
            }
            else{
                label.text = ""
            }
        }
        else if Wendesdaycourse.count >= 6{
            label.text = Wendesdaycourse[indexPath.row]
        }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1)
        }
        else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Wendesdaycourse.count < 6 {
            return 6
        }
        else{
            return Wendesdaycourse.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if Wendesdaycourse.count < 6{
            if(indexPath.row < Wendesdaycourse.count)
            {
                var view : UIAlertView = UIAlertView(title: Wendesdaycourse[indexPath.row], message: "\(Wendesdaytime[indexPath.row])在\(Wendesdaylocal[indexPath.row])上课", delegate: self, cancelButtonTitle: "我知道了")
                view.show()
            }
            else{
                
            }
        }
        else if Wendesdaycourse.count >= 6{
            var view : UIAlertView = UIAlertView(title: Wendesdaycourse[indexPath.row], message: "\(Wendesdaytime[indexPath.row])在\(Wendesdaylocal[indexPath.row])上课", delegate: self, cancelButtonTitle: "我知道了")
            view.show()
        }
    }
}
