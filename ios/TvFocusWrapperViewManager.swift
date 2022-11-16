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
    let event = ["value": "focusEvent"]
    let pressEvent = ["value": "pressEvent"]
    

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
    return true
  }
    
    
  @available(iOS 9.0, *)
  override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if context.nextFocusedView == self {
        if onFocus != nil {
            onFocus!(self.event)
        }
      coordinator.addCoordinatedAnimations({ () -> Void in
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.white.cgColor
    }, completion: nil)

    } else if context.previouslyFocusedView == self {
        if onBlur != nil {
            onBlur!(self.event)
        }
      coordinator.addCoordinatedAnimations({ () -> Void in
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.clear.cgColor
      }, completion: nil)
    }
  }
}

