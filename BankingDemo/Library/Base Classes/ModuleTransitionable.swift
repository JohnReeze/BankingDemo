//
//  ModuleTransitionable.swift
//  BankingDemo
//

import UIKit

/// Base protocol for all view. If need to do custom transition then should
/// create new protocol, implement current and override desired method
///
/// Examples:
///
/// 1. If screen A can be open from screnn B with custom transition
///
/// ```
/// protocol CustomModuleTransitionable: class, ModuleTransitionable {
/// }
///
/// extension CustomModuleTransitionable {
///    func showModule(_ module: UIViewController) {
///        *do something custom to show B*
///    }
///}
/// ```
///
/// 2. If screen A can be open from screen B, C, D in different ways
///
/// ```
///protocol CustomModuleTransitionable: class, ModuleTransitionable {
///    func showModuleWithCustomTransitionFromB(_ module: UIViewController)
///    func showModuleWithCustomTransitionFromC(_ module: UIViewController)
///    func showModuleWithCustomTransitionFromD(_ module: UIViewController)
///}
///
///extension CustomModuleTransitionable {
///    func showModuleWithCustomTransitionFromB(_ module: UIViewController) {
///        *do something custom to show from B*
///    }
///    func showModuleWithCustomTransitionFromC(_ module: UIViewController) {
///        *do something custom to show from С*
///    }
///    func showModuleWithCustomTransitionFromD(_ module: UIViewController) {
///        *do something custom to show from D*
///    }
///}
///```
protocol ModuleTransitionable: class {

    /// Type of UIViewController
    var typeOfViewController: UIViewController.Type? { get }

    /// Presents a view controller in a primary context.
    ///
    /// - Parameter module: ViewController that should be presented.
    func showModule(_ module: UIViewController)

    /// Dismisses the view controller that was presented modally by the view controller.
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is dismissed.
    /// This block has no return value and takes no parameters. You may specify nil for this parameter.
    func dismissView(animated: Bool, completion: (() -> Void)?)

    /// Dismisses only one top view controller that was presented modally by the view controller
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is dismissed.
    /// This block has no return value and takes no parameters. You may specify nil for this parameter.
    func dismissTopView(animated: Bool, completion: (() -> Void)?)

    /// Dismisses every view controller that was presented modally by root view controller
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is dismissed.
    /// This block has no return value and takes no parameters. You may specify nil for this parameter.s
    func dismissAllView(animated: Bool, completion: (() -> Void)?)

    /// Presents a view controller modally.
    ///
    /// - Parameters:
    ///   - module: UIViewController that should be presented.
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is presnted.
    /// This block has no return value and takes no parameters. You may specify nil for this parameter.
    func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Presents a view controller modally from root view controller.
    ///
    /// - Parameters:
    ///   - module: UIViewController that should be presented.
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is presnted.
    /// This block has no return value and takes no parameters. You may specify nil for this parameter.
    func presentModuleFormRoot(_ module: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Dismisses last view controller that was presented modally by root view controller
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The block to execute after the view controller is dismissed.
    func dismissPresentedView(animated: Bool, completion: (() -> Void)?)

    /// Pops the top view controller from the navigation stack and updates the display.
    ///
    /// - Parameter animated: Pass true to animate the transition.
    func pop(animated: Bool)

    /// Pushes a view controller onto the receiver’s stack and updates the display.
    ///
    /// - Parameters:
    ///   - module: ViewController that should be presented.
    ///   - animated: Pass true to animate the transition.
    func push(module: UIViewController, animated: Bool)

    /// Pushes a view controller onto the receiver’s stack and updates the display.
    ///
    /// - Parameters:
    ///   - module: ViewController that should be presented.
    ///   - animated: Pass true to animate the transition.
    ///   - hideTabBar: Pass true to hide a tab bar.
    func push(module: UIViewController, animated: Bool, hideTabBar: Bool)

    /// Pushes a view controller onto the receiver’s stack and and remove current view from stack.
    ///
    /// - Parameters:
    ///   - module: ViewController that should be presented.
    ///   - animated: Pass true to animate the transition.
    func pushWithReplace(module: UIViewController, animated: Bool)

    /// Pop all view controllers to root view controller in hierachy
    ///
    /// - Parameter animated: Pass true to animate the transition.
    func popToRoot(animated: Bool)

    /// Pop any view controller to reach special vc in hierarchy
    ///
    /// - Parameter viewContollerType: type of VC that should be presented.
    /// - Parameter animated: Pass true to animate the transition.
    func popToSpecial(viewControllerType: Swift.AnyClass, animated: Bool)

    /// Pop any view controller to reach special vc in hierarchy
    ///
    /// - Parameter popToVC: method will pop to this ViewController type
    /// - Parameter pushVC: method will push this viewController
    /// - Parameter animated: Pass true to animate the transition.
    func popToSpecialAndPush(popToVC: Swift.AnyClass, pushVC: UIViewController, animated: Bool)
}

extension ModuleTransitionable where Self: UIViewController {

    var typeOfViewController: UIViewController.Type? {
        return type(of: self)
    }

    func showModule(_ module: UIViewController) {
        self.show(module, sender: nil)
    }

    func dismissView(animated: Bool, completion: (() -> Void)?) {
        self.presentingViewController?.dismiss(animated: animated, completion: completion)
    }

    func dismissPresentedView(animated: Bool, completion: (() -> Void)?) {
        guard presentedViewController.isSome else {
            completion?()
            return
        }
        self.dismiss(animated: animated, completion: completion)
    }

    func dismissTopView(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }

    func dismissAllView(animated: Bool, completion: (() -> Void)?) {
        self.view.window?.rootViewController?.dismiss(animated: animated, completion: completion)
    }

    func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(module, animated: animated, completion: completion)
    }

    func presentModuleFormRoot(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let rootViewController = UIApplication.shared.windows.first?.rootViewController
        rootViewController?.present(module, animated: animated, completion: completion)
    }

    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }

    func push(module: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(module, animated: animated)
    }

    func push(module: UIViewController, animated: Bool, hideTabBar: Bool) {
        module.hidesBottomBarWhenPushed = hideTabBar
        push(module: module, animated: animated)
    }

    func pushWithReplace(module: UIViewController, animated: Bool) {
        var newStack = self.navigationController?.viewControllers ?? []

        if !newStack.isEmpty {
            newStack.removeLast()
        }

        newStack.append(module)
        self.navigationController?.setViewControllers(newStack, animated: animated)
    }

    func popToRoot(animated: Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
}

extension ModuleTransitionable where Self: UIViewController {

    func popToSpecial(viewControllerType: Swift.AnyClass, animated: Bool) {
        if let viewControllers = self.navigationController?.viewControllers {
            for controller in viewControllers as Array {
                if controller.isKind(of: viewControllerType) {
                    self.navigationController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }

    func popToSpecialAndPush(popToVC: Swift.AnyClass, pushVC: UIViewController, animated: Bool) {
        if var viewControllers = self.navigationController?.viewControllers {
            var index = 0
            for (key, controller) in (viewControllers as Array).enumerated() {
                if controller.isKind(of: popToVC) {
                    index = key
                }
            }

            viewControllers.removeLast(viewControllers.count - (index + 1))
            viewControllers.append(pushVC)
            self.navigationController?.pushViewController(pushVC, animated: animated)
            self.navigationController?.viewControllers = viewControllers
        }
    }

}
