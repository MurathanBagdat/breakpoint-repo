//
//  SecondViewController.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    //Varibles
    
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DataService.instance.REF_GROUPS.observe(.value, with: { (dataSnapshot) in
            DataService.instance.getGroupData { (returnedGroups) in
                if returnedGroups.count > 0 {
                    
                    self.groups = returnedGroups
                    self.tableView.reloadData()
                }else{
                    print("empty")
                }
            }
        })
    }
    
    @IBAction func toNewGroupVCButtonPrsd(_ sender: UIButton) {
        performSegue(withIdentifier: TO_NEW_GROUPVC, sender: nil)
    }
}

extension GroupVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsCell else {return UITableViewCell()}
        
        let group = groups[indexPath.row]
        cell.configurCell(group: group)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {return}
        let group = groups[indexPath.row]
        groupFeedVC.initData(ForGroup: group)
        presentDetail(groupFeedVC)
        
    }
}

