//
//  ViewController.swift
//  Segment7Display
//
//  Created by Mariam Tsikarishvili on 18.10.24.
//

import UIKit

class ViewController: UIViewController {
    var number: Int = 789
    @IBOutlet var containerView: UIView!
    var hundreds: _7SegmentDisplay!
    var tens: _7SegmentDisplay!
    var ones: _7SegmentDisplay!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        display7Segments()
        displayNumberOn7SegmentDisplay()
    }
    
    private func display7Segments() {
        containerView.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = .clear
        
        let segmentContainerWidth = containerView.frame.width / 3
        let segmentContainerHeigth = containerView.frame.height
        
        
        let frame1 = CGRect(x: 0, y: 0, width: segmentContainerWidth, height: segmentContainerHeigth)
        hundreds = _7SegmentDisplay(frame: frame1)
        hundreds.backgroundColor = .clear
        containerView.addSubview(hundreds)
        
        let frame2 = CGRect(x: segmentContainerWidth, y: 0, width: segmentContainerWidth, height: segmentContainerHeigth)
        tens = _7SegmentDisplay(frame: frame2)
        tens.backgroundColor = .clear
        containerView.addSubview(tens)
        
        let frame3 = CGRect(x: 2 * segmentContainerWidth, y: 0, width: segmentContainerWidth
                            , height: segmentContainerHeigth)
        ones = _7SegmentDisplay(frame: frame3)
        ones.backgroundColor = .clear
        containerView.addSubview(ones)
    }
    
    private func displayNumberOn7SegmentDisplay(){
        hundreds.displayNumber(number / 100)
        tens.displayNumber((number % 100) / 10)
        ones.displayNumber(number % 10)
    }

}

