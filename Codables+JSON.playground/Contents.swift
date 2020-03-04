import UIKit

struct Post: Codable {
    var id: Int
    var title: String
}

let baseURL = URL(string: "http://localhost:3000/posts")!
let session = URLSession(configuration: .default)

// use dummy-api project as server

func getPosts() {
    let task = session.dataTask(with: baseURL, completionHandler: { data, response, error in
        print("error: \(error)")
        print("data: \(data)")
        guard let data = data else { return }
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            print(posts[0].title)
        } catch {
            print(error)
        }
    })
    task.resume()
}

func createPost(id: Int, title: String) {
    let newPost = Post(id: id, title: title)
    
    guard let bodyData = try? JSONEncoder().encode(newPost) else {
        print("Unabole to encode post")
        return
    }
    let decodedPost = try! JSONDecoder().decode(Post.self, from: bodyData)
    print("decodedPost: \(decodedPost)")
    
    // NOTE: `jsonData` and `bodyData` are identical
    // let jsonData = try! JSONSerialization.data(withJSONObject: ["id": 2, "title": "Part 3"], options: .prettyPrinted)
    
    var request = URLRequest(url: baseURL)
    request.httpMethod = "POST"
    request.httpBody = bodyData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // NOTE: body received by server is empty without this.
    let task = session.dataTask(with: request)
    task.resume()
}
createPost(id: 2, title: "Part 3")
