import UIKit
import QuartzCore

@IBDesignable
class UIActionButton: UIButton {
    
    var _backgroundColor: UIColor? = nil
    
    @IBInspectable override var backgroundColor: UIColor? {
        didSet {
            _backgroundColor = backgroundColor
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if let backgroundColor = isHighlighted ? _backgroundColor?.highlightColor : _backgroundColor {
                layer.backgroundColor = backgroundColor.cgColor
            }
        }
    }
    
    func pressedColor(color: UIColor?) -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if color?.getRed(&r, green: &g, blue: &b, alpha: &a) ?? false {
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        
        return UIColor()
    }
}

extension UIColor {
    var highlightColor: UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        
        return self
    }
}
