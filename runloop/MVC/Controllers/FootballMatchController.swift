//
//  FullDetailsMatchController.swift
//  runloop
//
//  Created by swamnx on 20.05.21.
//

import Foundation

import UIKit

class FootballMatchController: UIViewController {
    
    var footBallMatch: FootballMatch?
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView?.text = footBallMatch?.name
        textView?.text = footBallMatch?.description
        timeView?.text = footBallMatch?.remainingTime
    }
    
    func getObserver() -> ( () -> Void) {
        return {
            [weak self] in
            guard let unwrapped = self, unwrapped.footBallMatch != nil else { return }
            let updated = CommonUtils.shared.processFootballMatch(&unwrapped.footBallMatch!)
            if updated {
                unwrapped.timeView?.text = unwrapped.footBallMatch?.remainingTime
            }
        }
    }
    
}
