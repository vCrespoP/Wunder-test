import Foundation
import Domain

extension ListViewController {

    func configureTable() {
        self.tvContent.delegate = self
        self.tvContent.dataSource = self

        self.tvContent.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.tvContent.registerCellNib(ofType: CellVehicle.self)
        self.tvContent.separatorInset = UIEdgeInsets.zero
        self.tvContent.rowHeight = 112
    }

}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let item: Vehicle = self.presenter?.datasource?[indexPath.row] else {
            return
        }

        Log.debug(("Selected item: \(item)"))

        self.showDemoLimitation()

    }
}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.datasource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let item: Vehicle = self.presenter?.datasource?[indexPath.row] else {
            return UITableViewCell()
        }

        if let cell = tableView.dequeueReusableCell(withIdentifier: CellVehicle.reuseId) as? CellVehicle {
            cell.fill(with: item)
            cell.backgroundColor = UIColor.clear
            return cell
        }

        return UITableViewCell()

    }

}
