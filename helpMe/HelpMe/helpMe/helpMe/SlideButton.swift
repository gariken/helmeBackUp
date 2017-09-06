import UIKit

protocol SlideButtonDelegate: NSObjectProtocol {
    func sliderDidSlide()
}

@IBDesignable
class SlideButton: UIView {
    
    @IBInspectable var borderColor: UIColor = .white {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable var text: String? = "" {
        didSet { label?.text = text }
    }
    
    @IBInspectable var textColor: UIColor = .black {
        didSet { label?.textColor = textColor }
    }
    
    @IBInspectable var image: UIImage? {
        didSet { icon?.image = image }
    }

    @IBInspectable var activeImage: UIImage? {
        didSet { }
    }
    
    @IBInspectable var sliderColor: UIColor = .white {
        didSet { slider?.backgroundColor = sliderColor }
    }
    
    @IBInspectable var sliderTintColor: UIColor = .black {
        didSet { icon?.tintColor = sliderTintColor }
    }
    
    @IBInspectable var fontName: String? {
        didSet {
            if let fontName = fontName, let fontSize = fontSize {
                font = UIFont(name: fontName, size: fontSize)
            }
        }
    }

    @IBInspectable var fontSize: CGFloat? {
        didSet {
            if let fontName = fontName, let fontSize = fontSize {
                font = UIFont(name: fontName, size: fontSize)
            }
        }
    }
    
    var font: UIFont? = UIFont.systemFont(ofSize: 20) {
        didSet { label?.font = font }
    }
    
    private var label: UILabel?
    private var slider: UIView?
    private var sliderLineView: UIView?
    private var icon: UIImageView?
    var sliderPosition: CGFloat = 5 {
        didSet {
            horizontalConstraints?.first?.constant = sliderPosition
            animageLabel()
        }
    }
    
    weak var delegate: SlideButtonDelegate?
    
    private var animationCompleted: Bool = true
    var lockAction: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createLabel() {
//        let size = text!.sizeOfString(usingFont: font!)
        let size = CGSize (width: 100, height: 30)

        let frame = CGRect(x: 20, y: 20, width: size.width, height: size.height)
        label = UILabel(frame: frame)
        label?.textColor = textColor
        label?.backgroundColor = .clear
        label?.textAlignment = .center
        label?.text = text
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.sizeToFit()
        addSubview(label!)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[label]-5-|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["label": label!])
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[label]-5-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["label": label!])
        
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
    }
    
    private func setupView() {
        createLabel()
        createSliderLineView()
        createSlider()
    }
    
    var horizontalConstraints: [NSLayoutConstraint]?
    
    private func createSlider() {
        let height = self.frame.size.height - 10
        let frame = CGRect(x: 5, y: 5, width: height, height: height)
        slider = UIView(frame: frame)
        slider?.backgroundColor = sliderColor
        slider?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(slider!)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[slider]-5-|",
                                                                 options: [],
                                                                 metrics: ["height": height],
                                                                 views: ["slider": slider!])
        
        horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[slider]",
                                                               options: [],
                                                               metrics: ["height": height],
                                                               views: ["slider": slider!])
        
        let aspectRatioConstraint = NSLayoutConstraint(item: slider!,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: slider,
                                                       attribute: .width,
                                                       multiplier: (1 / 1),
                                                       constant: 0)
        
        slider?.addConstraint(aspectRatioConstraint)
        
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints!)
        
        slider?.layer.masksToBounds = false
        slider?.layer.borderWidth = borderWidth
        slider?.layer.borderColor = borderColor.cgColor
        slider?.layer.cornerRadius = frame.size.height / 2
        
        slider?.layer.shadowOffset = CGSize(width: 0, height: 4)
        slider?.layer.shadowRadius = 4
        slider?.layer.shadowOpacity = 0.5
        slider?.layer.shadowColor = UIColor.black.cgColor
        
        createIcon()
        addGesture()
    }
    
    private func createSliderLineView() {
        let width = self.frame.size.width - 10
        let height = 2*(self.frame.size.height - 10)/3
        let frame = CGRect(x: 5, y: (self.frame.size.height - height)/2, width: width, height: height)
        sliderLineView = UIView(frame: frame)
        sliderLineView?.translatesAutoresizingMaskIntoConstraints = false
        
        sliderLineView?.backgroundColor = UIColor (red: 96/255, green: 113/255, blue: 139/255, alpha: 1.0)
        sliderLineView?.layer.masksToBounds = true
        sliderLineView?.layer.cornerRadius = frame.size.height / 2

        addSubview(sliderLineView!)
    }

    private func createIcon() {
        let frame = CGRect(x: 0, y: 0, width: 5, height: 10)
        icon = UIImageView(frame: frame)
        icon?.tintColor = sliderTintColor
        icon?.translatesAutoresizingMaskIntoConstraints = false
        icon?.image = image
        icon?.contentMode = .scaleAspectFit
        
        slider?.addSubview(icon!)
        
        let xConstraint = NSLayoutConstraint(item: icon!, attribute: .centerX, relatedBy: .equal, toItem: slider, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: icon!, attribute: .centerY, relatedBy: .equal, toItem: slider, attribute: .centerY, multiplier: 1, constant: 0)
        
        slider?.addConstraint(xConstraint)
        slider?.addConstraint(yConstraint)
    }
    
    private func addGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(slide(_:)))
        slider?.addGestureRecognizer(gesture)
    }
    
    @objc private func slide(_ gesture: UIPanGestureRecognizer) {
        let rightBound: CGFloat = frame.size.width - slider!.frame.width - 5
        let velocity = gesture.velocity(in: self).x
        let location = gesture.location(in: self).x
        
        if velocity > 1500 {
            slideToEnd()
        } else if velocity < -1500 {
            slideToBegining()
        } else {
            moveSliderTo(x: location)
            switch gesture.state {
            case .ended:
                if location > rightBound * 3 / 4 {
                    slideToEnd()
                } else {
                    slideToBegining()
                }
            case .cancelled:
                slideToBegining()
            case .failed:
                slideToBegining()
            default:
                break
            }
        }
    }
    
    private func moveSliderTo(x: CGFloat) {
        guard animationCompleted else { return }
        
        let leftBound: CGFloat = 5
        let rightBound: CGFloat = frame.size.width - slider!.frame.width - 5
        
        if x >= leftBound && x <= rightBound {
            sliderPosition = x
            UIView.animate(withDuration: 0.05, animations: {
                self.layoutIfNeeded()
            }) { _ in
                if x == rightBound {
                    if !self.lockAction {
                        self.lockAction = true
                        self.delegate?.sliderDidSlide()
                    }
                }
                self.animationCompleted = true
            }
        }
    }
    
    private func slideToEnd() {
        guard animationCompleted else { return }
        
        animationCompleted = false
        let rightBound = frame.size.width - slider!.frame.width - 5
        
        sliderPosition = rightBound
        UIView.animate(withDuration: 0.2, animations: {
            self.label?.alpha = 0.1
            self.layoutIfNeeded()
        }) { _ in
            if !self.lockAction {
                self.lockAction = true
                self.icon?.image = self.activeImage
                self.sliderLineView?.backgroundColor = .red
//                self.backgroundColor = .red
                self.delegate?.sliderDidSlide()
            }
            self.animationCompleted = true
        }
    }
    
    private func slideToBegining() {
        guard animationCompleted else { return }
        animationCompleted = false
        
        sliderPosition = 5
        UIView.animate(withDuration: 0.2, animations: {
            self.label?.alpha = 1
            self.layoutIfNeeded()
        }) { _ in
            self.animationCompleted = true
            self.lockAction = false
            self.icon?.image = self.image
            self.sliderLineView?.backgroundColor = UIColor (red: 96/255, green: 113/255, blue: 139/255, alpha: 1.0)
//            self.backgroundColor = .lightGray
            self.delegate?.sliderDidSlide()
        }
    }
    
    private func animageLabel() {
        let rightBound = frame.size.width - slider!.frame.width - 5
        let newAlpha = 1 - sliderPosition / rightBound
        UIView.animate(withDuration: 0.05) {
            self.label?.alpha = newAlpha < 0.1 ? 0.1 : newAlpha
        }
    }
    
    func reset() {
        slideToBegining()
        lockAction = false
    }
}
