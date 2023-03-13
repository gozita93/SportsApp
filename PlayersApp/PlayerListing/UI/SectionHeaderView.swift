//
//  SectionHeaderView.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 13/03/23.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
