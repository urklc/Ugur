/*
 The MIT License (MIT)

 Copyright (c) 2019 Ugur Kilic All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

/// Conform this protocol to prevent KeyboardListener dismiss keyboard
public protocol KeepsInput { }

/// Registers for keyboard notifications
public protocol KeyboardListening {
    var keyboardListener: KeyboardListener? { get set }
    func registerForKeyboardNotifications()
}

public extension KeyboardListening {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(keyboardListener!,
                                               selector: #selector(keyboardListener?.keyboardWillBeShown(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(keyboardListener!,
                                               selector: #selector(keyboardListener?.keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

/// Listens for keyboard notifications and manages keyboard
public class KeyboardListener {
    weak var scrollView: UIScrollView?

    public init(scrollView: UIScrollView) {
        self.scrollView = scrollView

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        gestureRecognizer.cancelsTouchesInView = false
        self.scrollView?.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func keyboardWillBeShown(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrameKey = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                return
        }

        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardFrameKey.cgRectValue.size.height,
                                         right: 0.0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    @objc
    func keyboardWillBeHidden(_ notification: Notification) {
        scrollView?.contentInset = UIEdgeInsets.zero
    }

    @objc
    func endEditing(_ gestureRecognizer: UITapGestureRecognizer?) {
        if let recognizer = gestureRecognizer,
            let svSuper = scrollView?.superview {
            let view = svSuper.hitTest(recognizer.location(in: svSuper), with: nil)
            if view as? KeepsInput != nil {
                return
            }
        }

        scrollView?.superview?.endEditing(true)
    }
}
