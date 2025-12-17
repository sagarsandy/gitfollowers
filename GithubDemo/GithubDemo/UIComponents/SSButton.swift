//
//  SSButton.swift
//  GithubDemo
//
//  Created by Sagar on 17/12/25.
//

import UIKit

class SSButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configue()
    }
    
    private func configue() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
