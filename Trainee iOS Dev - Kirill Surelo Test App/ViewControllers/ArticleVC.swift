//
//  ArticleVC.swift
//  test-app
//
//  Created by Кирилл Сурело on 04.08.2021.
//

import UIKit


struct TableSection {
    var title: String
    var countOfRows: Int
}

class ArticleVC: UITableViewController {
    
    private var images = [UIImage]()
    private var sections = [TableSection]()
    private var post = Post()
    var postId: Int = 0
    public var articleVCDelegate: ((Bool) -> (Void))? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = getSections()
        self.tableView.register(TextViewCell.self, forCellReuseIdentifier: "TextCell")
        self.tableView.register(ImageViewCell.self, forCellReuseIdentifier: "ImageCell")
        self.tableView.register(FooterViewCell.self, forCellReuseIdentifier: "FooterCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func downloadPost(){
        PostService.shared.getPost(postId: postId) { [weak self] post in
            self?.post = post
            self?.navigationItem.title = post.title
            
            if (post.images != nil) {

                post.images?.forEach({ urlString in
                    self?.downloadImages(urlString: urlString)
                })
            }
        
            self?.articleVCDelegate?(true)
        }
    }
    
    func downloadImages(urlString: String){

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                images.append(UIImage(data: data)!)
            }
        }
    }
    
    private func getSections() -> [TableSection] {
        
        var generatedSections = [TableSection]()
        
        generatedSections.append(TableSection(title: "TEXT", countOfRows: 1))
        generatedSections.append(TableSection(title: "IMAGES", countOfRows: images.count))
        generatedSections.append(TableSection(title: "FOOTER", countOfRows: 1))
        
       return generatedSections
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countOfRows = self.sections[section].countOfRows
        return countOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextViewCell
            cell.titleLabel.text = post.title
            cell.mainTextLabel.text = post.text
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageViewCell
            cell.mainImageView.image = images[indexPath.row]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! FooterViewCell
                        
            cell.likesLabel.text = String(post.likes_count!)

            let date = Date(timeIntervalSince1970: post.timeshamp!)
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            formatter.locale = Locale(identifier: "ru_RU")
            let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
            cell.dateLabel.text = relativeDate

            return cell
        default:
            let cell = UITableViewCell()
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            let currentImage = images[indexPath.row]
            let imageCrop = currentImage.getCropRatio()
            return tableView.frame.width / imageCrop
        }
        else {
            return UITableView.automaticDimension
        }
    }
}

extension UIImage{
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
