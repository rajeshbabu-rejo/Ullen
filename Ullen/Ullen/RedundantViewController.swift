////
////  RedundantViewController.swift
////  Ullen
////
////  Created by Rajesh Babu on 20/02/23.
////
//
//import UIKit
//private let reuseIdentifier = "Cell"
//
//class RedundantViewController: UIViewController, UICollectionViewController {
//    var subject: [Subject] = [Subject(subjectCode: "18CSS202J",subjectTitle: "5G Communication", attendeesCount: "0"), Date: "0",]
//        @IBOutlet weak var studentCollectionView: UICollectionView!
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            studentCollectionView.dataSource = self
//            studentCollectionView.delegate = self
//            studentCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
//
//            // Uncomment the following line to preserve selection between presentations
//            // self.clearsSelectionOnViewWillAppear = false
//
//            // Register cell classes
//    //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//            // Do any additional setup after loading the view.
//        }
//        override func viewWillAppear(_ animated: Bool) {
//            studentCollectionView.reloadData()
//        }
//
//        /*
//        // MARK: - Navigation
//
//        // In a storyboard-based application, you will often want to do a little preparation before navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using [segue destinationViewController].
//            // Pass the selected object to the new view controller.
//        }
//        */
//
//        // MARK: UICollectionViewDataSource
//
//         func numberOfSections(in collectionView: UICollectionView) -> Int {
//            // #warning Incomplete implementation, return the number of sections
//            return 1
//        }
//
//
//         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            // #warning Incomplete implementation, return the number of items
//            return dataModel.getSubjectCount()
//        }
//
//         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DashboardCollectionViewControllerCellCollectionViewCell
//            
//            let subject = dataModel.getSubject(at: indexPath.row)
//            cell.subjectCodeLabel.text = subject.subjectCode
//            cell.subjectTitleLabel.text = subject.subjectTitle
//            cell.attendeesCountLabel.text = subject.attendeesCount
//            // Configure the cell
//            return cell
//        }
//    @IBSegueAction func addEditClass(_ coder: NSCoder, sender: Any?) -> EditClassTableViewController? {
//        if let cell = sender as? UICollectionViewCell, let indexPath = studentCollectionView.indexPath(for: cell) {
//            // Editing Class
//            let classToEdit = dataModel.subjectAttendees[indexPath.row]
//            return EditClassTableViewController(coder: coder, subjectAttendees: classToEdit)
//        } else {
//            // Adding Emoji
//            return EditClassTableViewController(coder: coder, subjectAttendees: nil)
//        }
//    }
//    @IBAction func unwindToAddEditClassTableView(segue: UIStoryboardSegue) {
//        guard segue.identifier == "saveUnwind",
//            let sourceViewController = segue.source as? EditClassTableViewController,
//              let subjectAttendees = sourceViewController.subjectAttendees else { return }
//        
//        if let paths = studentCollectionView.indexPathsForSelectedItems, paths.count > 0 {
//            dataModel.subjectAttendees[paths[0].row] = subjectAttendees
//            studentCollectionView.reloadItems(at: [paths[0]])
//        } else {
//            let newIndexPath = IndexPath(row: dataModel.subjectAttendees.count, section: 0)
//            dataModel.subjectAttendees.append(subjectAttendees)
//            studentCollectionView.insertItems(at: [newIndexPath])
//        }
//    }
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 120.0, height: 180.0)
//        }
//        func generateLayout() -> UICollectionViewLayout {
//            // create item
//            // define the size of item
//            var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//            var item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4,
//               bottom: 0, trailing: 4)
//            //create group
//            var groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
//            var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
//            // create section
//            var section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPagingCentered
//            return UICollectionViewCompositionalLayout(section: section)
//        }
//        // MARK: UICollectionViewDelegate
//
//        /*
//        // Uncomment this method to specify if the specified item should be highlighted during tracking
//        override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//            return true
//        }
//        */
//
//        /*
//        // Uncomment this method to specify if the specified item should be selected
//        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//            return true
//        }
//        */
//
//        /*
//        // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//        override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//            return false
//        }
//
//        override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//            return false
//        }
//
//        override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//        
//        }
//        */
//
//    }
