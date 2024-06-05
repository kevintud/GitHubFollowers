//
//  CustomButton.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/8/24.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom code
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroudColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroudColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline )
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func set(backGroungColor: UIColor, title: String) {
        self.backgroundColor = backGroungColor
        setTitle(title, for: .normal)
    }
}
