
import UIKit

private var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.doesRelativeDateFormatting = true
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
}()

class MultipleChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var mcLabel: UILabel!
    var multipleChoice: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
