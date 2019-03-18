//
//  Extensions.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/18.
//  Copyright © 2019 yinghu. All rights reserved.
//
import UIKit

public class NotificationNames {
    fileprivate init() {}
}

/// Base class for static user defaults keys. Specialize with value type
/// and pass key name to the initializer to create a key.

public class NotificationName: NotificationNames {
    // TODO: Can we use protocols to ensure ValueType is a compatible type?
    
    public let _key: String
    
    public init(_ key: String) {
        self._key = key
        super.init()
    }
    
    public init(name: NSNotification.Name) {
        self._key = name.rawValue
        super.init()
    }
}

extension NotificationNames {
    static let testNotificationName = NotificationName("testNotificationName")
}

extension NotificationCenter {
    static func postNotification(name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name._key), object: object)
    }
}


extension UIViewController {
    func addObserver(with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }
    
    func addObserver(with selector: Selector, name: NotificationName, object: Any? = nil) {
        addObserver(with: selector, name: NSNotification.Name(rawValue: name._key), object: object)
    }
    
    func postNotification(name: NSNotification.Name, object: Any? = nil) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    func postNotification(name: NotificationName, object: Any? = nil) {
        postNotification(name: NSNotification.Name(rawValue: name._key), object: object)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @discardableResult
    func showAlert(actionTitle: String = "确定", title: String? = nil, message: String?, style: UIAlertControllerStyle = .alert, handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        present(alert, animated: true, completion: nil)
        return alert.action(actionTitle, handle)
    }
    
    public func transion<C: UIViewController>(to dest: Dest, animated: Bool = true, handle: ((C) -> Void)? = nil) {
        let vc: UIViewController
        switch dest {
        case let .controller(c):
            vc = c
        case let .dest(c):
            vc = c.init()
        case .web(_):
            fatalError("请配置网页")
        //            vc = HTUIControlCenter.webView(withUrl: url)
        case let .scheme(s):
            guard let url = URL(string: s.scheme) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return
        default:
            return
        }
        if let c = vc as? C {
            handle?(c)
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
}

public enum Dest {
    case none
    // 用SegueRow，把创建对象延迟到跳转时
    case dest(UIViewController.Type)
    case controller(UIViewController)
    case web(String)
    case scheme(Scheme)
}

extension Dest: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "none"
        case let .dest(dest):
            return "\(dest)"
        case let .controller(vc):
            return vc.description
        case let .web(str):
            return "\(str)"
        case let .scheme(s):
            return "\(s.scheme)"
        }
    }
}

// https://github.com/cyanzhong/app-tutorials/blob/master/schemes.md
// http://www.jianshu.com/p/bb3f42fdbc31
public enum Scheme {
    case plain(String)
    case tel(String)
    case wifi
    case appStore
    case mail(String)
    case notification
    
    var scheme: String {
        let scheme: String
        switch self {
        case let .plain(s):
            scheme = s
        case let .tel(s):
            scheme = "tel://" + s
        case .wifi:
            scheme = "App-Prefs:root=WIFI"
        case .appStore:
            scheme = "itms-apps://itunes.apple.com/cn/app/id\(1111)?mt=8"
        case let .mail(s):
            scheme = "mailto://\(s)"
        case .notification:
            scheme = "App-Prefs:root=NOTIFICATIONS_ID"
        }
        return scheme
    }
}

extension UIAlertController {
    @discardableResult
    func action(_ title: String, style: UIAlertActionStyle = .`default`, _ handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: style, handler: handle)
        addAction(action)
        return self
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UITableView {
    
    /** Resize a tableView header to according to the auto layout of its contents.
     - This method can resize a headerView according to changes in a dynamically set text label. Simply place this method inside viewDidLayoutSubviews.
     - To animate constrainsts, wrap a tableview.beginUpdates and .endUpdates, followed by a UIView.animateWithDuration block around constraint changes.
     */
    func sizeHeaderToFit() {
        guard let headerView = tableHeaderView else {
            return
        }
        let oldHeight = headerView.frame.height
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        headerView.frame.size.height = height
        contentSize.height += (height - oldHeight)
        headerView.layoutIfNeeded()
        
    }
    
    func sizeFooterToFit() {
        guard let footerView = tableFooterView else {
            return
        }
        let oldHeight = footerView.frame.height
        let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        footerView.frame.size.height = height
        contentSize.height += (height - oldHeight)
        footerView.layoutIfNeeded()
    }
}

extension UIViewController {
    var visibleViewControllerIfExist: UIViewController? {
        
        if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewControllerIfExist
        }
        if let nav = self as? UINavigationController {
            return nav.topViewController?.visibleViewControllerIfExist
        }
        if let tabbar = self as? UITabBarController {
            return tabbar.selectedViewController?.visibleViewControllerIfExist
        }
        
        if isViewLoaded && view.window != nil {
            return self
        } else {
            print("qmui_visibleViewControllerIfExist:，找不到可见的viewController。self = \(self), view.window = \(String(describing: view.window))")
            return nil
        }
    }
}

extension UIView {
    public func viewController<T: UIViewController>() -> T? {
        var viewController: UIViewController?
        var next = self.next
        while let _next = next {
            if _next.isKind(of: UIViewController.self) {
                viewController = next as? UIViewController
                break
            }
            next = _next.next
        }
        return viewController as? T
    }
}
