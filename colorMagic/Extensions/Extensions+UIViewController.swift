//
//  Extensions+UIViewController.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

extension UIViewController {

    func navBarSetup() {
        // The logo must be displayed in the top left of the window.
        let logoBtn: UIButton = {
            let btn = UIButton(frame: .zero)
            btn.setImage(UIImage(named: "logo"), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.contentMode = .scaleAspectFit
            btn.addTarget(self, action: #selector(didPressLogo), for: .touchUpInside)
            btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
            return btn
        }()

        let logoBarBtn = UIBarButtonItem(customView: logoBtn)
        navigationItem.leftBarButtonItems = [logoBarBtn]

    }

    @objc func didPressLogo(btn: UIButton) {
        let url = URL(string: Strings.HyperLink)
        UIApplication.shared.openURL(url!)
    }
}
