//
//  ViewController.swift
//  colorMagic
//
//  Created by Anthony on 1/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            if cell.shown { return }
            gameController.didSelect(index: indexPath.item)
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.CardCell, for: indexPath)

        if let cell = cell as? CardCollectionViewCell {
            cell.showCard(show: false, animted: false)
            cell.card = gameController.cards[indexPath.item]
            cell.backImageView.image = cell.card?.image
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 * 4
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / Numeric.NoOfItemsInRow - 6
        let height = width * Numeric.CardRatio
        return CGSize(width: width, height: height)
    }
}

extension ViewController: FinishViewDelegate {
    func didSubmitScores(_ name: String) {
        print("name - \(name)")
        print("score - \(String(describing: title))")
        if let title = title, let score = Int(title) {
            let obj = Score(name: name, scores: Int(score))
            ScoreBoardManager.sharedInstance().save(score: obj)
            self.navigationController?.pushViewController(scoreBoardVC, animated: true)

        }
    }
}

extension ViewController: ColorMagicDelegate {

    func colorMagicShowCard(_ card: Card) {
        let index = gameController.getIndexFromCard(card)
        print("colorMagicShowCard card- \(card)")
        print("colorMagicShowCard index - \(index)")
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            cell.showCard(show: true, animted: true)
        }
    }

    func colorMagicHideCards(_ cards: [Card]) {
        print("colorMagicHideCards - \(cards)")
        for card in cards {
            let index = gameController.getIndexFromCard(card)
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
                cell.showCard(show: false, animted: false)
            }
        }
    }

    func colorMagicDidStart(_ game: ColorMagic) {
        print("colorMagicDidStart - ")
        colorMagicUpdateScore(0)
    }

    func colorMagicDidEnd(_ score: Int) {
        print("colorMagicDidEnd - \(score)")
        let fv = FinishView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        fv.delegate = self
        fv.center = view.center
        fv.show()
    }

    func colorMagicUpdateScore(_ score: Int) {
        // The current score should be displayed in the top, centered between the logo and the High Score button.
        title = "\(score)"
    }
}

class ViewController: UIViewController {

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let nib = UINib(nibName: "CardCollectionViewCell", bundle: nil)
        view.register(nib, forCellWithReuseIdentifier: Identifier.CardCell)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let restartBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Strings.Home.RestartBtn, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(didPressRestart), for: .touchUpInside)
        return btn
    }()

    @objc func didPressRestart(_ btn: UIButton) {
        // When a player taps on the restart button, a prompt will be displayed to the player whether the player wants to restart the game.
        let AC = UIAlertController(title: Strings.Home.ACTitle, message: Strings.Home.ACMsg, preferredStyle: .actionSheet)
        AC.addAction(UIAlertAction(title: Strings.Home.ACAConfirmTitle, style: .destructive, handler: { (action) in
            self.collectionView.isUserInteractionEnabled = false
            self.gameController.resetGame()
            self.gameController.newGame()
            self.collectionView.reloadData()
            self.collectionView.isUserInteractionEnabled = true
        }));
        AC.addAction(UIAlertAction(title: Strings.Home.ACACancelTitle, style: .cancel, handler: nil))
        present(AC, animated: true, completion: nil)
    }

    @objc func didPressHighScores(_ btn: UIButton) {
        print("didPressHighScores")
//        Clicking the High Scores button will take the user to the table of high scores.
        self.navigationController?.pushViewController(scoreBoardVC, animated: true)
    }

    let gameController = ColorMagic()
    let scoreBoardVC = ScoreBoardTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarSetup()
        setupLayout()

//        ScoreBoardManager.sharedInstance().clean()
//        for index in 0...9 {
//            print("\(index)")
//            let obj = Score(name: "name_\(index)", scores: index)
//            ScoreBoardManager.sharedInstance().save(score: obj)
//        }

        gameController.newGame()
        gameController.delegate = self
        print("cards - \(gameController.cards)")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .portrait
    }

    private func setupLayout() {
        title = ViewTitles.kHome
        view.backgroundColor = .white

        // The High Scores button must be visible to the top right of the window.
        let heightScoresBarBtn = UIBarButtonItem(title: Strings.HighScores, style: .plain, target: self, action: #selector(didPressHighScores(_:)))
        navigationItem.rightBarButtonItems = [heightScoresBarBtn]

        collectionView.delegate = self
        collectionView.dataSource = self

        // The game board must be displayed below the logo and high score button and above the restart button.
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
//        collectionView.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: collectionView, attribute: .width, multiplier: (Numeric.CardRatio), constant: 0))
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width * Numeric.CardRatio).isActive = true

        // The restart button must be displayed on the bottom of screen
        view.addSubview(restartBtn)
        if #available(iOS 11.0, *) {
            restartBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            restartBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }
        restartBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        restartBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        restartBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true

    }



}

