@objc(TvFocusWrapperViewManager)

class TvFocusWrapperViewManager: RCTViewManager {
    override func view() -> (TvFocusWrapperView) {
        return TvFocusWrapperView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return false
    }
}

class TvFocusWrapperView : UIView {
    @objc var onFocus: RCTBubblingEventBlock?
    @objc var onBlur: RCTBubblingEventBlock?
    @objc var onPress: RCTBubblingEventBlock?
    @objc var scale: NSString?
    @objc var focusable: NSNumber? = 1
    @objc var enableFocusStyle: NSNumber? = 1
    @objc var focusStyle: NSDictionary?
    @objc var gradientProps: NSDictionary?
    @objc var enableGradient: NSNumber? = 0
    let event = ["value": "focusEvent"]
    let pressEvent = ["value": "pressEvent"]
    let gradientLayer = CAGradientLayer()
    
    
    init() {
        super.init(frame: .zero)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.onClick (_:)))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClick(_ sender:UITapGestureRecognizer){
        if onPress != nil {
            onPress!(self.pressEvent)
        }
    }
    
    
    func insertReactSubview(view:UIView!, atIndex:Int) {
        self.insertSubview(view, at:atIndex)
        return
    }
    
    override var canBecomeFocused: Bool {
        return self.focusable == 1
    }
    
    
    @available(iOS 9.0, *)
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            if onFocus != nil {
                onFocus!(self.event)
            }
            coordinator.addCoordinatedAnimations({ () -> Void in
                if (self.enableFocusStyle == 1) {
                    self.layer.borderWidth = self.focusStyle?["borderWidth"] as? CGFloat ?? 4
                    if let borderColor = self.focusStyle?["borderColor"] as? String {
                        self.layer.borderColor = UIColor(hex: borderColor)?.cgColor
                    } else {
                        self.layer.borderColor = UIColor.white.cgColor
                    }
                    if(self.enableGradient == 1){
                        if let colorTop = self.gradientProps?["colorTop"] as? String, let colorBottom = self.gradientProps?["colorBottom"] as? String {
                            self.gradientLayer.colors = [UIColor(hex: colorTop)?.cgColor ??  UIColor.clear.cgColor, UIColor(hex: colorBottom)?.cgColor ??  UIColor.clear.cgColor]
                        }
                        self.gradientLayer.locations = [0.0, 1.0]
                        self.gradientLayer.frame = self.bounds
                        self.layer.insertSublayer(self.gradientLayer, at:0)
                    }
                } else {
                    self.layer.borderWidth = 0
                    self.layer.backgroundColor = UIColor.clear.cgColor
                    self.gradientLayer.removeFromSuperlayer()
                }
                let scaleFactor = CGFloat(Float(self.scale! as Substring) ?? 1)
                self.layer.transform = CATransform3DMakeScale(scaleFactor, scaleFactor, scaleFactor)
            }, completion: nil)
            
        } else if context.previouslyFocusedView == self {
            if onBlur != nil {
                onBlur!(self.event)
            }
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.borderWidth = 0
                self.layer.backgroundColor = UIColor.clear.cgColor
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.gradientLayer.removeFromSuperlayer()
            }, completion: nil)
        }
    }
}

