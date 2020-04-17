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

public extension UICollectionView {

    /// Registers given collection view cell
    ///
    /// - Parameter _: Parameter to retrieve concrete type
    func uk_registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// Registers given collection view cell created from nib
    ///
    /// - Parameter _: Parameter to retrieve concrete type
    func uk_registerNibCell<T: UICollectionViewCell & NibLoadable>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// Dequeues collection view cell with inferred type's reuse identifier
    ///
    /// - Parameter indexPath: Index path of cell
    /// - Returns: Dequeued cell
    func uk_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }

    /// Registers reusable supplementary header view
    ///
    /// - Parameter _: Parameter to retrieve concrete type
    func uk_registerSupplementarySectionHeaderView<T: UICollectionReusableView>(_: T.Type) {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Dequeues reusable supplementary header view with inferred type's reuse identifier
    ///
    /// - Parameter indexPath: Index path of view
    /// - Returns: Dequeued supplementary view
    func uk_dequeueSupplementarySectionHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }
}
