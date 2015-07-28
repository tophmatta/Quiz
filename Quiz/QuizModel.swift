//
//  QuizModel.swift
//  Quiz
//
//  Created by Toph Matta on 7/20/15.
//  Copyright (c) 2015 Toph Matta. All rights reserved.
//

import UIKit

class QuizModel: NSObject {
    
    func getQuestions() -> [Question] {
        
        // Array of question objects
        var questions:[Question] = [Question]()
        
        // Get JSON array of dictionaries
        let jsonObjects:[NSDictionary] = self.getRemoteJsonFile()
        
        // Loop through each dictionary and assign values to our question objects
        var index:Int
        for index = 0; index < jsonObjects.count; index++ {
            
            // Current JSON dictionary
            let jsonDictionary:NSDictionary = jsonObjects[index]
            
            // Create a question object
            var q:Question  = Question()
            
            // Assign the values of each key value pair to the quetion object
            q.questionText = jsonDictionary["question"] as! String
            q.answers = jsonDictionary["answers"] as! [String]
            q.correctAnswerIndex = jsonDictionary["correctIndex"] as! Int
            q.module = jsonDictionary["module"] as! Int
            q.lesson = jsonDictionary["lesson"] as! Int
            q.feedback = jsonDictionary["feedback"] as! String
            
            // Add the question to the question array
            questions.append(q)
            
        }
        
        // Return list of question objects
        return questions
    }
    
    func getRemoteJsonFile() -> [NSDictionary] {
        
        // Create a new URL
        let remoteUrl:NSURL? = NSURL(string: "http://codewithchris.com/code/QuestionData.json")
        
        // Check if it's nil
        if let actualRemoteUrl = remoteUrl {
            
            // Try to get the data
            let fileData:NSData? = NSData(contentsOfURL: actualRemoteUrl)
            
            // Check if it's nil
            if let actualFileData = fileData {
                
                // Parse out the dictionaries
                let arrayOfDictionaries:[NSDictionary]? = NSJSONSerialization.JSONObjectWithData(actualFileData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]?
                
                if let actualArrayOfDictionaries = arrayOfDictionaries {
                    
                    // Successfully parsed out array of dictionaries
                    return actualArrayOfDictionaries
                }
            }
        }
        return [NSDictionary]()
    }
   
    func getLocaLJsonFile() -> [NSDictionary] {
        
        // Get and NSURL object pointing to the json file in our app bundle
        let appBundlePath:String? = NSBundle.mainBundle().pathForResource("QuestionData", ofType: "json")
        
        
        // Use optional binding to check if path exists
        if let actualBundlePath = appBundlePath {
            
            // Bundle path exists
            let urlPath:NSURL? = NSURL(fileURLWithPath: actualBundlePath)
            
            if let actualURLPath = urlPath {
                
                // NSURL file was created, now create NSData object
                let jsonData:NSData? = NSData(contentsOfURL: actualURLPath)
                
                if let actualJsonData = jsonData {
                    
                    // NSData exists, use the NSJSONSerialization classes to parse the data and create the array/dictionaries
                    let arrayOfDictionaries:[NSDictionary]? = NSJSONSerialization.JSONObjectWithData(actualJsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]?
                    
                    if let actualArrayOfDictionaries = arrayOfDictionaries {
                        
                        // Successfully parsed out array of dictionaries
                        return actualArrayOfDictionaries
                    }
                    
                }
                
                
            }
            
        }
        
        return [NSDictionary]()
    }
    
}
