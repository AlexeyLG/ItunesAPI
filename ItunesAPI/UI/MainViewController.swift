//
//  MainViewController.swift
//  ItunesAPI
//
//  Created by Alexey on 29.03.21.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    let networkManager = NetworkManager()
    var tracks: [Track] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        searchBar.delegate = self
    }
}

    //MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchRequest = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        
        networkManager.loadArtistInfo(name: searchRequest) { [weak self] (result) in
            guard let self = self else { return }
            
            self.tracks = result.track
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

    //MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.cellIdentifier, for: indexPath) as? TrackTableViewCell else {
            fatalError()
        }
        
        cell.fill(by: tracks[indexPath.row])
       
        return cell
    }
    
    
}
