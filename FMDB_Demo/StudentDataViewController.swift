//
//  StudentDataViewController.swift
//  FMDB_Demo
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FMDB

var databasePath = String()

class StudentDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet var StudentDataTableView: UITableView!
    
    var dict = [[String : AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentDataTableView.delegate = self
        StudentDataTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        dict = []
        
        makeDB()
        selectDB()
    }
    
    @IBAction func btnInsertAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let editDataViewController = storyBoard.instantiateViewController(withIdentifier: "editDataViewController") as! EditDataViewController
        self.present(editDataViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = StudentDataTableView.dequeueReusableCell(withIdentifier: "studentDataTableViewCell", for: indexPath) as! StudentDataTableViewCell
        
        cell.selectionStyle = .none
        
        cell.btnEdit.isHidden = true
        
        if(dict.count != 0)
        {
            cell.lblName.text = "Name : \(dict[indexPath.row]["name"] as! String)"
            cell.lblMarks.text = "Marks : \(dict[indexPath.row]["marks"] as! String)"
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(deleteRow(selector:)), for: .touchUpInside)
        }
        
        
        return cell
    }
    
    
    func makeDB()
    {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("studentresult.db").path
        print(databasePath)
        
        if !filemgr.fileExists(atPath: databasePath as String)
        {
            let resultDB = FMDatabase(path: databasePath as String)
            
            if resultDB == nil
            {
                print("Error: \(resultDB?.lastErrorMessage())")
            }
            else
            {
                if(resultDB?.open())!
                {
                    let sql_statement = "CREATE TABLE IF NOT EXISTS studentmarks (id INTEGER PRIMARY KEY AUTOINCREMENT , name Text , marks Text);"


                    
                    if !((resultDB?.executeStatements(sql_statement))!)
                    {
                        print("Error while executing sql : \(resultDB?.lastErrorMessage())")
                    }
                    else
                    {
                        print("Table created successfully")
                        
                    }
 
                    
                    /*
                    do
                    {
                            try resultDB?.executeUpdate(sql_statement, values: nil)
                        
                    }
                    catch let error as Error
                    {
                        print("failed : \(error.localizedDescription)")
                    }
                    */
                   
                    
 
                    resultDB?.close()
                    
                    
                }
                else
                {
                    print("Error while opening DB : \(resultDB?.lastErrorMessage())")
                }
            }
        }
        
        
        
    }

    func selectDB()
    {
        let resultDB = FMDatabase(path: databasePath as String)
        
        if (resultDB?.open())! {
            let querySQL = "SELECT * FROM studentmarks;"
            
            let results:FMResultSet? = resultDB?.executeQuery(querySQL,withArgumentsIn: nil)

            /*
            if results?.next() == true
            {
                print(results)
                print(results?.string(forColumn: "name"))
                print(results?.resultDictionary())
                
                x = results?.resultDictionary() as! NSDictionary
                
                print(x)
                
            } else {
                
                print("No Data Selected : \(resultDB?.lastErrorMessage())")
            }
            */
            
            while results?.next() == true
            {
                print(results)
                print(results?.string(forColumn: "name"))
                print(results?.resultDictionary())
                
                //x = results?.resultDictionary() as! NSDictionary
                
                dict.append(results?.resultDictionary() as! [String : AnyObject])
                
            }
            
            print(dict)
            
            StudentDataTableView.reloadData()
            
            resultDB?.close()
        } else {
            print("Error: \(resultDB?.lastErrorMessage())")
        }
    }
    
    
    @objc func deleteRow(selector : UIButton)
    {
        let index = selector.tag
        
        let resultDB = FMDatabase(path: databasePath as String)
        
        if (resultDB?.open())! {
            
            let deleteSQL = "Delete FROM studentmarks where name = '\(dict[index]["name"] as! String)';"
            
            if !((resultDB?.executeStatements(deleteSQL))!)
            {
                print("Error while executing sql : \(resultDB?.lastErrorMessage())")
            }
            else
            {
                print("deleted successfully")
                
                 dict = []
                
                selectDB()
                
            }
            
            resultDB?.close()
        } else {
            print("Error: \(resultDB?.lastErrorMessage())")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
