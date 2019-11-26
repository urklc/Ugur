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

import Foundation

open class TextFieldDelegateProxy: NSObject {

    public weak var originalDelegate: UITextFieldDelegate?

    public init(delegate: UITextFieldDelegate?) {
        self.originalDelegate = delegate
    }

    public override func responds(to aSelector: Selector!) -> Bool {
        if uk_shouldRespond(to: aSelector) {
            return true
        }
        return originalDelegate?.responds(to: aSelector) ?? false
    }

    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if uk_shouldRespond(to: aSelector) {
            return self
        } else if originalDelegate?.responds(to: aSelector) ?? false {
            return originalDelegate
        }
        return nil
    }

    func uk_shouldRespond(to aSelector: Selector) -> Bool {
        return type(of: self).instancesRespond(to: aSelector)
    }
}
