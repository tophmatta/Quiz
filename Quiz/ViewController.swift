//
//  ViewController.swift
//  Quiz
//
//  Created by Toph Matta on 7/20/15.
//  Copyright (c) 2015 Toph Matta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var moduleLabel: UILabel!
    @IBOutlet weak var questionlabel: UILabel!
    
    
    let model:QuizModel = QuizModel()
    var questions:[Question] = [Question]()
    
    var currentQuestion:Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get the questions from the quiz model
        self.questions = self.model.getQuestions()
        
        // Check if there's at least 1 question
        if(self.questions.count > 0){
            
            // Set the current question to first question
            self.currentQuestion = self.questions[0]
            
            // Call the display question method
            self.displayCurrentQuestion()
            
        }
        
        func displayCurrentQuestion(){
            
            if let actualCurrentQuestion = self.currentQuestion {
                
                // Update the question text
                self.questionlabel.text = self.currentQuestion?.questionText
                
                // Update the module and lesson label
                self.moduleLabel.text = String(format: "Module %i Lesson %i", self.currentQuestion!.module, self.currentQuestion!.lesson)
                
                // Create and display the answer button views
                self.createAnswerButtons()
            }
            
           
        }
        
        func createAnswerButtons() {
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

