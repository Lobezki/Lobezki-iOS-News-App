//
//  NewsTableViewCell.swift
//  test-app
//
//  Created by Кирилл Сурело on 30.07.2021.
//

import UIKit

class PreviewPostViewCell: UITableViewCell {
    
    private var isPreviewFull: Bool = false
    var postId: Int = 0
    
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!

    @IBOutlet weak var showPreviewButton: UIButton!
    
    public var delegate: PreviewPostViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func showPreviewClick(_ sender: Any) {
        let numberOfLines = isPreviewFull ? 2 : 0
        previewLabel.numberOfLines = numberOfLines
        isPreviewFull = !isPreviewFull
        self.delegate?.updateCellHeight()
    }
    
    @IBAction func showArticleClick(_ sender: Any) {
        self.delegate?.navigateToArticle(postId: self.postId)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
    }
}

protocol PreviewPostViewCellDelegate{
    func updateCellHeight()
    func navigateToArticle(postId: Int)
}
