//
//  TweetViewController.swift
//  Twitter
//
//  Created by Henry Nguyen on 3/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var characterCount: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetTextView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion:nil)
            }, failure: {(error) in
                print("Error Posting Tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 200
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        let characters:Int = characterLimit - newText.count
        characterCount.text = String(characters) + "/280"
        
        return newText.count <= characterLimit
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
