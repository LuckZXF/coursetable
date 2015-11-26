//
//  ViewController.swift
//  深大课程表
//
//  Created by 赵希帆 on 15/11/12.
//  Copyright © 2015年 赵希帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /**
     * 注意：
     * 1.将需要添加的controller放在一个数组中。然后通过初始化方法给SKScNavViewController
     * 2.addParentController(:UIViewController)添加父视图控制器
     * 3.需要修改的配置看SKScNavViewController文件中标注的属性
     * 4.修改高度或者宽度，参照SKMacros中标注的属性
     */
    
    
    var v1 = UIViewController()
    var v2 = UIViewController()
    var v3 = UIViewController()
    var v4 = UIViewController()
    var v5 = UIViewController()
    var v6 = UIViewController()
    
    var arrtitle : [String] = [String]()
    var arrdetail : [String] = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MondayController1 = storyboard.instantiateViewControllerWithIdentifier("firstView") as! MondayController
        MondayController1.title = "星期一"
        let TuesdayController1 = storyboard.instantiateViewControllerWithIdentifier("secondView") as! TuesdayController
        TuesdayController1.title = "星期二"
        let WendesdayController1 = storyboard.instantiateViewControllerWithIdentifier("thirdView") as! WendesdayController
        WendesdayController1.title = "星期三"
        let ThursdayController1 = storyboard.instantiateViewControllerWithIdentifier("fourthView") as! ThursdayController
        ThursdayController1.title = "星期四"
        let FridayController1 = storyboard.instantiateViewControllerWithIdentifier("fifthView") as! FridayController
        FridayController1.title = "星期五"
        let skScNavC = SKScNavViewController(subViewControllers: [MondayController1, TuesdayController1, WendesdayController1, ThursdayController1, FridayController1])
        skScNavC.addParentController(self)
        getArrtitle()
    }
    
    func getArrtitle(){
        manager.requestSerializer = zxf
        manager.responseSerializer = fxz
        let params : Dictionary<String,String> = ["stu_id" : stuid , "stu_name" : stuname]
        //Get方法访问接口
        manager.GET("http://www.szucal.com/api/1204/schedule.php?", parameters: params, success: {
            (operation: AFHTTPRequestOperation!,
            responseObject: AnyObject!) in
            //将返回的14天的课程数据的Json内容转为字典
            let responseDict = responseObject as! NSDictionary!
            //  print(responseDict)
            //判断，如果无返回数据则说明账号密码有误
            if(responseDict["schedule"] != nil)
            {
                let schedule1 = responseDict["schedule"] as! NSArray
                var i = 0;
                while(i<7){
                    let courses1 = schedule1[i] as! NSDictionary
                    let kecheng = courses1["courses"] as! NSArray
                    for j in kecheng {
                        let kecheng_name1 = j["course_name"] as! String
                        let kecheng_teacher = j["professor"] as! String
                        var flag : Int = 0
                        for q in self.arrtitle {
                            if kecheng_name1 == q {
                                flag++
                            }
                        }
                        if flag == 0 {
                            self.arrtitle.append(kecheng_name1)
                            self.arrdetail.append(kecheng_teacher)
                        }
                    }
                    i++
                }
                arrTitle = self.arrtitle
                arrDetail = self.arrdetail
            }
            else
            {
                let alert = UIAlertView(title: "警告", message: "您的账号密码有误", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                //  self.deformationBtn.stopLoading()
            }
            
            }, failure: {(operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //Handle Error
                print(error)
                print(operation.responseString)
                
        })
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


