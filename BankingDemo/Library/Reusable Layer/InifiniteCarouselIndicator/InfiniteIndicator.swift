//
//  InfiniteIndicator.swift
//  BankingDemo
//

import UIKit

final class InfiniteInidicator: UIView {

    private lazy var indicatorView = UIView()
    private lazy var supportIndicatorView = UIView()

    private var lenght: Int = 0

    private var inidicatorLenght: CGFloat {
        guard lenght > 0 else { return 0 }
        return frame.width / CGFloat(lenght)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.backgroundColor = .red
        indicatorView.frame = .init(x: 0, y: 0, width: inidicatorLenght, height: self.frame.height)
        supportIndicatorView.backgroundColor = .red
        supportIndicatorView.frame = .init(x: 0, y: 0, width: inidicatorLenght, height: self.frame.height)
        self.addSubview(indicatorView)
        self.addSubview(supportIndicatorView)
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
        supportIndicatorView.layer.cornerRadius = supportIndicatorView.frame.height / 2
        self.layer.masksToBounds = true
    }

    func configure(lenght: Int, index: Int = 0) {
        self.lenght = lenght
        indicatorView.frame = .init(x: 0, y: 0, width: inidicatorLenght, height: self.frame.height)
        supportIndicatorView.frame = .init(x: 0, y: 0, width: inidicatorLenght, height: self.frame.height)
        supportIndicatorView.isHidden = true
    }

    func set(progress: Double, from: Int, to: Int) {
        switch (from, to) {
        case (0, lenght - 1):
            supportIndicatorView.isHidden = false
            indicatorView.frame = .init(x: CGFloat(-progress) * inidicatorLenght,
                                        y: 0,
                                        width: inidicatorLenght,
                                        height: self.frame.height)
            supportIndicatorView.setX(self.frame.width - CGFloat(progress) * inidicatorLenght)
        case (lenght - 1, 0):
            supportIndicatorView.isHidden = false
            indicatorView.setX(self.frame.width - CGFloat(1 - progress) * inidicatorLenght)
            supportIndicatorView.setX(-inidicatorLenght + CGFloat(progress) * inidicatorLenght)
        default:
            supportIndicatorView.isHidden = true
            let offset = CGFloat(progress) * inidicatorLenght
            let indexOffset = inidicatorLenght * CGFloat(from)
            let tmp = from > to ? -offset : offset
            indicatorView.setX(indexOffset + tmp)
        }

    }

}
extension UIView {

    func setX(_ x: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }

}
