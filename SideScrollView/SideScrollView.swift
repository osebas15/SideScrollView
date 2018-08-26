//
//  SideScrollView.swift
//  PDIS
//
//  Created by Sebastian Aguirre on 8/17/18.
//  Copyright © 2018 SeaCap. All rights reserved.
//

import UIKit

open class SideScrollView: UIView {
    
    
    private var _textArray = [String]()
    public var textArray : [String]{
        set{
            _textArray = newValue
            currentTextIndex = 0
        }
        get{
            return _textArray
        }
    }

    
    private var _currentTextIndex = 0
    public var currentTextIndex : Int {
        set{
            if textArray.count > newValue{
                _currentTextIndex = newValue
                self.label.text = textArray[currentTextIndex]
            }
        }
        get{
            return _currentTextIndex
        }
    }
    
    let label = UILabel()
    let leftButton = UIButton()
    let rightButton = UIButton()
    
    override open var frame: CGRect {
        set{
            super.frame = newValue
            
            let buttonSize = CGSize(width: newValue.height, height: newValue.height)
            
            leftButton.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                      size: buttonSize)
            
            rightButton.frame = CGRect(origin: CGPoint(x: newValue.width - newValue.height, y:0),
                                       size: buttonSize)
            
            label.frame = CGRect(x: newValue.height,
                                     y: 0,
                                     width: newValue.width - (newValue.height * 2),
                                     height: newValue.height)

        }
        get{
            return super.frame
        }
    }
    
    
    public init(frame: CGRect, textArray: [String]) {
        super.init(frame: frame)
        
        self.textArray = textArray
        
        setUpSubviews(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubviews(frame: CGRect){
        
        leftButton.addTarget(self, action: #selector(SideScrollView.leftButtonPressed), for: .touchUpInside)
        
        rightButton.addTarget(self, action: #selector(SideScrollView.rightButtonPressed), for: .touchUpInside)
        
        
        leftButton.backgroundColor = UIColor.red
        rightButton.backgroundColor = UIColor.blue
        self.backgroundColor = UIColor.lightGray
        
        
        label.textAlignment = .center
        
        
        self.addSubview(label)
        self.addSubview(leftButton)
        self.addSubview(rightButton)
    }
    
    
    
    enum Direction {
        case Left, Right
    }
    
    func scroll(direction: Direction){
        switch direction {
            
        case .Left where currentTextIndex > 0:
            currentTextIndex -= 1
            
        case .Right where currentTextIndex < textArray.count - 1:
            currentTextIndex += 1
            
        default:
            break
        }
    }
    
    @objc func leftButtonPressed(){
        scroll(direction: .Left)
    }
    
    @objc func rightButtonPressed(){
        scroll(direction: .Right)
    }
}
