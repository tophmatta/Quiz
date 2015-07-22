//
//  Question.swift
//  Quiz
//
//  Created by Toph Matta on 7/20/15.
//  Copyright (c) 2015 Toph Matta. All rights reserved.
//

import UIKit

class Question: NSObject {
   
    var questionText:String = ""
    var answers:[String] = [String]()
    var correctAnswerIndex:Int = 0
    var module:Int = 0
    var lesson:Int = 0
    var feedback:String = ""
    
}
