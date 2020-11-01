//
//  ViewController.swift
//  EmailSender
//
//  Created by Pooya on 2020-11-01.
//  Copyright © 2020 centurytrail.com. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController , MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var reciverText : UITextField!
    @IBOutlet weak var ccText : UITextField!
    @IBOutlet weak var subjectText : UITextField!
    @IBOutlet weak var bodyText : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reciverText.delegate = self
        ccText.delegate = self
        subjectText.delegate = self
        bodyText.delegate = self
        
    }

    
    @IBAction func sendAct(_ sender:Any) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        
        if let reciverTxt = reciverText.text {
            let recivers = reciverTxt.components(separatedBy: ";")
            picker.setToRecipients(recivers)
        }

        if let ccTxt = ccText.text {
            let ccs = ccTxt.components(separatedBy: ";")
            picker.setCcRecipients(ccs)
        }

        if let subjectTxt = subjectText.text {
            picker.setSubject(subjectTxt)
        }
        
        picker.setMessageBody(bodyText.text, isHTML: true)
        
        //check if mail account exist
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail service are not available")
            return
        }
        
        
        present(picker, animated: true, completion: nil)
        
    }

    //Tells the delegate to dismiss mail composition view
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
}

