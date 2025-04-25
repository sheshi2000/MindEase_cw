//
//  MoodAnalyzer.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-24.
//

import NaturalLanguage

class MoodAnalyzer {
    static func analyzeMood(from text: String) -> String {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text

        let (sentiment, _) = tagger.tag(at: text.startIndex,
                                        unit: .paragraph,
                                        scheme: .sentimentScore)

        if let scoreString = sentiment?.rawValue,
           let score = Double(scoreString) {
            
            if score > 0.1 {
                return "Positive 😊"
            } else if score < -0.1 {
                return "Negative 😟"
            } else {
                return "Neutral 😐"
            }
        }
        return "Unknown"
    }
}

