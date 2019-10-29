import UIKit

class UIInsetLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = CGFloat(0)
    @IBInspectable var bottomInset: CGFloat = CGFloat(0)
    @IBInspectable var leftInset: CGFloat = CGFloat(0)
    @IBInspectable var rightInset: CGFloat = CGFloat(0)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
