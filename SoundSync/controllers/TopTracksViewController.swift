//
//  TopTracksViewController.swift
//  SoundSync
//
//  Created by AMAN K.A on 25/11/23.
//


// Final final

import UIKit
import SDWebImage

class TopTracksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: GradientView! // Add this line

    var topTracks: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the dataSource and delegate programmatically
        tableView.dataSource = self
        tableView.delegate = self
        
        // Make system background color dark
              view.backgroundColor = UIColor.systemBackground
        
        // Set the overrideUserInterfaceStyle to .dark
//           overrideUserInterfaceStyle = .dark


        print("Fetching top tracks from API...")
        APIManager.fetchTopTracks { result in
            switch result {
            case .success(let music):
                self.topTracks = music.data
                print("Fetched top tracks: \(self.topTracks)")

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("Reloaded top tracks data")
                }
            case .failure(let error):
                print("Error fetching top tracks: \(error)")
            }
        }

        // Set up blurry effect background
        let blurEffect = UIBlurEffect(style: .regular) // You can change .light to .dark or .extraLight
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.view.insertSubview(blurEffectView, at: 0)

        // Set up gradient view with a vibrant and superb gradient
        let startColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 0.3)  // Dark Blue
        let endColor = UIColor(red: 148/255, green: 71/255, blue: 233/255, alpha: 0.0) // Vibrant Purple
        self.gradientView.setColors(startColor: startColor, endColor: endColor, alpha: 0.4)

        // Add a subtle fade animation to the gradient view
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            self.gradientView.alpha = 0.9
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)

        // Remove any existing subviews
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let topTrack = topTracks[indexPath.row]

        // Create and configure an image view for the circular cover image
        let coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(coverImageView)

        if let coverURL = URL(string: "https://cms.samespace.com?/assets/\(topTrack.cover)") {
            coverImageView.sd_setImage(with: coverURL, placeholderImage: UIImage(named: "PlaceHolderimage"))
            print("Setting cover image for top track: \(topTrack.name)")
        }

        // Set background color to system background
                cell.contentView.backgroundColor = UIColor.systemBackground
        
//        // Set background color to white
//        cell.contentView.backgroundColor = .white

        // Create and configure labels
        let nameLabel = UILabel()
        let detailLabel = UILabel()

        nameLabel.text = topTrack.name
        detailLabel.text = topTrack.accent

        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        detailLabel.font = UIFont(name: "Helvetica", size: 18)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(nameLabel)
        cell.contentView.addSubview(detailLabel)

        // Set up constraints for the circular cover image
        NSLayoutConstraint.activate([
            // Constraints for the circular cover image
            coverImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            coverImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),

            // Constraints for the labels
            nameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: cell.contentView.trailingAnchor, constant: -8),

            detailLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            detailLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: cell.contentView.trailingAnchor, constant: -8),
        ])

        // Make the cover image circular and fill the image view
        coverImageView.layer.cornerRadius = coverImageView.frame.size.height / 2
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .scaleAspectFill

        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTopTrack = topTracks[indexPath.row]

        // Apply a custom selection effect
              tableView.deselectRow(at: indexPath, animated: true)
              if let cell = tableView.cellForRow(at: indexPath) {
                  UIView.animate(withDuration: 0.0, animations: {
                      cell.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                      cell.contentView.backgroundColor = UIColor.systemCyan
                  }) { _ in
                      UIView.animate(withDuration: 0.0) {
                          cell.transform = .identity
                          cell.contentView.backgroundColor = .secondarySystemFill
                      }
                  }
              }

        
        // Use storyboard instantiation
        if let musicPlayerVC = storyboard?.instantiateViewController(withIdentifier: "MusicPlayerViewController") as? MusicPlayerViewController {
            musicPlayerVC.selectedSong = selectedTopTrack
            navigationController?.pushViewController(musicPlayerVC, animated: true)
            print("Selected top track: \(selectedTopTrack.name)")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0 // Adjust this value based on your design
    }
}






/// final code same to for your
///
///
///
///
///
///





//import UIKit
//import SDWebImage
//
//class TopTracksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var gradientView: GradientView! // Add this line
//
//    var topTracks: [Track] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Set the dataSource and delegate programmatically
//        tableView.dataSource = self
//        tableView.delegate = self
//
//
//        print("Fetching top tracks from API...")
//        APIManager.fetchTopTracks { result in
//            switch result {
//            case .success(let music):
//                self.topTracks = music.data
//                print("Fetched top tracks: \(self.topTracks)")
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    print("Reloaded top tracks data")
//                }
//            case .failure(let error):
//                print("Error fetching top tracks: \(error)")
//            }
//        }
//
//
//        // Set up blurry effect background
//        let blurEffect = UIBlurEffect(style: .regular) // You can change .light to .dark or .extraLight
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.bounds
//        self.view.insertSubview(blurEffectView, at: 0)
//
//        // Set up gradient view with a vibrant and superb gradient
//                    let startColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 0.3)  // Dark Blue
//                    let endColor = UIColor(red: 148/255, green: 71/255, blue: 233/255, alpha: 0.0) // Vibrant Purple
//                    self.gradientView.setColors(startColor: startColor, endColor: endColor, alpha: 0.4)
//
//
//        // Add a subtle fade animation to the gradient view
//        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
//            self.gradientView.alpha = 0.9
//        }, completion: nil)
//
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return topTracks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
//
//        // Remove any existing subviews
//        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
//
//        let topTrack = topTracks[indexPath.row]
//
//        // Create and configure an image view for the circular cover image
//        let coverImageView = UIImageView()
//        coverImageView.translatesAutoresizingMaskIntoConstraints = false
//        cell.contentView.addSubview(coverImageView)
//
//        if let coverURL = URL(string: "https://cms.samespace.com?/assets/\(topTrack.cover)") {
//            coverImageView.sd_setImage(with: coverURL, placeholderImage: UIImage(named: "PlaceHolderimage"))
//            print("Setting cover image for top track: \(topTrack.name)")
//        }
//
//        // Set background color to white
//        cell.contentView.backgroundColor = .white
//
//        // Create and configure labels
//        let nameLabel = UILabel()
//        let detailLabel = UILabel()
//
//        nameLabel.text = topTrack.name
//        detailLabel.text = topTrack.accent
//
//        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
//        detailLabel.font = UIFont(name: "Helvetica", size: 18)
//
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        detailLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        cell.contentView.addSubview(nameLabel)
//        cell.contentView.addSubview(detailLabel)
//
//        // Set up constraints for the circular cover image
//        NSLayoutConstraint.activate([
//            // Constraints for the circular cover image
//            coverImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
//            coverImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
//            coverImageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
//            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),
//
//            // Constraints for the labels
//            nameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
//            nameLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
//            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: cell.contentView.trailingAnchor, constant: -8),
//
//            detailLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
//            detailLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
//            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: cell.contentView.trailingAnchor, constant: -8),
//        ])
//
//        // Make the cover image circular and fill the image view
//        coverImageView.layer.cornerRadius = coverImageView.frame.size.height / 2
//        coverImageView.clipsToBounds = true
//        coverImageView.contentMode = .scaleAspectFill
//
//        cell.accessoryType = .disclosureIndicator
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedTopTrack = topTracks[indexPath.row]
//
//        // Use storyboard instantiation
//        if let musicPlayerVC = storyboard?.instantiateViewController(withIdentifier: "MusicPlayerViewController") as? MusicPlayerViewController {
//            musicPlayerVC.selectedSong = selectedTopTrack
//            navigationController?.pushViewController(musicPlayerVC, animated: true)
//            print("Selected top track: \(selectedTopTrack.name)")
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80.0 // Adjust this value based on your design
//    }
//}

