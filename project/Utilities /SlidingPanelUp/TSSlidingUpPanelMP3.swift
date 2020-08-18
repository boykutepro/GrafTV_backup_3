//
//  TSSlidingUpPanelMP3.swift
//  project
//
//  Created by tranthanh on 5/12/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


// The panel states
enum SLIDE_UP_PANEL_STATE_MP3 {
    case CLOSED
    case OPENED
    case DOCKED
}

// When the panel state is changed, the following delegate is called
// slidingUpPanelNewState: new state
// yPos: Y poisition of the panel at new state
protocol TSSlidingUpPanelStateDelegate_MP3: class {
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat)
}

//These delegates are called when the UI Animation, which is responsbile to move the layouts, start and finish
protocol TSSlidingUpPanelAnimationDelegate_MP3: class {
    // withDuration: how long does the animation take
    // slidingUpCurrentPanelState: at what state the animation is going to take place
    // yPos: at what Y Position the animation is going to take place
    func slidingUpPanelAnimationStart(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat)
    
    // withDuration: how long did it take
    // slidingUpCurrentPanelState: at what state the animation is finished
    // yPos: at what Y Position the animation is finished
    func slidingUpPanelAnimationFinished(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat)
}

protocol TSSlidingUpPanelDraggingDelegate_MP3: class {
    // when panel is began to be dragging by user
    // startYPos at what Y Position user began to drag the panel
    func slidingUpPanelStartDragging(startYPos: CGFloat)
    
    // When panel in being dragged by user
    // yPos: the center position of the panel
    func slidingUpPanelDraggingVertically(yPos: CGFloat)
    
    // When user is done by dragging
    // Delta: if it's positive , it means panel was being dragged to the bottom of the screen
    //        if it's negative , it means panel was being dragged to the top of the screen
    func slidingUpPanelDraggingFinished(delta:  CGFloat)
}

class TSSlidingUpPanelManager_MP3: NSObject {
   
    static let with = TSSlidingUpPanelManager_MP3()
    

    
    var slideUpPanelState_MP3:               SLIDE_UP_PANEL_STATE_MP3!
    var slidingUpPanelStateDelegate_MP3:     TSSlidingUpPanelStateDelegate_MP3?
    var slidingUpPanelAnimationDelegate_MP3: TSSlidingUpPanelAnimationDelegate_MP3?
    var slidingUpPanelDraggingDelegate_MP3:  TSSlidingUpPanelDraggingDelegate_MP3?
    var isVideo : Bool?
    // parent view
    var view_MP3:                 UIView!
    
    // slidingUp panel view
    var slidingUpPanelView_MP3:   UIView!
    
    
    
    // Position of the beginning of dragging panel
    var dragStartYPos:        CGFloat!
    
    // Height the view
    var viewFrameHeight:      CGFloat!
    
    // Minimum Y Position of the panel
    var minOverlayYPos:       CGFloat!
    
    
    // Panel header
    var headerSize:           CGFloat      = 49
    
    // Animation duration
    var animationDuration:    TimeInterval = 0.35
    
    
    private override init() {
    }
    
    func initPanelWithView(inView: UIView, slidingUpPanelView: UIView, slidingUpPanelHeaderSize: CGFloat) {
        
        initlizeParams(inView: inView, slidingUpPanelView: slidingUpPanelView, slidingUpPanelHeaderSize: slidingUpPanelHeaderSize)
    
        view_MP3.addSubview(slidingUpPanelView)
        setSlideUpPanelState()
    }

    func changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE_MP3) {
        var toSlideUpYPos: CGFloat!
       
        
        switch toState {
        case .CLOSED:
            toSlideUpYPos = viewFrameHeight
            break
        case .OPENED:
            toSlideUpYPos = 0
            break
        case .DOCKED:
            toSlideUpYPos = minOverlayYPos
            break
        }
        
        animatePanel(toSlideUpYPos: toSlideUpYPos)
    }
    
    func getSlideUpPanelState() -> SLIDE_UP_PANEL_STATE_MP3 {
        return slideUpPanelState_MP3
    }
    
    func scaleNumber(oldValue: CGFloat, newMin: CGFloat, newMax:CGFloat) -> CGFloat {
        let min = view_MP3.frame.height / 2
        let max = view_MP3.frame.height + min  + headerSize
        let oldRange = min - max
        let newRange = newMax - newMin
        return (((oldValue - min) * newRange) / oldRange) + newMin
        
    }
    
    private func initlizeParams(inView: UIView, slidingUpPanelView: UIView, slidingUpPanelHeaderSize: CGFloat) {
        self.view_MP3              = inView
        self.slidingUpPanelView_MP3 = slidingUpPanelView
        self.headerSize         = slidingUpPanelHeaderSize
        self.minOverlayYPos     = view_MP3.frame.height - ( headerSize)

        self.viewFrameHeight    = view_MP3.frame.height
        slidingUpPanelView.frame = CGRect(x: 0, y: viewFrameHeight, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let overlayPanGR: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panSlideUpView))
        
        slidingUpPanelView.addGestureRecognizer(overlayPanGR)
    }
    
    
    @objc private func panSlideUpView(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view_MP3)
        let min         = sender.view!.frame.height / 2
        let max         = sender.view!.frame.height + min  - (headerSize)
        var yPos        = sender.view!.center.y + translation.y
        yPos            = yPos > max ? max : (yPos <= min ? min : yPos)
      
        if sender.state == .began {
            
            dragStartYPos = yPos
            
            if slidingUpPanelDraggingDelegate_MP3 != nil {
                slidingUpPanelDraggingDelegate_MP3?.slidingUpPanelStartDragging(startYPos: dragStartYPos)
            }
            
        } else if sender.state == .changed {
            
            if slidingUpPanelDraggingDelegate_MP3 != nil {
                slidingUpPanelDraggingDelegate_MP3?.slidingUpPanelDraggingVertically(yPos: yPos)
            }
           
            sender.view!.center   = CGPoint(x: sender.view!.center.x, y: yPos)
            
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view_MP3)
            
        } else if sender.state == .ended {
            
            let delta = yPos - dragStartYPos
            
            if slidingUpPanelDraggingDelegate_MP3 != nil {
                slidingUpPanelDraggingDelegate_MP3?.slidingUpPanelDraggingFinished(delta: delta)
            }
            
            if delta > 0 {
                changeSlideUpPanelStateTo(toState: .DOCKED)
            } else {
                changeSlideUpPanelStateTo(toState: .OPENED)
            }
            
        }
    }
    
    private func animatePanel(toSlideUpYPos: CGFloat) {
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            if self.slidingUpPanelAnimationDelegate_MP3 != nil {
                self.slidingUpPanelAnimationDelegate_MP3?.slidingUpPanelAnimationStart(withDuration: self.animationDuration, slidingUpCurrentPanelState: self.slideUpPanelState_MP3, yPos: self.slidingUpPanelView_MP3.frame.origin.y)
            }
            
            self.slidingUpPanelView_MP3.frame.origin.y = toSlideUpYPos
            
           
            
        }, completion: { completed in
            
            self.setSlideUpPanelState()
            if self.slidingUpPanelAnimationDelegate_MP3 != nil {
                self.slidingUpPanelAnimationDelegate_MP3?.slidingUpPanelAnimationFinished(withDuration: self.animationDuration, slidingUpCurrentPanelState: self.slideUpPanelState_MP3, yPos: self.slidingUpPanelView_MP3.frame.origin.y)
            }
            
        })
    }
    
    private func setSlideUpPanelState() {
        let y = slidingUpPanelView_MP3.frame.origin.y
        
        if y == viewFrameHeight {
            slideUpPanelState_MP3 = .CLOSED
        } else if y == minOverlayYPos {
            slideUpPanelState_MP3 = .DOCKED
        } else {
            slideUpPanelState_MP3 = .OPENED
        }
        
        if slidingUpPanelStateDelegate_MP3 != nil {
            slidingUpPanelStateDelegate_MP3?.slidingUpPanelStateChanged(slidingUpPanelNewState: slideUpPanelState_MP3, yPos: y)
        }
    }
}











