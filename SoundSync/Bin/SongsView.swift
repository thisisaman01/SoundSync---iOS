////
////  SongsView.swift
////  SoundSync
////
////  Created by AMAN K.A on 26/11/23.
////
//
//import UIKit
//
//class SongsView: UIView {
//    private var songsLabel: UILabel!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        songsLabel = UILabel()
//        songsLabel.text = "Songs"
//        songsLabel.textColor = .white
//        songsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        songsLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(songsLabel)
//
//        NSLayoutConstraint.activate([
//            songsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            songsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//    }
//}
