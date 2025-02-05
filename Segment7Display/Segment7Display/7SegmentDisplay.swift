//
//  7SegmentDisplay.swift
//  Segment7Display
//
//  Created by Mariam Tsikarishvili on 25.10.24.
//
import UIKit

class _7SegmentDisplay : UIView {
    private var segment1 = UIView()
    private var segment2 = UIView()
    private var segment3 = UIView()
    private var segment4 = UIView()
    private var segment5 = UIView()
    private var segment6 = UIView()
    private var segment7 = UIView()
    private let off_color = UIColor(white: 0.1, alpha: 1.0)
    private let on_color = UIColor(.red)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        displaySegments()
    }
    
    private func displaySegments(){
        let segmentContainerHeigth = self.frame.height
        let segmentContainerWidth = self.frame.width
        let topMargin = segmentContainerHeigth * 7 / 40
        let leftMargin = segmentContainerWidth / 8
        let interval1 = segmentContainerWidth / 24
        let interval2 = segmentContainerHeigth / 20
        let horizontalWidth = segmentContainerWidth * 5 / 12
        let horizontalHeight = segmentContainerWidth / 8
        let verticalWidth = horizontalHeight
        let verticalHeight = segmentContainerHeigth * 3 / 10
        
        
        segment1.frame = CGRect(x: leftMargin + verticalWidth + interval1, y: topMargin, width: horizontalWidth, height: horizontalHeight)
        segment1.backgroundColor = off_color
        self.addSubview(segment1)
        
        segment2.frame = CGRect(x: leftMargin + verticalWidth + 2 * interval1 + horizontalWidth, y: topMargin, width: verticalWidth, height: verticalHeight)
        segment2.backgroundColor = off_color
        self.addSubview(segment2)
        
        segment3.frame = CGRect(x: leftMargin + verticalWidth + 2 * interval1 + horizontalWidth, y: topMargin + verticalHeight + interval2, width: verticalWidth, height: verticalHeight)
        segment3.backgroundColor = off_color
        self.addSubview(segment3)
        
        segment4.frame = CGRect(x: leftMargin + verticalWidth + interval1, y: topMargin + 2 * verticalHeight + interval2 - horizontalHeight, width: horizontalWidth, height: horizontalHeight)
        segment4.backgroundColor = off_color
        self.addSubview(segment4)
        
        segment5.frame = CGRect(x: leftMargin, y: topMargin + verticalHeight + interval2, width: verticalWidth, height: verticalHeight)
        segment5.backgroundColor = off_color
        self.addSubview(segment5)
        
        segment6.frame = CGRect(x: leftMargin, y: topMargin, width: verticalWidth, height: verticalHeight)
        segment6.backgroundColor = off_color
        self.addSubview(segment6)
        
        segment7.frame = CGRect(x: leftMargin + verticalWidth + interval1, y: topMargin + verticalHeight - (horizontalHeight - interval2) / 2, width: horizontalWidth, height: horizontalHeight)
        segment7.backgroundColor = off_color
        self.addSubview(segment7)
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func displayNumber(_ number: Int) {
        switch number {
        case 0:
            displayZero()
        case 1:
            displayOne()
        case 2:
            displayTwo()
        case 3:
            displayThree()
        case 4:
            displayFour()
        case 5:
            displayFive()
        case 6:
            displaySix()
        case 7:
            displaySeven()
        case 8:
            displayEight()
        case 9:
            displayNine()
        default:
            return
        }
    }
    
    private func displayZero() {
        segment1.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
        segment5.backgroundColor = on_color
        segment6.backgroundColor = on_color
    }
    
    private func displayOne(){
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
    }
    
    private func displayTwo(){
        segment1.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment5.backgroundColor = on_color
        segment4.backgroundColor = on_color
    }
    
    private func displayThree(){
        segment1.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
    }
    
    private func displayFour(){
        segment6.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
    }
    
    private func displayFive(){
        segment1.backgroundColor = on_color
        segment6.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
    }
    
    private func displaySix(){
        segment1.backgroundColor = on_color
        segment6.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
        segment5.backgroundColor = on_color
    }
    
    private func displaySeven(){
        segment1.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
    }
    
    private func displayEight(){
        segment1.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
        segment5.backgroundColor = on_color
        segment6.backgroundColor = on_color
        segment7.backgroundColor = on_color
    }
    
    private func displayNine(){
        segment1.backgroundColor = on_color
        segment6.backgroundColor = on_color
        segment7.backgroundColor = on_color
        segment2.backgroundColor = on_color
        segment3.backgroundColor = on_color
        segment4.backgroundColor = on_color
    }
}
