//
//  DashboardCollectionViewControllerCellCollectionViewCell.swift
//  Ullen
//
//  Created by Rajesh Babu on 20/02/23.
//

import UIKit

class DashboardCollectionViewControllerCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subjectCodeLabel:UILabel!
    @IBOutlet weak var subjectTitleLabel:UILabel!
    @IBOutlet weak var attendeesCountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with subject: Subject) {
        subjectCodeLabel.text = subject.subjectCode
        subjectTitleLabel.text = subject.subjectTitle
        attendeesCountLabel.text = subject.attendeesCount
    }
}
