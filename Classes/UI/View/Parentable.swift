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

public protocol Parentable { }

public extension Parentable where Self: UIViewController {
    func addChildViewController(_ type: UIViewController.Type) -> UIViewController {

        let viewController = type.init()
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        self.view.addSubview(viewController.view)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }

    func removeChildViewController(of type: UIViewController.Type) {

        for controller in self.children {
            if controller.isKind(of: type) {
                controller.willMove(toParent: nil)
                controller.removeFromParent()

                if let superview = controller.view.superview {
                    UIView.transition(with: superview,
                                      duration: 0.3,
                                      options: [.curveEaseInOut, .transitionCrossDissolve],
                                      animations: {
                        controller.view.removeFromSuperview()
                    }, completion: nil)
                }
            }
        }
    }
}
