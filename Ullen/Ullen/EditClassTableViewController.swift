//
//  EditClassTableViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 20/02/23.
//

import UIKit

class EditClassTableViewController: UITableViewController {
    var subject: Subject?
    
    @IBOutlet var subjectCodeText: UITextField!
    @IBOutlet var subjectTitleText: UITextField!
    @IBOutlet var attendeesCountText: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let subject = subject {
            subjectCodeText.text = subject.subjectCode
            subjectTitleText.text = subject.subjectTitle
            attendeesCountText.text = subject.attendeesCount
            title = "Edit Class"
        } else {
            title = "Add Class"
        }
print("working")
        updateSaveButtonState()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    init?(coder: NSCoder, subject: Subject?) {
        self.subject = subject
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    func updateSaveButtonState() {
        let nameText = subjectCodeText.text ?? ""
        let descriptionText = subjectTitleText.text ?? ""
        let usageText = attendeesCountText.text ?? ""
        saveButton.isEnabled = containsSingleData(subjectCodeText) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    func containsSingleData(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        
        let isData = text.unicodeScalars.first?.properties.isAlphabetic ?? false
        
        return isData
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }

        let code = subjectCodeText.text ?? ""
        let name = subjectTitleText.text ?? ""
        let attendees = attendeesCountText.text ?? ""
        subject = Subject(subjectCode: code, subjectTitle: name, attendeesCount: attendees)
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
