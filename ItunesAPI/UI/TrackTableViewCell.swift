//
//  TrackTableViewCell.swift
//  ItunesAPI
//
//  Created by Alexey on 29.03.21.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageArtist: UIImageView!
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    static let cellIdentifier = "trackCell"
    
    private lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    //MARK: - Utilities

    func fill(by track: Track) {
        nameArtist.text = track.artistName
        trackName.text = track.trackName
        
        if let imageURL = track.image {
            loadImage(imageURL: imageURL)
        }
    }
    
    private func loadImage(imageURL: String) {
        imageLoadingIndicator.startAnimating()
        
        operationQueue.cancelAllOperations()
        
        operationQueue.addOperation {
            guard let url = URL(string: imageURL),
                  let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.imageLoadingIndicator.stopAnimating()
                self.imageArtist.image = image
            }
        }
    }

}
