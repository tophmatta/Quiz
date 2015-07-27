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
    let answerNumberLabel:UILabel = UILabel()
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // Set background and alpha
        self.backgroundColor = UIColor.darkGrayColor()
        self.alpha = 0.5
        
        // Add the label to the view
        self.addSubview(self.answerLabel)
        self.answerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add the number label to the view
        self.addSubview(self.answerNumberLabel)
        self.answerNumberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
    }
    
    func setAnswerText(text:String) {
        self.answerLabel.text = text
        
        // Set properties for the label and constraints
        self.answerLabel.numberOfLines = 0
        self.answerLabel.textColor = UIColor.whiteColor()
        self.answerLabel.textAlignment = NSTextAlignment.Center
        self.answerLabel.adjustsFontSizeToFitWidth = true
        
        // Set constraints
        let LeftMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 35)
        
        let rightMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 5)
        
        let topMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 20)
        
        let bottomMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([LeftMarginConstraint, rightMarginConstraint, topMarginConstraint, bottomMarginConstraint])
    }
    
    func setAnswerNumber(answernumber:Int){
        self.answerNumberLabel.text = String(answernumber)
        
        // Set properties for the label and constraints
        self.answerNumberLabel.textColor = UIColor.whiteColor()
        self.answerNumberLabel.textAlignment = NSTextAlignment.Center
        self.answerNumberLabel.backgroundColor = UIColor.blackColor()
        self.answerNumberLabel.alpha = 0.5
        self.answerNumberLabel.font = UIFont.boldSystemFontOfSize(14)
        
        // Set constraints
        let widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        self.answerNumberLabel.addConstraint(widthConstraint)
        
        let leftMargin:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        let topMargin:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        
        let bottomMargin:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([leftMargin, topMargin, bottomMargin])

    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
