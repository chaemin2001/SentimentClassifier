//
//  SentimentIdentifier.swift
//  SentimentClassifier
//
//  Created by 이채민 on 2023/08/08.
//

import Foundation
import SwiftUI
import CoreML
import NaturalLanguage

class SentimentIdentifier : ObservableObject{
    
    @Published var prediction = ""
    @Published var confidence = 0.0
    
    var model  = MLModel()
    var sentimentPredictor  = NLModel()
    
    init(){
        
        do{
            let sentiment_model = try MySentimentClassifier_2(configuration: MLModelConfiguration()).model
            self.model = sentiment_model
            do{
                let predictor = try NLModel(mlModel: model)
                self.sentimentPredictor = predictor
            } catch{
                print(error)
            }
        } catch { print(error)
            }
        
    }

    func predict(_ text: String){
     
            self.prediction = sentimentPredictor.predictedLabel(for: text) ?? ""
             let predictionSet = sentimentPredictor.predictedLabelHypotheses(for: text, maximumCount: 1)
            self.confidence = predictionSet[prediction] ?? 0.0
    }
}
