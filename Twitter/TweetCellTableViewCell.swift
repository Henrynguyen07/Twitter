//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Henry Nguyen on 3/3/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favButton(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: {(error) in
                print("Favorite did not suceed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: {(error) in
                print("Unfavorite did not suceed: \(error)")
            })
        }
    }
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: {(error) in
            print("Error is Retweeting: \(error)")
        })
    }
    
 
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setRetweeted(  isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    func setFavorite(isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for:UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for:UIControl.State.normal)
        }
    }

}
