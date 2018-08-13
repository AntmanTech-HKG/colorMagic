//
//  ScoreBoardTableViewController.swift
//  colorMagic
//
//  Created by Anthony on 6/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

extension ScoreBoardTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ScoreCell, for: indexPath)
        if let cell = cell as? ScoreTableViewCell {
            if let obj = scores?[indexPath.row] {
                cell.rankLbl?.text = "\(indexPath.row + 1)"
                cell.nameLbl?.text = obj.name
                cell.scoreLbl?.text = "\(obj.scores!)"
            }
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if scores == nil {
            backgroundView.frame = tableView.frame
            tableView.backgroundView = backgroundView
            return 0
        } else {
            tableView.backgroundView = nil
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores != nil ? (scores?.count)! : 0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        return vw
    }
}

class ScoreBoardTableViewController: UITableViewController {

    var scores: [Score]? = nil
    
    let backgroundView: UILabel = {
       let bv = UILabel(frame: .zero)
        bv.text = Strings.ScoreBoard.BackgroundViewText
        bv.backgroundColor = .lightGray
        bv.textAlignment = .center
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ViewTitles.kScoreBoard

        let nib = UINib(nibName: Strings.ScoreBoard.NibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Identifier.ScoreCell)
        tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        tableView.separatorColor = .black
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scores = ScoreBoardManager.sharedInstance().get()
        tableView.reloadData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .all
    }

    override func viewWillDisappear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .portrait
        UIViewController.attemptRotationToDeviceOrientation()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }


}
