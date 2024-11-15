import UIKit

class VCMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = ["Nguyễn Văn A", "Trần Thị B", "Lê Văn C"]
    var phoneNumbers: [String] = ["0123456789", "0987654321", "0345678912"]
    var images: [UIImage?] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!]
    var editingIndexPath: IndexPath?
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Đăng ký cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Thiết lập dataSource và delegate cho tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedName = names[indexPath.row]
            let selectedPhoneNumber = phoneNumbers[indexPath.row]
            let selectedImage = images[indexPath.row]

            // Truyền dữ liệu sang VCDetailed
        performSegue(withIdentifier: "VCDetailed", sender: ["name": selectedName, "phone": selectedPhoneNumber, "image": selectedImage as Any])
            
        }
    
    
    func createNewCell() -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: names.count, section: 0))
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            cell.imageView?.image = UIImage(named: "avatar")
            names.append("")
            phoneNumbers.append("")
            images.append(nil)
            return cell
        }


    
    @IBAction func addContact(_ sender: Any) {
        _ = createNewCell()
                tableView.insertRows(at: [IndexPath(row: names.count - 1, section: 0)], with: .automatic)

                // Hiển thị alert để người dùng nhập thông tin
                let alert = UIAlertController(title: "Nhập thông tin", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Nhập tên"
                }
                alert.addTextField { (textField) in
                    textField.placeholder = "Nhập số điện thoại"
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    let name = alert.textFields?[0].text ?? ""
                    let phoneNumber = alert.textFields?[1].text ?? ""

                    if self.isValidPhoneNumber(phoneNumber: phoneNumber) {
                        self.names[self.names.count - 1] = name
                        self.phoneNumbers[self.names.count - 1] = phoneNumber
                        self.tableView.reloadRows(at: [IndexPath(row: self.names.count - 1, section: 0)], with: .automatic)
                    } else {
                        // Show error alert
                        let errorAlert = UIAlertController(title: "Lỗi", message: "Số điện thoại không hợp lệ. Vui lòng nhập lại.", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(errorAlert, animated: true)
                    }
                })
                self.present(alert, animated: true,
         completion: nil)
            }
    
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
            // Regular expression to validate phone numbers (adjust based on your region)
            let phoneRegex = "^[0-9+]{6,15}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phoneNumber)
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete
     {
                // Xóa dữ liệu tương ứng
                names.remove(at: indexPath.row)
                phoneNumbers.remove(at: indexPath.row)
                images.remove(at: indexPath.row)

                // Xóa cell khỏi table view
                tableView.deleteRows(at: [indexPath], with: .automatic)             }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? VCDetailed,
               let data = sender as? [String: Any] {
                destination.name = data["name"] as? String
                destination.phoneNumber = data["phone"] as? String
                destination.image = data["image"] as? UIImage
            }
        }
    
    }
