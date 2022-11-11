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
      coordinator.addCoordinatedAnimations({ () -> Void in
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.white.cgColor
    }, completion: nil)

    } else if context.previouslyFocusedView == self {
      coordinator.addCoordinatedAnimations({ () -> Void in
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.clear.cgColor
      }, completion: nil)
    }
  }
}
