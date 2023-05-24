import UIKit

class ChestVC: UIViewController {

    var chest: Chest!
    
    let rteImage = UIImageView()
    let kkImage = UIImageView()
    let rteButton = UIButton()
    let kkButton = UIButton()
    
    let rteStackView = UIStackView()
    let rteMinusButton = UIButton()
    let rteCount = UILabel()
    
    let kkStackView = UIStackView()
    let kkMinusButton = UIButton()
    let kkCount = UILabel()
    
    let rtePercantage = UILabel()
    let kkPercantage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureImages()
        configureButtons()
        configureVoteViews()
    }

    private func configureView() {
        view.backgroundColor = Constant.backgroundColor
    }
    
// MARK: - Images
    
    private func configureImages() {
        let imageWidth: CGFloat = (view.width - 60) / 2
        
        for image in [rteImage, kkImage] {
            view.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            
            image.clipsToBounds = true
            image.layer.cornerRadius = 8
            image.contentMode = .scaleAspectFill
            
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
                image.heightAnchor.constraint(equalToConstant: imageWidth),
                image.widthAnchor.constraint(equalToConstant: imageWidth)
            ])
        }
        
        rteImage.image = UIImage(named: "rte")
        kkImage.image = UIImage(named: "kk")
        
        NSLayoutConstraint.activate([
            rteImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kkImage.leadingAnchor.constraint(equalTo: rteImage.trailingAnchor, constant: 20)
        ])
    }
    
// MARK: - Plus Buttons
    
    private func configureButtons() {
        let buttonWidth: CGFloat = (view.width - 60) / 2
        
        for button in [rteButton, kkButton] {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.configuration = .filled()
            button.configuration?.baseForegroundColor = .white
            button.configuration?.cornerStyle = .medium
            
            button.configuration?.image = UIImage(systemName: "person.fill.badge.plus")
            button.configuration?.imagePlacement = .leading
            button.configuration?.imagePadding = 8
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 58),
                button.widthAnchor.constraint(equalToConstant: buttonWidth),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }
        
        rteButton.configuration?.baseBackgroundColor = Constant.rteColor
        rteButton.setTitle("Recep Tayyip Erdoğan", for: .normal)
        rteButton.addTarget(self, action: #selector(rteButtonPressed), for: .touchUpInside)
        
        kkButton.configuration?.baseBackgroundColor = Constant.kkColor
        kkButton.setTitle("Kemal Kılıçtaroğlu", for: .normal)
        kkButton.addTarget(self, action: #selector(kkButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kkButton.leadingAnchor.constraint(equalTo: rteButton.trailingAnchor, constant: 20)
        ])
    }
    
    @objc private func rteButtonPressed() {
        chest.rteCount += 1
        rteCount.text = String(chest.rteCount)
        DataManager.shared.save()
        changePercantage()
    }
    
    @objc private func kkButtonPressed() {
        chest.kkCount += 1
        kkCount.text = String(chest.kkCount)
        DataManager.shared.save()
        changePercantage()
    }
    
// MARK: - VoteViews
    
    private func configureVoteViews() {
        let contentWidth: CGFloat = (view.width - 60) / 2
        
        for stack in [rteStackView, kkStackView] {
            view.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints =  false
            stack.axis = .horizontal
            stack.spacing = 0
            stack.alignment = .center
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stack.widthAnchor.constraint(equalToConstant: contentWidth),
                stack.heightAnchor.constraint(equalToConstant: 50),
                stack.topAnchor.constraint(equalTo: rteImage.bottomAnchor, constant: 20)
            ])
        }
        NSLayoutConstraint.activate([
            rteStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            kkStackView.leadingAnchor.constraint(equalTo: rteStackView.trailingAnchor, constant: 20)
        ])
        rteStackView.addArrangedSubview(rteMinusButton)
        rteStackView.addArrangedSubview(rteCount)
        kkStackView.addArrangedSubview(kkMinusButton)
        kkStackView.addArrangedSubview(kkCount)
        
        for button in [rteMinusButton, kkMinusButton] {
            button.configuration = .filled()
            button.configuration?.image = UIImage(systemName: "person.fill.badge.minus")
            button.translatesAutoresizingMaskIntoConstraints = false
            button.configuration?.baseForegroundColor = .white
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 50)
            ])
        }
        rteMinusButton.configuration?.baseBackgroundColor = Constant.rteColor
        kkMinusButton.configuration?.baseBackgroundColor = Constant.kkColor
        rteMinusButton.addTarget(self, action: #selector(rteMinusButtonPressed), for: .touchUpInside)
        kkMinusButton.addTarget(self, action: #selector(kkMinusButtonPressed), for: .touchUpInside)
        
        for label in [rteCount, kkCount] {
            label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
        }
        
        for label in [rtePercantage, kkPercantage] {
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            label.numberOfLines = 1
            label.textAlignment = .center
            
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: contentWidth),
                label.heightAnchor.constraint(equalToConstant: 50),
                label.topAnchor.constraint(equalTo: rteStackView.bottomAnchor, constant: 20)
            ])
        }
        
        rteCount.textColor = Constant.rteColor
        rteCount.text = String(chest.rteCount)
        kkCount.textColor = Constant.kkColor
        kkCount.text = String(chest.kkCount)
        
        rtePercantage.textColor = Constant.rteColor
        kkPercantage.textColor = Constant.kkColor
        changePercantage()
        
        NSLayoutConstraint.activate([
            rtePercantage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kkPercantage.leadingAnchor.constraint(equalTo: rtePercantage.trailingAnchor, constant: 20),
        ])
    }
    
    private func changePercantage() {
        if chest.rteCount == 0 && chest.kkCount == 0 {
            rtePercantage.text = "%0"
            kkPercantage.text = "%0"
        } else {
            let num1 = Double(chest.rteCount) / (Double(chest.rteCount) + Double(chest.kkCount)) * 100
            rtePercantage.text = "% \(round(num1 * 100) / 100.0)"
            let num2 = Double(chest.kkCount) / (Double(chest.rteCount) + Double(chest.kkCount)) * 100
            kkPercantage.text = "% \(round(num2 * 100) / 100.0)"
        }
    }
    
    @objc private func rteMinusButtonPressed() {
        let alert = UIAlertController(title: "Oy Eksilt", message: "Recep Tayyip Erdoğan'ın oyunu eksiltmek istediğinize emin misiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Oy Eksilt", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.chest.rteCount -= 1
            self.rteCount.text = String(chest.rteCount)
            DataManager.shared.save()
            changePercantage()
        }))
        present(alert, animated: true)
    }
    
    @objc private func kkMinusButtonPressed() {
        let alert = UIAlertController(title: "Oy Eksilt", message: "Kemal Kılıçdaroğlu'nun oyunu eksiltmek istediğinize emin misiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Oy Eksilt", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.chest.kkCount -= 1
            self.kkCount.text = String(chest.kkCount)
            DataManager.shared.save()
            changePercantage()
        }))
        present(alert, animated: true)
    }
}
