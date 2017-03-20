//
//  ViewController.swift
//  Silly Song
//
//  Created by Francis Gutierrez on 3/19/17.
//  Copyright © 2017 Francis Gutierrez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        lyricsView.text = ""
        nameField.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if let name = nameField.text {
            lyricsView.text = lyricsForName(lyricsTemplate:  bananaFanaTemplate, fullName: name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortNameFromName(name: String) -> String {
    let name = name.lowercased()
    let vowels = CharacterSet(charactersIn: "aeiou")
    var index = 0
    
    for c in name.unicodeScalars {
        if !vowels.contains(c) {
            index += 1
        } else {
            break
        }
    }
    if index == name.characters.count {
        return name
    }
    let i = name.index(name.startIndex, offsetBy: index)
    return name.substring(from: i)
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    let lyricsTemplate = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyricsTemplate
}


let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")
