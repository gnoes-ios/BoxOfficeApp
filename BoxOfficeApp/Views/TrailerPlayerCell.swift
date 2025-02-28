//
//  TrailerPlayerCell.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/27/25.
//

import UIKit
import YouTubeiOSPlayerHelper

class TrailerPlayerCell: UICollectionViewCell {
    
    private let playerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let playVarsDic: [String: Any] = [
        "rel": 0,
        "modestbranding": 1,
        "showinfo": 0,
        "iv_load_policy": 3
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        self.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(_ id: String) {
        playerView.load(withVideoId: id, playerVars: playVarsDic)
    }
    
}
