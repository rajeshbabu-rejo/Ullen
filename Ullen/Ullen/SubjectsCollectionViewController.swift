//
//  SubjectsCollectionViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 20/02/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class SubjectsCollectionViewController: UICollectionViewController {
    var subject:[Subject] = [Subject(subjectCode: "18CSS202J", subjectTitle: "5G Communications", attendeesCount: "0"), Subject(subjectCode: "18CSS102J", subjectTitle: "Cryptography", attendeesCount: "0"), Subject(subjectCode: "18CSS302J", subjectTitle: "Computer Networks", attendeesCount: "0")]
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            return subject.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DashboardCollectionViewControllerCellCollectionViewCell
        //Step 2: Fetch model object to display
        let subject = subject[indexPath.item]

        //Step 3: Configure cell
        cell.update(with: subject)

        //Step 4: Return cell
        // Configure the cell
    
        return cell
    }
    @IBSegueAction func addEditSubject(_ coder: NSCoder, sender: Any?) -> EditClassTableViewController? {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            // Editing Subject
            let subjectToEdit = subject[indexPath.row]
            return EditClassTableViewController(coder: coder, subject: subjectToEdit)
        } else {
            // Adding Emoji
            return EditClassTableViewController(coder: coder, subject: nil)
        }
    }

    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? EditClassTableViewController,
              let subjects = sourceViewController.subject else { return }
        
        if let paths = collectionView.indexPathsForSelectedItems, paths.count > 0 {
            subject[paths[0].row] = subjects
            collectionView.reloadItems(at: [paths[0]])
        } else {
            let newIndexPath = IndexPath(row: subject.count, section: 0)
            subject.append(subjects)
            collectionView.insertItems(at: [newIndexPath])
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { (action) in
                self.deleteSubject(at: indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }

    func deleteSubject(at indexPath: IndexPath) {
        subject.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}
