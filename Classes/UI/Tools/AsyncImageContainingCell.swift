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

public protocol AsyncImageContainingCell: class {

    /// Control value to test if cell is in sync with bound data
    var controlValue: String? { get }
}

public extension AsyncImageContainingCell {

    /// Downloads async images safely if the cell is not reused and has up-to-date download request source
    ///
    /// - Parameters:
    ///   - view: Target image view
    ///   - urlString: Image URL string
    func downloadSafeImage(view: UIImageView, urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return
        }

        let initialValue = controlValue
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    return
            }
            DispatchQueue.main.async { [weak self] in
                if initialValue == self?.controlValue {
                    view.image = image
                }
            }
        }
    }
}
