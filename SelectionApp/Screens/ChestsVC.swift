import UIKit

class ChestsVC: UIViewController {

    var chests: [Chest] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getChestsData()
        configureView()
        configureTableView()
    }
    
    private func getChestsData() {
        chests = DataManager.shared.getAllChestsData()
        
        if chests.isEmpty == true {
            let alert = UIAlertController(title: "Sandık Ekle", message: "Lütfen sayım yapacağınız sandığın numarasını giriniz", preferredStyle: .alert)
            
            alert.addTextField()
            alert.textFields?.first?.keyboardType = .numberPad
            
            alert.addAction(UIAlertAction(title: "Ekle", style: .default, handler: { [weak self] _ in
                guard let field = alert.textFields!.first, let text = field.text, !text.isEmpty, let self else {
                    self?.getChestsData()
                    return
                }

                DataManager.shared.createChest(number: text)
                DataManager.shared.save()
                self.getChestsData()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))

            present(alert, animated: true)
        }
    }
    
    private func configureView() {
        view.backgroundColor = Constant.backgroundColor
        title = "Sandıklar"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sandık Ekle", style: .done, target: self, action: #selector(buttonPressed))
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.backgroundColor = Constant.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorColor = .darkGray
        tableView.register(ChestCell.self, forCellReuseIdentifier: ChestCell.reuseID)
    }

    @objc private func buttonPressed() {
        let alert = UIAlertController(title: "Sandık Ekle", message: "Lütfen sayım yapacağınız sandığın numarasını giriniz", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields?.first?.keyboardType = .numberPad
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ekle", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields!.first, let text = field.text, !text.isEmpty, let self else {
                self?.buttonPressed()
                return
            }

            DataManager.shared.createChest(number: text)
            DataManager.shared.save()
            self.getChestsData()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))

        present(alert, animated: true)
    }
}

extension ChestsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChestCell.reuseID) as! ChestCell
        let chest = chests[indexPath.row]
        cell.set(text: chest.chestNumber!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chest = chests[indexPath.row]

        let vc = ChestVC()
        vc.chest = chest
        vc.title = "Sandık No: \(chest.chestNumber!)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let chest = chests[indexPath.row]
        DataManager.shared.deleteChest(chest: chest)
        DataManager.shared.save()
        getChestsData()
        tableView.reloadData()
    }
}
