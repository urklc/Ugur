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

public class CheckBoxView: UIControl {

    private enum Constant {

        static let margin: CGFloat = 8.0
    }

    public var text = "" {
        didSet {
            label.text = text
        }
    }

    public var attributedText: NSAttributedString? {
        didSet {
            label.attributedText = attributedText
        }
    }

    public var isChecked: Bool {
        get {
            return button.isSelected
        }
        set {
            button.isSelected = newValue
        }
    }

    public var button: UIButton!
    public var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }

    public func updateIcons(normal: UIImage, selected: UIImage) {
        button.setImage(normal, for: .normal)
        button.setImage(selected, for: .selected)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        isChecked.toggle()
        sendActions(for: .valueChanged)
    }
}

private extension CheckBoxView {

    func configureViews() {
        label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0

        button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        addSubview(label)
        addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: label.leadingAnchor,
                                             constant: Constant.margin),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

}
