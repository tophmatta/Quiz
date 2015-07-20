//
//  ViewController.swift
//  Quiz
//
//  Created by Toph Matta on 7/20/15.
//  Copyright (c) 2015 Toph Matta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let model:QuizModel = QuizModel()
    var question:[Question] = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get the questions from the quiz model
        self.question = self.model.getQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

