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
        
        
        // Loop through each dictionary and assign values to our question objects
        
        
        // Return list of question objects
        return questions
    }
   
    func getLocaLJsonFile() -> [NSDictionary] {
        
        // Get and NSURL object pointing to the json file in our app bundle
        let appBundlePath:String? = NSBundle.mainBundle().pathForResource("QuestionData", ofType: "json")
        
        
        // Use optional binding to check if path exists
        if let actualBundlePath = appBundlePath {
            
            // Bundle path exists
            let urlPath:NSURL? = NSURL(fileURLWithPath: actualBundlePath)
            
            if let actualURLPath = urlPath {
                
                //
                
            }
            
        }
        else {
            // Path to json file in the app bundle doesn't exist
        }
    }
    
}
