import UIKit

class VCDetailed: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var name: String?
    var phoneNumber: String?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        imageView.image = image
    }
}
