//
//  DetailView.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import UIKit

class DetailView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.05697039515, green: 0.05697039515, blue: 0.05697039515, alpha: 1)
    }
    
    private func setupAutoLayout() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(_ movie: DailyBoxOfficeDetail) {
        titleLabel.text = movie.title
    }
    
}
