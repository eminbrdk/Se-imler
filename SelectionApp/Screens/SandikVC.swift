import UIKit

class SandikVC: UIViewController {

    var chest: Chest!
    
    let rteImage = UIImageView()
    let kkImage = UIImageView()
    let rteButton = UIButton()
    let kkButton = UIButton()
    let rteCount = UILabel()
    let kkCount = UILabel()
    let rtePercantage = UILabel()
    let kkPercantage = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureImages()
        configureButtons()
        configureLabels()
        configureMinusButton()
    }

    private func configureView() {
        view.backgroundColor = Constant.backgroundColor
    }
    
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
    
    private func configureLabels() {
        let labelWidth: CGFloat = (view.width - 60) / 2
        
        for label in [rteCount, kkCount] {
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
            label.numberOfLines = 1
            label.textAlignment = .center
            
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: labelWidth),
                label.heightAnchor.constraint(equalToConstant: 50),
                label.topAnchor.constraint(equalTo: rteImage.bottomAnchor, constant: 20)
            ])
        }
        
        for label in [rtePercantage, kkPercantage] {
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            label.numberOfLines = 1
            label.textAlignment = .center
            
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: labelWidth),
                label.heightAnchor.constraint(equalToConstant: 50),
                label.topAnchor.constraint(equalTo: rteCount.bottomAnchor, constant: 20)
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
            rteCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kkCount.leadingAnchor.constraint(equalTo: rteCount.trailingAnchor, constant: 20),
            
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
    
    private func configureMinusButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Oy Eksilt", style: .done, target: self, action: #selector(minusButtonPressed))
    }
    
    @objc private func minusButtonPressed() {
        let alert = UIAlertController(title: "Oy Eksilt", message: "Lütfen 1 oy eksiltmek istediğiniz adayı seçin", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Recep Tayyip Erdoğan", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.chest.rteCount -= 1
            self.rteCount.text = String(chest.rteCount)
            DataManager.shared.save()
            changePercantage()
        }))
        alert.addAction(UIAlertAction(title: "Kemal Kılıçtaroğlu", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.chest.kkCount -= 1
            self.kkCount.text = String(chest.kkCount)
            DataManager.shared.save()
            changePercantage()
        }))
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        
        present(alert, animated: true)
    }
}
