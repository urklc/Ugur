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

/// TextFieldValidator Reference
class TextFieldValidator: NSObject {

    enum ValidatorType {
        case general
        case phoneNumber
        case smsCode
        case password
        case email
        case phoneNumberAndEmail

        var minimumLength: Int {
            return 1
        }

        var maximumLength: Int {
            return exactLength ?? Int.max
        }

        var exactLength: Int? {
            switch self {
            case .phoneNumber:
                return 11
            case .smsCode:
                return 5
            case .password:
                return 6
            default:
                return nil
            }
        }

        var keyboardType: UIKeyboardType {
            switch self {
            case .phoneNumber, .smsCode, .password:
                return .phonePad
            case .email:
                return .emailAddress
            default:
                return .default
            }
        }

        func shouldAllow(text: String) -> Bool {
            switch self {
            case .phoneNumber, .smsCode, .password:
                return text.count <= maximumLength
            default:
                return true
            }
        }
    }

    private var isValid = false {
        didSet {
            if isValid != oldValue {
                onStateChange?(isValid, self)
            }
        }
    }

    var onStateChange: ((Bool, TextFieldValidator) -> Void)?
    var textField: UITextField

    private var type: ValidatorType

    init(textField: UITextField,
         type: ValidatorType = .general,
         stateChange: ((Bool, TextFieldValidator) -> Void)? = nil) {
        self.onStateChange = stateChange
        self.type = type
        self.textField = textField
        super.init()

        textField.delegate = self
        textField.keyboardType = type.keyboardType
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }

    private func validate(text: String) -> Bool {
        var valid = text.count >= type.minimumLength
        if let exactLength = type.exactLength {
            valid = valid && text.count == exactLength
        }
        valid = valid && text.count <= type.maximumLength

        switch type {
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            valid = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: text)
        default:
            break
        }
        return valid
    }

    @objc func textChanged(_ textField: UITextField) {
        isValid = validate(text: textField.text!)
    }
}

extension TextFieldValidator: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let possibleString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        return type.shouldAllow(text: possibleString)
    }
}
