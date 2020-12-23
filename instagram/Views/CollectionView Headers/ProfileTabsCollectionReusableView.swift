//
//  ProfileTabsCollectionReusableView.swift
//  instagram
//
//  Created by Administrator on 12/9/20.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
