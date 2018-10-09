//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Moin Uddin on 10/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.getAlbums() { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController.albums.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist
        // Configure the cell...

        return cell
    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewAlbum" {
            guard let destVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let album = albumController.albums[indexPath.row]
            
            destVC.albumController = albumController
            destVC.album = album
        } else if segue.identifier == "AddAlbum" {
            guard let destVC = segue.destination  as? AlbumDetailTableViewController else { return }
            destVC.albumController = albumController
        }
    }
    
    let albumController = AlbumController()

}
