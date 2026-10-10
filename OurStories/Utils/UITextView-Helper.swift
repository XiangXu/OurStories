//
//  UITextView-Helper.swift
//  OurStories
//
//  Created by Xiang Xu on 23/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import UIKit

class TypeOnTextView: UITextView {

    fileprivate var typeTimer: Timer? = nil
    
    /// When set, typed text is added with these attributes (e.g. a paragraph style)
    /// instead of the plain font and colour of the text view.
    var typeOnAttributes: [NSAttributedString.Key: Any]?

    deinit {
        typeTimer?.invalidate()
    }

    func resetTypeOn()
    {
        self.typeTimer?.invalidate()
        self.text = ""
        self.typeTimer = nil
    }

    /// The text appended on each timer tick. "$" is not printed, it only pauses
    /// the typing for one tick, and a run of spaces is typed together with the
    /// character that follows it.
    static func typeOnSteps(for string: String) -> [String] {
        var steps = [String]()
        var pendingSpaces = ""
        for character in string {
            if character == " " {
                pendingSpaces.append(character)
            } else if character == "$" {
                steps.append(pendingSpaces)
                pendingSpaces = ""
            } else {
                steps.append(pendingSpaces + String(character))
                pendingSpaces = ""
            }
        }
        if !pendingSpaces.isEmpty {
            steps.append(pendingSpaces)
        }
        return steps
    }
    
    func typeOn(string: String) {
        let steps = TypeOnTextView.typeOnSteps(for: string)
        var stepIndex = 0
        guard typeTimer == nil, !steps.isEmpty else { return }
        
        typeTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if let attributes = self.typeOnAttributes {
                self.textStorage.append(NSAttributedString(string: steps[stepIndex], attributes: attributes))
            } else {
                self.text.append(steps[stepIndex])
            }
            // Keep the line being typed in view when the story is longer than the card.
            self.scrollRangeToVisible(NSRange(location: self.textStorage.length, length: 0))
            stepIndex += 1
            if stepIndex == steps.count {
                timer.invalidate()
                self.typeTimer = nil
            }
        }
    }
}
