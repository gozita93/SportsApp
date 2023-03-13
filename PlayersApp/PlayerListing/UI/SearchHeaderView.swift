//
//  SearchHeaderView.swift
//  PlayersApp
//
//  Created by Visakh Simon Tharakan on 12/03/23.
//

import UIKit

final class SearchHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchView: UIView!
    let kCONTENT_XIB_NAME = "SearchHeaderView"
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            build()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            build()
        }

}

private extension SearchHeaderView {
    
    func build() {
        commonInit()
        configureViews()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func configureViews () {
        searchView.layer.cornerRadius = 12.0
    }
    
}

extension UIView {

    func fixInView(_ container: UIView!) -> Void{
            self.translatesAutoresizingMaskIntoConstraints = false;
            self.frame = container.frame;
            container.addSubview(self);
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        }

}
