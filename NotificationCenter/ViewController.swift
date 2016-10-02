//
//  ViewController.swift
//  NotificationCenter
//
//  Created by Ken Hom on 9/28/16.
//  Copyright © 2016 Ken Hom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Subscriptions
    
    // subscribe to show and hide, and what to do when recieved
    func subscribeToKeyboardNotifications() {
        
        // will show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // will hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // unsubscribe
    func unsubscribeFromKeyboardNotifications() {
        
        // will show
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // will hide
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Methods
    
    func keyboardWillShow(notification: Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: Notification) {
        view.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

