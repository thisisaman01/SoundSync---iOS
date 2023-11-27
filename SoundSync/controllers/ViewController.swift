//
//  ViewController.swift
//  SoundSync
//
//  Created by AMAN K.A on 25/11/23.
//
//



//  with print statemnts


import UIKit
import SDWebImage

extension UIViewController {
    func fadeInOutTransition(_ duration: TimeInterval = 0.2) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        navigationController?.view.layer.add(transition, forKey: nil)
        print("Fade effect applied")  // Added print statement for checking
    }
}

extension UINavigationController {
    func pushViewControllerWithFadeAnimation(_ viewController: UIViewController, duration: TimeInterval = 0.2) {
        let transition: CATransition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(viewController, animated: false)
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: GradientView! // Add this line

    var songs: [Track] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the dataSource and delegate programmatically
        tableView.dataSource = self
        tableView.delegate = self
        
//        // Make system background color dark
//              view.backgroundColor = UIColor.systemBackground
        
        // Set the overrideUserInterfaceStyle to .dark
//           overrideUserInterfaceStyle = .dark

        print("Fetching songs from API...")
        APIManager.fetchSongs { result in
            switch result {
            case .success(let music):
                self.songs = music.data
                print("Fetched songs: \(self.songs)")

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("Reloaded data")
                }
            case .failure(let error):
                print("Error fetching songs: \(error)")
            }
        }
        // Set up blurry effect background
        let blurEffect = UIBlurEffect(style: .regular) // You can change .light to .dark or .extraLight
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = self.view.bounds
        self.view.insertSubview(blurEffectView, at: 0)
//
        // Set up gradient view with a vibrant gradient
                   let startColor = UIColor(red: 251/255, green: 85/255, blue: 34/255, alpha: 0.1)  // Orange
                   let endColor = UIColor(red: 5/255, green: 117/255, blue: 230/255, alpha: 0.0)   // Blue
                   self.gradientView.setColors(startColor: startColor, endColor: endColor, alpha: 0.2)

                // Add a subtle fade animation to the gradient view
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
                    self.gradientView.alpha = 0.9
                }, completion: nil)
        
        }

    
   



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows: \(songs.count)")

        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        print("Configuring cell for row: \(indexPath.row)")


        // Remove any existing subviews
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let song = songs[indexPath.row]

        // Create and configure an image view for the circular cover image
        let coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(coverImageView)
        
        cell.contentView.backgroundColor = UIColor.systemBackground

        
        // Set up constraints for the circular cover image
        NSLayoutConstraint.activate([
            // Constraints for the circular cover image
            coverImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            coverImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),
        ])

        // Make the cover image circular and fill the image view
        coverImageView.layer.cornerRadius = coverImageView.frame.size.height / 2
        coverImageView.clipsToBounds = true
        coverImageView.contentMode = .scaleAspectFill // Add this line

        
        coverImageView.image = UIImage(named: "PlaceHolderimage")

        if let coverURL = URL(string: "https://cms.samespace.com?/assets/\(song.cover)") {
            coverImageView.sd_setImage(with: coverURL, placeholderImage: UIImage(named: "PlaceHolderimage"))
            print("Setting cover image for song: \(song.name)")
        }

        // Set background color to white
        cell.contentView.backgroundColor = .white

        // Create and configure labels
        let nameLabel = UILabel()
        let detailLabel = UILabel()

        nameLabel.text = song.name
        detailLabel.text = song.accent

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
        let selectedSong = songs[indexPath.row]
        
        // Apply a custom selection effect
              tableView.deselectRow(at: indexPath, animated: true)
              if let cell = tableView.cellForRow(at: indexPath) {
                  UIView.animate(withDuration: 0.0, animations: {
                      cell.transform = CGAffineTransform(scaleX: 0.98, y: 0.0)
                      cell.contentView.backgroundColor = UIColor.systemRed
                  }) { _ in
                      UIView.animate(withDuration: 0.98) {
                          cell.transform = .identity
                          cell.contentView.backgroundColor = .systemGray6
                      }
                  }
              }

        // Use storyboard instantiation
               if let musicPlayerVC = storyboard?.instantiateViewController(withIdentifier: "MusicPlayerViewController") as? MusicPlayerViewController {
                   musicPlayerVC.selectedSong = selectedSong
                   navigationController?.pushViewControllerWithFadeAnimation(musicPlayerVC)
                   print("Selected song: \(selectedSong.name)")
               }
           }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("Height for row: \(indexPath.row)")

        return 80.0 // Adjust this value based on your design
    }
    
              
       
   }


