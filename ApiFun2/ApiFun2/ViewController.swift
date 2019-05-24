
import UIKit

class ViewController: UITableViewController {
    
    var postList = [Post]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
    

    struct Post: Decodable {
        let body: [Body]
        
        enum CodingKeys : String, CodingKey {
            case body = "posts"
        }
    }
    
    struct Body: Decodable {
        let title: String
        let content: URL
        let imageUrl: String
    }
    
    
    fileprivate func fetchJSON() {
        guard let baseURL = URL(string: "http://192.168.100.3:8080/feed/posts") else {
            return
        }
        let session = URLSession.shared
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.postList = [(try JSONDecoder().decode(Post.self, from: data))]
                    print(500)
                    print("AAAAAA : ", self.postList)
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let post = postList[indexPath.row]
        print("post: ", post)
        
        for title in post.body {
            cell.textLabel?.text = title.title
        }
        
        return cell
    }
    
}
