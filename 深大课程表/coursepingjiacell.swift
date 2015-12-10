//
//  coursepingjiacell.swift
//  深大课程表
//
//  Created by 赵希帆 on 15/12/10.
//  Copyright © 2015年 赵希帆. All rights reserved.
//

import UIKit

class coursepingjiacell : UITableViewCell {
    
    @IBOutlet weak var studentname: UILabel!
    @IBOutlet weak var studentpingjia: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
