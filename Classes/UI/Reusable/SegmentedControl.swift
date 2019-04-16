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

import UIKit

final class SegmentedControl: UIControl {

    public var selectedIndex: Int = 0 {
        didSet {
            guard oldValue != selectedIndex else {
                return
            }

            updateButtons()
        }
    }

    public var items: [String] = [] {
        didSet {
            updateViews()
        }
    }

    public var buttons: [UIButton] {
        guard let buttons = buttonsStackView.arrangedSubviews as? [UIButton] else {
            return []
        }
        return buttons
    }

    private let buttonsStackView = UIStackView(frame: .zero)

    init(items: [String]) {
        super.init(frame: .zero)
        self.items = items
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = UIColor.lightGray

        buttonsStackView.spacing = 1.0
        addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     buttonsStackView.topAnchor.constraint(equalTo: topAnchor),
                                     buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])

        updateViews()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 38.0)
    }

    private func updateViews() {
        guard items.count > 0 else {
            return
        }

        for item in items {
            let button = UIButton(type: .custom)
            button.setTitle(item, for: .normal)
            buttonsStackView.addArrangedSubview(button)
            
            button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 33.0, bottom: 0.0, right: 33.0)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }

        updateButtons()
    }

    private func updateButtons() {
        let segmentButtons = buttons
        segmentButtons.forEach {
            $0.backgroundColor = .lightGray
        }

        if segmentButtons.count > selectedIndex {
            segmentButtons[selectedIndex].backgroundColor = .darkGray
        }
    }

    @objc
    func buttonTapped(_ sender: UIButton) {
        let oldValue = selectedIndex
        selectedIndex = buttons.firstIndex(of: sender) ?? 0
        if oldValue != selectedIndex {
            sendActions(for: .valueChanged)
        }
    }
}
