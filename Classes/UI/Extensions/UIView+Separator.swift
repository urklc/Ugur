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

public struct SeparatorPosition: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let top = SeparatorPosition(rawValue: 1 << 0)
    public static let bottom = SeparatorPosition(rawValue: 1 << 1)
    public static let leading = SeparatorPosition(rawValue: 1 << 2)
    public static let trailing = SeparatorPosition(rawValue: 1 << 3)
    public static let all: SeparatorPosition = [.top, .bottom, .leading, .trailing]
    public static let vertical: SeparatorPosition = [.top, .bottom]
    public static let horizontal: SeparatorPosition = [.leading, .trailing]
}

public extension UIView {

    /// Adds separator
    ///
    /// - Parameters:
    ///   - position: Separator position st
    ///   - color: Color, defaults to light gray
    ///   - edgeInsets: Insets, defaults to .zero
    func uk_addSeparator(to position: SeparatorPosition,
                         color: UIColor = .lightGray,
                         edgeInsets: UIEdgeInsets = .zero) {

        func addSeparatorView() -> UIView {
            let view = UIView()
            view.backgroundColor = color
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            return view
        }

        func addConstraints(view: UIView, position: SeparatorPosition) {
            var constraints = [view.heightAnchor.constraint(equalToConstant: 1.0)]
            if position == .top || position == .bottom {
                constraints.append(contentsOf: [
                    view.leadingAnchor.constraint(equalTo: leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: trailingAnchor)
                    ])
            }
            if position == .leading || position == .trailing {
                constraints.append(contentsOf: [
                    view.topAnchor.constraint(equalTo: topAnchor),
                    view.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
            }
            if position == .top {
                constraints.append(view.topAnchor.constraint(equalTo: topAnchor))
            } else if position == .bottom {
                constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor))
            } else if position == .leading {
                constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor))
            } else if position == .trailing {
                constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor))
            }
            NSLayoutConstraint.activate(constraints)
        }

        if position.contains(.top) {
            let view = addSeparatorView()
            addConstraints(view: view, position: .top)
        }
        if position.contains(.bottom) {
            let view = addSeparatorView()
            addConstraints(view: view, position: .bottom)
        }
        if position.contains(.leading) {
            let view = addSeparatorView()
            addConstraints(view: view, position: .leading)
        }
        if position.contains(.trailing) {
            let view = addSeparatorView()
            addConstraints(view: view, position: .trailing)
        }
    }
}
