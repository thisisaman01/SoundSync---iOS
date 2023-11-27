import UIKit

class GradientView: UIView {
    private var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    func setColors(startColor: UIColor, endColor: UIColor, alpha: CGFloat) {
        gradientLayer.colors = [startColor.withAlphaComponent(alpha).cgColor, endColor.cgColor]
    }
}

