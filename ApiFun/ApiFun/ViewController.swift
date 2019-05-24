
import UIKit
import Foundation
import Alamofire
import AlamofireImage

struct Root: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let id, content, imageURL, title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content
        case imageURL = "imageUrl"
        case title
    }
}


class ViewController: UITableViewController {
    
    var postList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(customCell, forCellReuseIdentifier: "customCell")
        fetchJSON()
    }
    
    @IBAction func reloadData(_ sender: Any) {
        postList.removeAll()
        fetchJSON()
    }
    
    fileprivate func fetchJSON() {
        guard let baseURL = URL(string: "http://LOCALHOST:8080/feed/postsIosDevice") else {
        //guard let baseURL = URL(string: "http://192.168.100.7:8080/feed/postsIosDevice") else {
            return
        }
        
        let headers : HTTPHeaders = [
            "Authorization" : "Bearer"
        ]
        
        Alamofire.request(baseURL).responseJSON(completionHandler: { response in
            if response.result.value != nil {
                do {
                    let posts = try JSONDecoder().decode(Root.self, from: response.data!)
                    for post in posts.posts {
                        self.postList.append(post)
                    }
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        });
        
//        let session = URLRequest(url: baseURL)
//        URLSession.shared.dataTask(with: session) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                print(data)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                    let posts = try JSONDecoder().decode(Root.self, from: data)
//                    for post in posts.posts {
//                        self.postList.append(post)
//                    }
//                    self.tableView.reloadData()
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let post = postList[indexPath.row]
        
        cell.postTitle.text = post.title;
        cell.postContent.text = post.content;
        cell.postId = post.id;
        cell.navigationControlle = self.navigationController
    
        //let baseURL = URL(string: "http://192.168.100.7:8080/\(post.imageURL)")
        let baseURL = URL(string: "http://LOCALHOST:8080/\(post.imageURL)")
        
        Alamofire.request(baseURL!, method: .get).responseImage(completionHandler: { response in
            guard let image = response.result.value else {
                return
            }
            cell.postImage.image = image
        });
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}

