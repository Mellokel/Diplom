
import UIKit

class OptionTableVC: UIViewController{

    var tableArray: [String] = []
    var option: Field = Field()
    var selectedOptionValues:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = option.name
        tableArray = []
        switch option.type {
        case "Сортировка":
            tableArray = ["По возрастанию цены","По убыванию цены"]
            break
        case "String":
            guard let values = option.stringValues else { break }
            for value in values {
                tableArray.append(value)
            }
            break
        case "Boolean":
            tableArray = ["Да","Нет"]
            break
        default:
            print("error")
        }
    }
    //MARK: - action for button
    
    @IBAction func acceptButtonAction(_ sender: Any) {
        if selectedOptionValues.count != 0{
            Filter.appendFilterOption(uniqueKey: option.uniqueKey, values: selectedOptionValues)
        } else {
            Filter.clearFilterOption(uniqueKey: option.uniqueKey)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
extension OptionTableVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let tableArray = option.stringValues else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let index = selectedOptionValues.index(where: { (value) -> Bool in
            return value == tableArray[indexPath.row]
        }) {
            selectedOptionValues.remove(at: index)
            cell.accessoryType = .none
        } else {
            if option.type == "Сортировка" || option.type == "Boolean" {
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    selectedOptionValues.removeAll()
                    return
                }
                if !selectedOptionValues.isEmpty {
                    let i = indexPath.row == 1 ? 0 : 1
                    if let secondCell = tableView.cellForRow(at: IndexPath(item: i, section: 0)) {
                        secondCell.accessoryType = .none
                    }
                }
                
                selectedOptionValues.removeAll()
            }
            selectedOptionValues.append(tableArray[indexPath.row])
            cell.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
   
}

