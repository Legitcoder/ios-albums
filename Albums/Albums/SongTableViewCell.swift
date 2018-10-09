//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Moin Uddin on 10/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit


protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
        guard let song = song else { return }
        songTextField.text = song.name
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        songTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSong(_ sender: Any) {
        guard let title = songTextField.text,
            let duration = durationTextField.text else { return }
        if (title.isEmpty || duration.isEmpty) {
            print("User sent empty strings")
            return
        }
        delegate?.addSong(with: title, duration: duration)
    }
    
    @IBOutlet weak var addSongButton: UIButton!
    
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    weak var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    

}
