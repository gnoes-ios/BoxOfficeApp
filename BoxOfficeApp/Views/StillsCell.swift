//
//  StillsCell.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/27/25.
//

import UIKit
import Kingfisher

class StillsCell: UICollectionViewCell {
    
    private let imageVIew: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.translatesAutoresizingMaskIntoConstraints = false
        return imageVIew
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupAutoLayout() {
        self.addSubview(imageVIew)
        NSLayoutConstraint.activate([
            imageVIew.topAnchor.constraint(equalTo: self.topAnchor),
            imageVIew.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageVIew.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(_ url: String) {
        imageVIew.kf.setImage(with: makeImageURL(url))
        print(url)
    }
    
    private func makeImageURL(_ urlString: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w1280/" + urlString)!
    }
}
