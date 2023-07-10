//
//  WelcomeVC.swift
//  28Mayıs
//
//  Created by Muhammed Emin Bardakcı on 26.05.2023.
//

import UIKit

class WelcomeVC: UIViewController {

    let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "evet"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    let info: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "28 Mayıs 2023 Seçimlerinde müşahitlerin oy sayımlarını kolaylaştırmak için çıkartılmış bir uygulamadır. Lütfen sayım yapacağınız sandığın numarasını ekleyerek devam ediniz :)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = .label
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sandık Ekle", for: .normal)
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = Constant.appColor
        button.configuration?.cornerStyle = .medium
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureImage()
        configureInfo()
        configureButton()
    }
    
    private func configureView() {
        title = "28 Mayıs"
        view.backgroundColor = .systemBackground
    }
    
    private func configureImage() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            image.heightAnchor.constraint(equalTo: image.widthAnchor)
        ])
    }
    
    private func configureInfo() {
        view.addSubview(info)
        
        NSLayoutConstraint.activate([
            info.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            info.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            info.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configureButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonPressed() {
        let alert = UIAlertController(title: "Sandık Ekle", message: "Lütfen sayım yapacağınız sandığın numarasını giriniz", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields?.first?.keyboardType = .numberPad
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ekle", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields!.first, let text = field.text, !text.isEmpty, let self else { return }

            DataManager.shared.createChest(number: text)
            DataManager.shared.save()
            
            self.goChestsVC()
        }))

        present(alert, animated: true)
    }
    
    private func goChestsVC() {
        let tbc = SceneDelegate().createTabBarController()
        
        tbc.modalPresentationStyle = .fullScreen
        tbc.modalTransitionStyle = .coverVertical
        present(tbc, animated: true)
    }
}
