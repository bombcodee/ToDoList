//
//  ViewController.swift
//  TodoList
//
//  Created by 김주호 on 2023/06/02.
//

import UIKit

//UIViewController 상속받은 ViewController
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self // 테이블 뷰에 데이터소스 표시
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
    }
    

    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert) // alert 컨트롤 생성
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else {return}
            let task = Task(title: title, done: false)
            print("aa")
            self?.tasks.append(task)
            self?.tableView.reloadData()
            
            //debugPrint("\(alert.textFields?[0].text)") //디버그 창에 표시
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        //등록, 최소 기능 생성
        
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "할 일을 입력해주세요."})
        // alert에 적용
        self.present(alert, animated: true, completion: nil)
        // alert 화면에 표시
    }
//    @IBAction func tapAddButton(_ sender: Any) {
//    }
//
}


//UITableViewDataSource 상속받은 ViewController
//데이터 소스에 테이블뷰를 생성하는데 필요한 정보를 테이블뷰 객체(인스턴스)에 제공하는 소스 -> 할일 등록할떄마다 테이블뷰 갱신 -> 추가한 할일 테이블뷰에 표시되기위해 위에 tabAddButton에 reloadData() 메서드 추가
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }// dequeueReuseableCell: 큐를 사용해 셀을 재사용 -> 셀이 1억개면 말도 안되니까 메모리 낭비 예방위해 셀 재사용 -> 화면에 실질적으로 보이는 셀들만 로드해서 본다 -> 예전에 지도 맵 그리도 로드 하는 느낌
}

