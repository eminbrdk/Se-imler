//
//  NoChestView.swift
//  28Mayıs
//
//  Created by Muhammed Emin Bardakcı on 24.05.2023.
//

import UIKit

class NoChestView: UIView {

    let text: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.text = "Hiç sandık eklememişsiniz lütfen sağ yukardaki sandık ekle yazısına tıklayıp eklemek istediğiniz sadığın numarasını giriniz."
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        text.textColor = .label
       
        text.adjustsFontSizeToFitWidth = true
        text.minimumScaleFactor = 0.9
        text.numberOfLines = 0
        text.lineBreakMode = .byTruncatingTail
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(text)
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: centerYAnchor),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            text.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
