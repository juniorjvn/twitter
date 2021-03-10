//
//  TweetViewController.swift
//  Twitter
//
//  Created by Junior Norabuena on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let characterLimit = 20
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        counterLabel.text = String(newText.count) + "/280"
        return newText.count < characterLimit
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting your tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
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
