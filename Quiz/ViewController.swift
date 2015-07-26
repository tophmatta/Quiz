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
    var answerButtonArray:[AnswerButtonView] = [AnswerButtonView]()
    
    // Result view IBOutlet properties
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide the dim and result views
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        // Get the questions from the quiz model
        self.questions = self.model.getQuestions()
        
        // Check if there's at least 1 question
        if(self.questions.count > 0){
            
            // Set the current question to first question
            self.currentQuestion = self.questions[0]
            
            // Call the display question method
            self.displayCurrentQuestion()
            
        }
        
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
        
        var index:Int = 0
        for index = 0; index < self.currentQuestion?.answers.count; index++ {
            
            // Create an answer button view
            let answer:AnswerButtonView = AnswerButtonView()
            answer.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // Place it into the content view
            self.scrollViewContentView.addSubview(answer)
            
            // Add tap gesture recognizer
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:Selector("answerTapped:"))
                answer.addGestureRecognizer(tapGesture)
            
            // Add constraints depending on what number button it is
            let heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
            answer.addConstraint(heightConstraint)
            
            let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
            
            let rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            
            let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(101 * index))
            
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            // Set answer text for it
            let answerText = self.currentQuestion!.answers[index]
            answer.setAnswerText(answerText)
            
            // Add it to the button array
            self.answerButtonArray.append(answer)
        }
        
        // Adjust the height of the content view so it can scroll if need be
        let contentViewHeight:NSLayoutConstraint = NSLayoutConstraint(item: self.scrollViewContentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.answerButtonArray[0], attribute: NSLayoutAttribute.Height, multiplier: CGFloat(self.answerButtonArray.count - 1), constant: 101)
        
        // Add constraint to the content view
        self.scrollViewContentView.addConstraint(contentViewHeight)
        
    }
    
    func answerTapped(gesture:UITapGestureRecognizer) {
        
        // Get access to the answer button that was tapped
        let answerButtonThatWasTapped:AnswerButtonView? = gesture.view as! AnswerButtonView?
        
        if let actualButton = answerButtonThatWasTapped {
            
            // We got the button, now find out what index it was
            let answerTappedIndex:Int? = find(self.answerButtonArray, actualButton)
            
            if let foundAnswerIndex = answerTappedIndex {
                
                // Compare the answer index that was tapped vs the correct index from question
                if (foundAnswerIndex == self.currentQuestion!.correctAnswerIndex) {
                    
                    // User got it correct
                    self.resultTitleLabel.text = "Correct"
                    
                }
                else {
                    
                    // User got it wrong
                    self.resultTitleLabel.text = "Incorrect"
                    
                }
                
                // Set the feedback text
                self.feedbackLabel.text = self.currentQuestion!.feedback
                
                // Display the dimView and the resultView
                self.dimView.alpha = 1
                self.resultView.alpha = 1
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

