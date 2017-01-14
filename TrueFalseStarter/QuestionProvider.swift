//
//  QuestionHelper.swift
//  TrueFalseStarter
//
//  Created by michael on 15/1/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

struct QuestionProvider {
    let trivia: [[String : Any]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.",
         "Options": ["George Washington","Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"],
         "Answer":2
        ],
        ["Question": "Which of the following countries has the most residents?",
         "Options": ["Nigeria","Russia","Iran","Vietnam"],
         "Answer":1
        ],
        ["Question": "In what year was the United Nations founded?",
         "Options": ["1918","1919","1945","1954"],
         "Answer":3
        ],
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
         "Options": ["Paris","Washington D.C.","New York City","Boston"],
         "Answer":3
        ],
        ["Question": "Which nation produces the most oil?",
         "Options": ["Iran","Iraq","Brazil","Canada"],
         "Answer":4
        ],
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?",
         "Options": ["Italy","Brazil","Argetina","Spain"],
         "Answer":2
        ],
        ["Question": "Which of the following rivers is longest?",
         "Options": ["Yangtze","Mississippi","Congo","Mekong"],
         "Answer":2
        ],
        ["Question": "Which city is the oldest?",
         "Options": ["Mexico City","Cape Town","San Juan","Sydney"],
         "Answer":1
        ],
        ["Question": "Which country was the first to allow women to vote in national elections?",
         "Options": ["Poland","United States","Sweden","Senegal"],
         "Answer":1
        ],
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?",
         "Options": ["France","Germany","Japan","Great Britian"],
         "Answer":4
        ]
    ]
    func randomQuestion() -> [String : Any] {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        return trivia[randomNumber]
    }
}


