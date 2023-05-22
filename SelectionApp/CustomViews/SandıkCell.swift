import UIKit

class ChestCell: UITableViewCell {

    static let reuseID = "ChestCell"
    let chestName: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(text: String) {
        chestName.text = "Sandık Numarası: \(text)"
    }
    
    private func configure() {
        addSubview(chestName)
        selectionStyle = .none
        backgroundColor = Constant.backgroundColor
        
        NSLayoutConstraint.activate([
            chestName.centerYAnchor.constraint(equalTo: centerYAnchor),
            chestName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            chestName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
}
