//
//  AnswerButtonView.swift
//  Quiz
//
//  Created by Toph on 7/23/15.
//  Copyright (c) 2015 Toph Matta. All rights reserved.
//

import UIKit

class AnswerButtonView: UIView {
    
    let answerLabel:UILabel = UILabel()
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // Add the label to the view
        self.addSubview(self.answerLabel)
        self.answerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
