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
    
    // Score Keeping
    var numberCorrect:Int = 0
    
    // Result view IBOutlet properties
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultViewTopMargin: NSLayoutConstraint!
    

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
            
            // Load state
            self.loadState()
            
            // Call the display question method
            self.displayCurrentQuestion()
            
        }
        
    }
    
    func displayCurrentQuestion(){
        
        if let actualCurrentQuestion = self.currentQuestion {
            
            // Set question to be invisible
            self.questionlabel.alpha = 0
            self.moduleLabel.alpha = 0
            
            // Update the question text
            self.questionlabel.text = self.currentQuestion?.questionText
            
            
            
            // Update the module and lesson label
            self.moduleLabel.text = String(format: "Module %i Lesson %i", self.currentQuestion!.module, self.currentQuestion!.lesson)
            
            // Reveal the question
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.questionlabel.alpha = 1
                self.moduleLabel.alpha = 1
                
                }, completion: nil)
            
            // Create and display the answer button views
            self.createAnswerButtons()
            
            // Save state
            self.saveState()
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
            
            let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 400)
            
            let rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 400)
            
            let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(101 * index))
            
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            // Set answer text for it
            let answerText = self.currentQuestion!.answers[index]
            answer.setAnswerText(answerText)
            
            // Set the answer number
            answer.setAnswerNumber(index + 1)
            
            // Add it to the button array
            self.answerButtonArray.append(answer)
            
            // Manually call update layout
            self.view.layoutIfNeeded()
            
            // Calcualte slide in delay
            let slideInDelay:Double = Double(index) * 0.1
            
            // Animate the button constraints so they slide in
            UIView.animateWithDuration(0.5, delay: slideInDelay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                leftMarginConstraint.constant = 0
                rightMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
                
                
                }, completion: nil)
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
                    
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 59/255, green: 85/255, blue: 60/255, alpha: 0.8)
                    self.nextButton.backgroundColor = UIColor(red: 21/255, green: 68/255, blue: 24/255, alpha: 1)
                    
                    // Increment user score
                    self.numberCorrect++
                    
                }
                else {
                    
                    // User got it wrong
                    self.resultTitleLabel.text = "Incorrect"
                    
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 98/255, green: 29/255, blue: 37/255, alpha: 0.8)
                    self.nextButton.backgroundColor = UIColor(red: 128/255, green: 21/255, blue: 26/255, alpha: 1)
                    
                }
                
                // Set the feedback text
                self.feedbackLabel.text = self.currentQuestion!.feedback
                
                // Set the button text to Next
                self.nextButton.setTitle("Next", forState: UIControlState.Normal)
                
                // Set result view top margin constraint to some high number
                self.resultViewTopMargin.constant = 900
                self.view.layoutIfNeeded()
                
                // Display the dimView and the resultView
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.resultViewTopMargin.constant = 30
                    self.view.layoutIfNeeded()
                    
                    // Fade into view
                    self.dimView.alpha = 1
                    self.resultView.alpha = 1
                })
                
                // Save state
                self.saveState()
            }
        }
    }

    @IBAction func changeQuestion(sender: UIButton) {
        
        // Check if button text is Restart. If so, restart quiz
        // Otherwise, try to advance to the next question
        if self.nextButton.titleLabel?.text == "Restart" &&
            self.questions.count > 0{
                
            // Reset question to the first question
            self.currentQuestion = self.questions[0]
                self.displayCurrentQuestion()
                
            // Remove dim and result view
            self.dimView.alpha = 0
            self.resultView.alpha = 0
                
            // Reset the score
            self.numberCorrect = 0
            
            return
        }
        
        
        // Dismiss dim and result view
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        // Erase the question and module labels
        self.questionlabel.text = ""
        self.moduleLabel.text = ""
        
        // Remove all the answerbuttonviews
        for button in self.answerButtonArray {
            button.removeFromSuperview()
        }
        
        // Flush button array (changes to 0 capacity array with nothing)
        self.answerButtonArray.removeAll(keepCapacity: false)
        
        // Finding current index of question
        let indexOfCurrentQuestion:Int? = find(self.questions, self.currentQuestion!)
        
        // Check if it found the current index
        if let actualCurrentIndex = indexOfCurrentQuestion {
            
            // Found the index! Advance the index
            let nextQuestionIndex = actualCurrentIndex + 1
            
            // Check if nextQuestionIndex is beyond the capacity of our questions array
            if (nextQuestionIndex < self.questions.count) {
                
                // We can display another question
                self.currentQuestion = self.questions[nextQuestionIndex]
                self.displayCurrentQuestion()
            }
            else {
                
                // Erase any saved data
                self.eraseState()
                
                // No more questions to display. End the quiz
                self.resultView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.8)
                self.nextButton.backgroundColor = UIColor.darkGrayColor()
                
                self.resultTitleLabel.text = "Quiz Finished"
                self.feedbackLabel.text = String(format: "Your Score: %i / %i", self.numberCorrect, self.questions.count)
                self.nextButton.setTitle("Restart", forState: UIControlState.Normal)
                
                self.dimView.alpha = 1
                self.resultView.alpha = 1
                
            }
            
            
        }
    }
    
    func eraseState() {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setInteger(0, forKey: "numberCorrect")
        userDefaults.setInteger(0, forKey: "questionIndex")
        userDefaults.setBool(false, forKey: "resultViewAlpha")
        userDefaults.setObject("", forKey: "resultViewTitle")
        
        userDefaults.synchronize()
    }
    
    func saveState() {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // Save the current score, current question, and whether or not the result view is visible
        userDefaults.setInteger(self.numberCorrect, forKey: "numberCorrect")
        
        // Finding current index of question
        let indexOfCurrentQuestion:Int? = find(self.questions, self.currentQuestion!)
        
        if let actualIndex = indexOfCurrentQuestion {
            userDefaults.setInteger(actualIndex, forKey: "questionIndex")
        }
        
        // Set true if result view is visible, else set false
        userDefaults.setBool(self.resultView.alpha == 1, forKey: "resultViewAlpha")
        
        // Save the title of the result view
        userDefaults.setObject(self.resultTitleLabel.text, forKey: "resultViewTitle")
        
        // Save the change
        userDefaults.synchronize()
    }
    
    func loadState() {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // Load the saved question into the current question
        let currentQuestionIndex = userDefaults.integerForKey("questionIndex")
        
        // Check that the saved index is not beyond the number of questions that we have
        if currentQuestionIndex < self.questions.count {
            self.currentQuestion = self.questions[currentQuestionIndex]
        }
        
        // Load the score
        let score:Int = userDefaults.integerForKey("numberCorrect")
        self.numberCorrect = score
        
        // Load the result view visibility
        let isResultViewVisible:Bool = userDefaults.boolForKey("resultViewAlpha")
        
        if(isResultViewVisible == true) {
            
            // We should display the result view
            self.feedbackLabel.text = self.currentQuestion?.feedback
            
            // Retrieve the title text
            let title:String? = userDefaults.objectForKey("resultViewTitle") as! String?
            
            if let actualTitle = title {
                self.resultTitleLabel.text = actualTitle
                
                if actualTitle == "Correct" {
                    
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 59/255, green: 85/255, blue: 60/255, alpha: 0.8)
                    self.nextButton.backgroundColor = UIColor(red: 21/255, green: 68/255, blue: 24/255, alpha: 1)
                    
                }
                else if actualTitle == "Incorrect" {
                    
                    // Change background color of result view and button
                    self.resultView.backgroundColor = UIColor(red: 98/255, green: 29/255, blue: 37/255, alpha: 0.8)
                    self.nextButton.backgroundColor = UIColor(red: 128/255, green: 21/255, blue: 26/255, alpha: 1)
                    
                }
            }
            
            self.dimView.alpha = 1
            self.resultView.alpha = 1
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

