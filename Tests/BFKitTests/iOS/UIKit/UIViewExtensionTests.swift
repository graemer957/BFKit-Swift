//
//  UIViewExtensionTests.swift
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2017 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
import Foundation
import UIKit
@testable import BFKit

class UIViewExtensionTests: XCTestCase {
    var view: UIView = UIView()
    
    override func setUp() {
        super.setUp()
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBorderColorRadiusWidth() {
        view.border(color: UIColor.red, radius: 5, width: 2)
        
        XCTAssert(view.layer.borderWidth == 2)
        XCTAssert(view.layer.cornerRadius == 5)
        XCTAssert(view.layer.borderColor == UIColor.red.cgColor)
    }
    
    func testRemoveBorder() {
        view.border(color: UIColor.red, radius: 5, width: 2)
        view.removeBorder()
        
        XCTAssert(view.layer.borderWidth == 0)
        XCTAssert(view.layer.cornerRadius == 0)
        XCTAssert(view.layer.borderColor == nil)
    }
    
    func testCornerRadiusCornersRadius() {
        view.cornerRadius(corners: .allCorners, radius: 5)
        
        XCTAssertNotNil(view.layer.mask)
    }
    
    func testShadowOffsetOpacityRadiusCornerRadiusColor() {
        view.shadow(offset: CGSize(width: 5, height: 5), opacity: 0.5, radius: 5, cornerRadius: 5, color: UIColor.red)
        
        XCTAssert(view.layer.shadowColor == UIColor.red.cgColor)
        XCTAssert(view.layer.shadowOpacity == 0.5)
        XCTAssert(view.layer.shadowOffset == CGSize(width: 5, height: 5))
        XCTAssert(view.layer.shadowRadius == 5)
        XCTAssert(view.layer.cornerRadius == 5)
    }
    
    func testRemoveShadow() {
        view.shadow(offset: CGSize(width: 5, height: 5), opacity: 0.5, radius: 5, cornerRadius: 5, color: UIColor.red)
        view.removeShadow()
        
        XCTAssert(view.layer.shadowColor == nil)
        XCTAssert(view.layer.shadowOpacity == 0)
        XCTAssert(view.layer.shadowOffset == CGSize(width: 0, height: 0))
        XCTAssert(view.layer.shadowRadius == 0)
        XCTAssert(view.layer.cornerRadius == 0)
    }
    
    func testGradientColorsDirection() {
        view.gradient(colors: [UIColor.red, UIColor.green, UIColor.blue], direction: .custom(startPoint: CGPoint(x: 10, y: 10), endPoint: CGPoint(x: 90, y: 90)))
        
        XCTAssert(view.frame == CGRect(x: 0, y: 0, width: 200, height: 100))
    }
    
    func testApplyMotionEffect() {
        view.applyMotionEffects()
        
        XCTAssert(view.motionEffects != [])
    }
    
    func testScreenshotSave() {
        guard let screenshot = view.screenshot(save: true) else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(screenshot)
    }
    
    func testShakeCountDurationTranslation() {
        view.shake(count: 5, duration: 1, translation: 10)
        
        XCTAssertNotNil(view.layer.animation(forKey: "shake"))
    }
    
    func testPulseCountDuration() {
        view.pulse(count: 5, duration: 1)
        
        XCTAssertNotNil(view.layer.animation(forKey: "pulse"))
    }
    
    func testHeartbeatMaxSizeDurationPerBeat() {
        view.heartbeat(count: 5, maxSize: 1.4, durationPerBeat: 1)
        
        XCTAssertNotNil(view.layer.animation(forKey: "heartbeat"))
    }
    
    /*func testFlipDurationDirection() {
        view.flip(duration: 1, direction: .top)
        
        XCTAssertNotNil(view.layer.animation(forKey: "flip"))
    }*/
    
    func testTranslateAroundTopViewDurationDIrectionRepeatAnimationStartFromEdge() {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 100))
        view.translateAround(topView: topView, duration: 1, direction: .leftToRight, repeatAnimation: true, startFromEdge: true)
        
        XCTAssert(view.frame.width == 200)
        XCTAssert(view.frame.height == 100)
    }
    
    func testAnimatePathCountDurationAutoreverses() {
        let path = UIBezierPath()
        path.addLine(to: CGPoint(x: 100, y: 100))
        view.animate(path: path, count: 1, duration: 1)
        
        XCTAssertNotNil(view.layer.animation(forKey: "animateAlongPath"))
    }
    
    func testBorderWidth() {
        view.borderWidth = 2
        
        XCTAssert(view.layer.borderWidth == 2)
    }
    
    func testBorderColor() {
        view.borderColor = UIColor.red
        
        XCTAssert(view.layer.borderColor == UIColor.red.cgColor)
    }
    
    func testMaskToBounds() {
        view.maskToBounds = true
        
        XCTAssertTrue(view.maskToBounds)
    }
    
    func testCornerRadius() {
        view.cornerRadius = 5
        
        XCTAssert(view.layer.cornerRadius == 5)
    }
    
    func testShadowColor() {
        view.shadowColor = UIColor.blue
        
        XCTAssert(view.layer.shadowColor == UIColor.blue.cgColor)
    }
    
    func testShadowOpacity() {
        view.shadowOpacity = 0.5
        
        XCTAssert(view.layer.shadowOpacity == 0.5)
    }
    
    func testShadowOffsetX() {
        view.shadowOffsetX = 2
        
        XCTAssert(view.layer.shadowOffset == CGSize(width: 2, height: view.layer.shadowOffset.height))
    }
    
    func testShadowOffsetY() {
        view.shadowOffsetY = 2
        
        XCTAssert(view.layer.shadowOffset == CGSize(width: view.layer.shadowOffset.width, height: 2))
    }
    
    func testShadowRadius() {
        view.shadowRadius = 5
        
        XCTAssert(view.layer.shadowRadius == 5)
    }
}
