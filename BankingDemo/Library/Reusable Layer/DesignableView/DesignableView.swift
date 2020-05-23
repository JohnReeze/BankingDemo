//
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// Inherit custom subview from this class instead of UIView,
///     mark it as @IBDesignable,
///     set the file's owner and do not set the View's class,
///     =>
///     It renders in the IB!

// swiftlint:disable all
open class DesignableView: UIView {

    // MARK: - Public Properties

    public var view: UIView {
        return subviews.first!
    }

    // MARK: - Initialization

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        _ = setup()
    }

    // MARK: - Private Properties

    private func setup() -> UIView? {
        let view = Bundle(for: type(of: self)).loadNibNamed(self.nameOfClass, owner: self, options: nil)?.first as? UIView
        if let v = view {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                v.topAnchor.constraint(equalTo: topAnchor),
                v.bottomAnchor.constraint(equalTo: bottomAnchor),
                v.leadingAnchor.constraint(equalTo: leadingAnchor),
                v.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        return view
    }

}

extension NSObject {

    var nameOfClass: String {
        if let name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last {
            return name
        }
        return ""
    }

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

}
// swiftlint:enable all
