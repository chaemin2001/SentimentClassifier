//
//  ContentView.swift
//  SentimentClassifier
//
//  Created by 이채민 on 2023/08/08.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var identifier = SentimentIdentifier()
    @State private var input = ""
    
    var body: some View {

        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text(emoji(prediction: self.identifier.prediction))
                    .font(.system(size: 60))
                    .opacity(self.identifier.confidence)
                    .scaleEffect(CGFloat( 1 + (self.identifier.confidence - 0.5)))
                    .animation(.spring())
                
                TextField("What are you thinking?",text: $input)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    
                    .onChange(of: input){_ in
                        if input.last == " "{
                        self.identifier.predict(input)
                        }
                    }

            Spacer()
        }
    }
    
    func emoji(prediction: String) -> String {
        if (prediction == "0") {
            return "😞"
        } else if (prediction == "2") {
            return "☺️"
        } else if (prediction == "4") {
            return "🥰"
        }
        return "sorry"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
