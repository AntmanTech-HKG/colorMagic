//
//  FinishView.swift
//  colorMagic
//
//  Created by Anthony on 6/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

class BasePopupView: UIView {

    lazy var backgroundView: UIView = {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        backgroundView.addSubview(self)

//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
//        backgroundView.addGestureRecognizer(tap)

        return backgroundView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func show() {
        let keyWindow = UIApplication.shared.keyWindow!

        if !isDescendant(of: keyWindow) {
            UIView.animate(withDuration: 0.5, animations: {
                keyWindow.addSubview(self.backgroundView)
            })
        }
    }

    @IBAction func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.removeFromSuperview()
        })
    }
}

protocol FinishViewDelegate {
    func didSubmitScores(_ name: String)
}

// The user input may be implemented as a separate screen or as a popup
class FinishView: BasePopupView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!

    var delegate: FinishViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    private func setupLayout() {
        Bundle.main.loadNibNamed(Strings.FinishView.NibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderColor = UIColor.darkGray.cgColor

        nameField.textAlignment = .center
    }

    @IBAction func didPressSubmit(_ sender: UIButton) {
        // When a player submits his name, the entered value must pass basic validation (no empty strings) in order to continue
        if (nameField.text?.isEmpty)! {
            return
        } else {
            if let name = nameField.text {
                delegate?.didSubmitScores(name)
                dismiss()
            }
        }
    }

    @IBAction func didPressCancel(_ sender: UIButton) {
        dismiss()
    }
}
