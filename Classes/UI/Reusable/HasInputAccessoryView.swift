/*
The MIT License (MIT)

Copyright (c) 2020 Ugur Kilic All rights reserved.

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

import Foundation
import UIKit

@objc
public protocol HasInputAccessoryView: class {

    /// The custom input accessory view to display when the receiver becomes the first responder
    var inputAccessoryView: UIView? { get set }

    /// Notifies this object that it has been asked to relinquish its status as first responder
    ///
    /// - Returns: YES if resigns
    func resignFirstResponder() -> Bool
}

public extension HasInputAccessoryView {

    /// Adds input accessory view with close button
    func uk_addInputAccessoryView() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let closeButton = UIBarButtonItem(
            title: "close".uk_localized,
            style: .done,
            target: self,
            action: #selector(resignFirstResponder)
        )
        let toolbar = UIToolbar(frame:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0))
        toolbar.items = [flexibleSpace, closeButton]
        inputAccessoryView = toolbar
    }

    /// Close button for styling
    var closeButton: UIBarButtonItem? {
        return (inputAccessoryView as? UIToolbar)?.items?.last
    }
}

extension UITextField: HasInputAccessoryView { }
extension UITextView: HasInputAccessoryView { }
extension UISearchBar: HasInputAccessoryView { }
