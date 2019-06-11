//
//  UIViewController.swift
//  Ugur
//
//  Created by Ugur Kilic on 11/06/2019.
//  Copyright (c) 2019 Commencis. All rights reserved.
//
//  Save to the extent permitted by law, you may not use, copy, modify,
//  distribute or create derivative works of this material or any part
//  of it without the prior written consent of Commencis.
//  Any reproduction of this material must contain this notice.
//

extension UIApplication {

    var topMostViewController: UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController
    }
}

extension UIViewController {

    var topMostViewController: UIViewController {

        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController!.topMostViewController
        }

        if let tabBarController = self as? UITabBarController {
            if let selectedController = tabBarController.selectedViewController {
                return selectedController.topMostViewController
            }
            return tabBarController.topMostViewController
        }

        if self.presentedViewController == nil {
            return self
        }

        if let navigationController = self.presentedViewController as? UINavigationController {
            return navigationController.visibleViewController!.topMostViewController
        }

        if let tabBarController = self.presentedViewController as? UITabBarController {
            if let selectedController = tabBarController.selectedViewController {
                return selectedController.topMostViewController
            }

            return tabBarController.topMostViewController
        }

        return self.presentedViewController!.topMostViewController
    }
}
