////
////  SongCell.swift
////  SoundSync
////
////  Created by AMAN K.A on 26/11/23.
////
//
//import UIKit
//import SDWebImage
//
//class SongCell: UITableViewCell {
//    static let identifier = "SongCell"
//
//    var song: Track? {
//        didSet {
//            configureCell()
//        }
//    }
//
//    private let coverImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 40 // Adjust as needed
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Helvetica-Bold", size: 20)
//        return label
//    }()
//
//    private let detailLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Helvetica", size: 18)
//        label.textColor = .gray
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupViews()
//    }
//
//    private func setupViews() {
//        contentView.addSubview(coverImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(detailLabel)
//
//        // Set up constraints (adjust as needed)
//        coverImageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            coverImageView.widthAnchor.constraint(equalToConstant: 80) // Adjust as needed
//        ])
//
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
//        ])
//
//        detailLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            detailLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
//            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
//        ])
//    }
//
//    private func configureCell() {
//        guard let song = song else { return }
//
//        nameLabel.text = song.name
//        detailLabel.text = song.accent
//
//        if let coverURL = URL(string: "https://cms.samespace.com?/assets/\(song.cover)") {
//            coverImageView.sd_setImage(with: coverURL, placeholderImage: UIImage(named: "PlaceHolderimage"))
//        }
//    }
//}
