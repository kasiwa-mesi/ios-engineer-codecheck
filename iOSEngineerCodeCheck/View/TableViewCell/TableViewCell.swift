//
//  TableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private weak var repositoryFullName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryFullName.text = nil
    }
    
    func configure(repository: RepositoryModel) {
        repositoryFullName.text = repository.fullName
    }
}
