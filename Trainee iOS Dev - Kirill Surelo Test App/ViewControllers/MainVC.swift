//
//  MainVC.swift
//  test-app
//
//  Created by Кирилл Сурело on 30.07.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var posts: [PreviewPost] = []
    
    private enum sortType {
        case dateAsc
        case dateDesc
        case likesAsc
        case likesDesc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostService.shared.getPosts { [weak self] posts in
            self?.posts = posts
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }
        }
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension;
        navigationItem.backButtonTitle = ""
    }

    @IBAction func sortPostsClick(_ sender: Any) {
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortDateAscAction = UIAlertAction(title: "Дата (увеличение)", style: .default) { action in
            self.sortPosts(sortType: .dateAsc)
        }
        let sortDateDescAction = UIAlertAction(title: "Дата (уменьшение)", style: .default) { action in
            self.sortPosts(sortType: .dateDesc)
        }
        let sortLikesAscAction = UIAlertAction(title: "Рейтинг (увеличение)", style: .default) { action in
            self.sortPosts(sortType: .likesAsc)
        }
        let sortLikesDescAction = UIAlertAction(title: "Рейтинг (уменьшение)", style: .default) { action in
            self.sortPosts(sortType: .likesDesc)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action -> Void in }

        actionSheetController.addAction(sortDateAscAction)
        actionSheetController.addAction(sortDateDescAction)
        actionSheetController.addAction(sortLikesAscAction)
        actionSheetController.addAction(sortLikesDescAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true)
    }
    
    private func sortPosts(sortType: sortType){
        switch sortType {
        case .dateAsc:
            posts = posts.sorted(by: { ($0.timeshamp! < $1.timeshamp!) })
        case .dateDesc:
            posts = posts.sorted(by: { ($0.timeshamp! > $1.timeshamp!) })
        case .likesAsc:
            posts = posts.sorted(by: { ($0.likes_count! < $1.likes_count!) })
        case .likesDesc:
            posts = posts.sorted(by: { ($0.likes_count! > $1.likes_count!) })
        }
        
        tableView.reloadData()
    }
}

extension MainVC: PreviewPostViewCellDelegate{
    func updateCellHeight(){
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func navigateToArticle(postId: Int) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let articleVC = storyBoard.instantiateViewController(withIdentifier: "ArticleVC") as! ArticleVC

        articleVC.postId = postId

        articleVC.articleVCDelegate = {
            isready in
            if (isready == true) {
                self.navigationController?.pushViewController(articleVC, animated: true)
            }
        }

        articleVC.downloadPost()        
    }
}

extension MainVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PreviewPostViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        
        let date = Date(timeIntervalSince1970: post.timeshamp!)

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "ru_RU")
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
        
        cell.postId = post.postId!
        cell.titleLabel.text = post.title
        cell.previewLabel.text = post.preview_text
        cell.likesLabel.text = String(post.likes_count!)
        cell.datelabel.text = relativeDate
        cell.delegate = self

        if(cell.previewLabel.maxNumberOfLines < 3) {
            cell.titleView.bottomAnchor.constraint(equalTo: cell.postView.bottomAnchor, constant: 0).isActive = true
            cell.showPreviewButton.isHidden = true
        }
  
        return cell
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
