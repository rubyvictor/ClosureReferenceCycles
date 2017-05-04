//: Playground - noun: a place where people can play
// retain cycle happens when asHTML() holds a reference to self...

import UIKit

class HTMLElement {
    
    let name: String
    let text: String
    
    // Instead of using a function. declare a variable that can be used as method call like this
    // To break the retain cycle, use a capture list inside the closure
    // unwrap the self with ?. unwrap with guard let better.
    lazy var asHTML: () -> String = { [weak self] in
        
        guard let this = self else { return "" }
        
        return "<\(this.name)>\(this.text)</\(this.name)>"
    }
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("HTMLElement \(name) is being deallocated")
    }

}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "Some sample paragraph body text")

paragraph?.asHTML() //<p>Some sample paragraph body text</p>

paragraph = nil
