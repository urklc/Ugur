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

public final class Localization {

    static var shared: Localization?

    /// Locale selected by user
    public var locale: Locale {
        if let identifier = Localization.language {
            return Locale(identifier: identifier)
        } else {
            let preferredLanguages = Locale.preferredLanguages
            let value = supported.first { prefix in
                return preferredLanguages.contains { val in
                    return val.hasPrefix(prefix)
                }
            }
            if let value = value {
                return Locale(identifier: value)
            }
            return Locale.current
        }
    }

    private let supported: [String]

    /// Initialize a localization instance
    /// - Parameter supported: Supported language identifier
    public init(supported: [String]) {
        self.supported = supported

        Localization.shared = self
    }
}

public extension Localization {

    /// Set this value to the language identifier selected by user
    static var language: String? {
        get {
            return UserDefaults.standard.string(forKey: "userLanguage")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userLanguage")
        }
    }
}
