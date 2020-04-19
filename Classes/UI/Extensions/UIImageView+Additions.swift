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

import UIKit

public extension UIImageView {

    /// Loads image data from url string and sets to image view
    /// - Parameter string: URL string
    func uk_loadFromString(_ string: String) {
        guard let url = URL(string: string) else {
            return
        }
        uk_loadFromURL(url)
    }

    /// Loads image data from url and sets to image view
    /// - Parameter url: URL
    func uk_loadFromURL(_ url: URL) {
        func assign(data: Data, cacheURL: URL? = nil) {
            if let cacheURL = cacheURL {
                try? data.write(to: cacheURL)
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: fileURL) {
                assign(data: data)
            } else if let data = try? Data(contentsOf: url) {
                assign(data: data, cacheURL: fileURL)
            }
        }
    }
}
