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

public extension UIView {

    /// Simple animation
    ///
    /// - Parameter animations: Animation block
    static func uk_animate(animations: @escaping () -> Swift.Void) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1.0,
            options: [.curveEaseInOut],
            animations: {
                animations()
        }, completion: nil)
    }
}

public extension UIView {

    enum SeparatorPosition {
        case top, bottom, left, right
    }

    /// Adds separator
    ///
    /// - Parameter position: Separator position
    func uk_addSeparator(at position: SeparatorPosition) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        self.addSubview(view)

        var constraints = [view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                          view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                          view.heightAnchor.constraint(equalToConstant: 1.0)]

        switch position {

        case .bottom:
            constraints.append(view.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        case .top:
            constraints.append(view.topAnchor.constraint(equalTo: self.topAnchor))

        case .left, .right:
            print("not supported")
        }

        NSLayoutConstraint.activate(constraints)
        self.layoutIfNeeded()
    }
}
