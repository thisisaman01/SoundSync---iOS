//
//  MusicPlayerViewController.swift
//  SoundSync
//
//  Created by AMAN K.A on 25/11/23.
//




// final code ------

//--------


import UIKit
import AVFoundation
import SDWebImage

class MusicPlayerViewController: UIViewController {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var selectedSong: Track?
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI with selected song details
        if let song = selectedSong {
            songNameLabel.text = song.name
            artistLabel.text = song.artist
            
            // Fetch cover image based on the cover key from the API
            if let cover = selectedSong?.cover, !cover.isEmpty {
                fetchCoverImage(coverID: cover)
            }
        }
        
        // Load and play the selected song
        if let songURLString = selectedSong?.url, let songURL = URL(string: songURLString) {
            // Create an AVPlayerItem with the URL
            let playerItem = AVPlayerItem(url: songURL)
            
            // Initialize the AVPlayer with the player item
            player = AVPlayer(playerItem: playerItem)
            
            // Start playing the audio
            player?.play()
        }
        
        // Enable swipe gestures
        enableSwipeGestures()
        
        // Update play/pause button dynamically
        updatePlayPauseButton()
        
        // Set dark background
//        view.backgroundColor = UIColor.black
        
        // Center align the cover image
        coverImageView.contentMode = .center
    }

    // Fetch cover image based on cover key from the API
    func fetchCoverImage(coverID: String) {
        guard let coverURL = URL(string: "https://cms.samespace.com?/assets/\(coverID)") else {
            return
        }
        
        // Error loading cover image: Image url is blacklisted
// received in console
        
        // Use SDWebImage for asynchronous image loading
        coverImageView.sd_setImage(
            with: coverURL,
            placeholderImage: UIImage(named: "PlaceHolderimage"),
            options: [.allowInvalidSSLCertificates, .avoidAutoSetImage],
            completed: { [weak self] image, error, cacheType, imageURL in
                if let error = error {
                    print("Error loading cover image: \(error.localizedDescription)")
                    // Handle the error, for example, show a default image or log the issue
                } else {
                    // Image loaded successfully, you can update UI or perform additional tasks
                    self?.coverImageView.setNeedsLayout()
                }
            }
        )
    }
    
    // Play/Pause button action
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if let player = player {
            if player.rate == 1 {
                player.pause()
            } else {
                player.play()
            }
            updatePlayPauseButton()
        }
    }
    
    // Update play/pause button image dynamically
    func updatePlayPauseButton() {
        if let player = player {
            let imageName = player.rate == 1 ? "pause.circle.fill" : "play.circle.fill"
            playPauseButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // Previous button action
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        // Implement logic to play the previous song
        playPreviousSong()
    }
    
    // Next button action
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Implement logic to play the next song
        playNextSong()
    }
    
    // Enable swipe gestures
    func enableSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    // Handle swipe gestures
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            // Swipe right to play the previous song
            playPreviousSong()
        case .left:
            // Swipe left to play the next song
            playNextSong()
        default:
            break
        }
    }
    
    // Play the previous song
    func playPreviousSong() {
        // Implement logic to play the previous song
        // For simplicity, you can stop the current song and play the first song
        stopAndPlayFirstSong()
    }
    
    // Play the next song
    func playNextSong() {
        // Implement logic to play the next song
        // For simplicity, you can stop the current song and play the first song
        stopAndPlayFirstSong()
    }
    
    // Stop the current song and play the first song
    func stopAndPlayFirstSong() {
        player?.pause()
        
        // Reset player with the first song URL
        if let firstSongURLString = selectedSong?.url, let firstSongURL = URL(string: firstSongURLString) {
            let playerItem = AVPlayerItem(url: firstSongURL)
            player?.replaceCurrentItem(with: playerItem)
            player?.play()
            
            // Update UI with the first song details
            if let firstSong = selectedSong {
                songNameLabel.text = firstSong.name
                artistLabel.text = firstSong.artist
                
                if !firstSong.cover.isEmpty {
                    fetchCoverImage(coverID: firstSong.cover)
                }
            }
            updatePlayPauseButton()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coverImageView.layer.cornerRadius = coverImageView.frame.size.height / 2
        coverImageView.clipsToBounds = true
    }
}




// music playis with this updated code//






///
///
///

//
//import UIKit
//import AVFoundation
//import SDWebImage
//
//class MusicPlayerViewController: UIViewController {
//
//    @IBOutlet weak var songNameLabel: UILabel!
//    @IBOutlet weak var artistLabel: UILabel!
//    @IBOutlet weak var coverImageView: UIImageView!
//    @IBOutlet weak var playPauseButton: UIButton!
//    @IBOutlet weak var previousButton: UIButton!
//    @IBOutlet weak var nextButton: UIButton!
//
//    var selectedSong: Track?
//    var player: AVPlayer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Set up UI with selected song details
//        if let song = selectedSong {
//            songNameLabel.text = song.name
//            artistLabel.text = song.artist
//
//            // Fetch cover image based on the cover key from the API
//            if let cover = selectedSong?.cover, !cover.isEmpty {
//                fetchCoverImage(coverID: cover)
//            }
//        }
//
//        // Load and play the selected song
//        if let songURLString = selectedSong?.url, let songURL = URL(string: songURLString) {
//            // Create an AVPlayerItem with the URL
//            let playerItem = AVPlayerItem(url: songURL)
//
//            // Initialize the AVPlayer with the player item
//            player = AVPlayer(playerItem: playerItem)
//
//            // Set up a key-value observer to update UI when the song changes
//            player?.addObserver(self, forKeyPath: "currentItem", options: .new, context: nil)
//
//            // Start playing the audio
//            player?.play()
//        }
//
//        // Enable swipe gestures
//        enableSwipeGestures()
//    }
//
//    // Observing changes in AVPlayerItem
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "currentItem" {
//            // Update UI or perform any actions when the song changes
//            // For example, you can update the song title label
//            DispatchQueue.main.async {
//                self.songNameLabel.text = self.selectedSong?.name
//            }
//        }
//    }
//
//
//    // Clean up observer when the view is deinitialized
//    deinit {
//        player?.removeObserver(self, forKeyPath: "currentItem")
//    }
//
//    // Fetch cover image based on cover key from the API
//    func fetchCoverImage(coverID: String) {
//        guard let coverURL = URL(string: "https://cms.samespace.com?/assets/\(coverID)") else {
//            return
//        }
//
//        // Use SDWebImage for asynchronous image loading
//        coverImageView.sd_setImage(
//            with: coverURL,
//            placeholderImage: UIImage(named: "PlaceHolderimage"),
//            options: [.allowInvalidSSLCertificates, .avoidAutoSetImage],
//            completed: { [weak self] image, error, cacheType, imageURL in
//                if let error = error {
//                    print("Error loading cover image: \(error.localizedDescription)")
//                    // Handle the error, for example, show a default image or log the issue
//                } else {
//                    // Image loaded successfully, you can update UI or perform additional tasks
//                    self?.coverImageView.setNeedsLayout()
//                }
//            }
//        )
//    }
//
//    // Play/Pause button action
//    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
//        if player?.rate == 1 {
//            player?.pause()
//            sender.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
//        } else {
//            player?.play()
//            sender.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
//        }
//    }
//
//    // Previous button action
//    @IBAction func previousButtonTapped(_ sender: UIButton) {
//        // Implement logic to play the previous song
//        playPreviousSong()
//    }
//
//    // Next button action
//    @IBAction func nextButtonTapped(_ sender: UIButton) {
//        // Implement logic to play the next song
//        playNextSong()
//    }
//
//    // Enable swipe gestures
//    func enableSwipeGestures() {
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//        swipeRight.direction = .right
//        view.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//        swipeLeft.direction = .left
//        view.addGestureRecognizer(swipeLeft)
//    }
//
//    // Handle swipe gestures
//    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
//        switch gesture.direction {
//        case .right:
//            // Swipe right to play the previous song
//            playPreviousSong()
//        case .left:
//            // Swipe left to play the next song
//            playNextSong()
//        default:
//            break
//        }
//    }
//
//    // Play the previous song
//    func playPreviousSong() {
//        // Implement logic to play the previous song
//        // For simplicity, you can stop the current song and play the first song
//        stopAndPlayFirstSong()
//    }
//
//    // Play the next song
//    func playNextSong() {
//        // Implement logic to play the next song
//        // For simplicity, you can stop the current song and play the first song
//        stopAndPlayFirstSong()
//    }
//
//    // Stop the current song and play the first song
//    func stopAndPlayFirstSong() {
//        player?.pause()
//
//        // Reset player with the first song URL
//        if let firstSongURLString = selectedSong?.url, let firstSongURL = URL(string: firstSongURLString) {
//            let playerItem = AVPlayerItem(url: firstSongURL)
//            player?.replaceCurrentItem(with: playerItem)
//            player?.play()
//
//            // Update UI with the first song details
//            if let firstSong = selectedSong {
//                songNameLabel.text = firstSong.name
//                artistLabel.text = firstSong.artist
//
//                if !firstSong.cover.isEmpty {
//                    fetchCoverImage(coverID: firstSong.cover)
//                }
//            }
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        coverImageView.layer.cornerRadius = coverImageView.frame.size.height / 2
//        coverImageView.clipsToBounds = true
//        coverImageView.contentMode = .scaleAspectFill
//    }
//}


