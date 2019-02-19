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

open class UKView: UIView, NibLoadable {
    open override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return createdCustomViewFromNib()
    }
}

extension NibLoadable where Self: UIView {

    func createdCustomViewFromNib() -> Self {
        if self.subviews.count == 0 {
            let view = type(of: self).instanceFromNib()

            view.frame = self.frame
            view.autoresizingMask = self.autoresizingMask
            view.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints

            let constraints = self.constraints
            for constraint in constraints {
                var selfItem: UIView?
                let firstItem = constraint.firstItem as? UIView
                if firstItem == self {
                    selfItem = view
                }
                let secondItem = constraint.secondItem as? UIView
                if secondItem == self {
                    selfItem = view
                }

                if let firstItem = firstItem, let secondItem = secondItem {
                    view.addConstraint(NSLayoutConstraint(item: firstItem,
                                                          attribute: constraint.firstAttribute,
                                                          relatedBy: constraint.relation,
                                                          toItem: secondItem,
                                                          attribute: constraint.secondAttribute,
                                                          multiplier: constraint.multiplier,
                                                          constant: constraint.constant))

                } else if let selfItem = selfItem {
                    let constraint = NSLayoutConstraint(item: selfItem,
                                                        attribute: constraint.firstAttribute,
                                                        relatedBy: constraint.relation,
                                                        toItem: nil,
                                                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                        multiplier: constraint.multiplier,
                                                        constant: constraint.constant)
                    view.addConstraint(constraint)
                }

                selfItem = nil
            }
            return view
        }
        return self
    }
}
