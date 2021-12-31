//
//  ViewController.swift
//  UITableView
//
//  Created by Kavitha Bojanapu on 12/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func ChangeTheValues(_ sender: Any) {
        loadCourseInfoJson()
    }
    var courseList = [CourseContent.Course] (){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCourseValues()
    }
    
    func loadCourseInfoJson() {
        
        if let filePath = Bundle.main.url(forResource: "sample1", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                let course = try decoder.decode(CourseContent.self , from: data)
                self.courseList = course.courses
            } catch {
                print("Can not load JSON file.")
            }
        }
    }
    
    func getCourseValues() {
        
        guard let url = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/website_description") else {return}
        
        let task = URLSession.shared.dataTask(with: url){(data ,response ,error) in
            guard let dataResponse = data , error == nil else {
                print(error?.localizedDescription ?? "something went wrong")
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let course = try decoder.decode(CourseContent.self , from: dataResponse)
                self.courseList = course.courses
                //let response = try JSONSerialization.jsonObject(with: dataResponse, options:[])
                //   print(response)
                
            } catch let parsingError {
                print(parsingError)
            }
        }
        task.resume()
    }
    
    
    
}
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
        
        // Configure the cell’s contents.s
        cell.textLabel!.text = "Title : \(courseList[indexPath.row].name) \n \n No.of lessons : \(courseList[indexPath.row].numberOfLessons)"
        cell.textLabel?.numberOfLines = 0
        
        //               let imageUrlString = courseList[indexPath.row].imageUrl
        //           DispatchQueue.global().async {
        //               guard let imageUrl = URL(string: imageUrlString) else { return  }
        //                       // Start background thread so that image loading does not make app unresponsive
        //               guard let imageData = try? Data(contentsOf: imageUrl) else { return  }
        //                        // When from a background thread, UI needs to be updated on main_queue
        //                          DispatchQueue.main.async {
        //                              cell.imageView?.image = UIImage(data: imageData)
        //                              cell.imageView?.contentMode = .scaleAspectFill
        //                              cell.imageView?.clipsToBounds = true
        ////                              let size = CGSize(width: 30.0, height: 30.0)
        ////                              let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
        //                              
        //                              
        //                           }
        //           }
        
        return cell
        
    }
}


