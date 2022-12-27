//
//  UITableViewCell+.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
    static var reuseIdentifier: String { String(describing: Self.self) }
}
