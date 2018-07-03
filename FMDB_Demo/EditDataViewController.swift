//
//  EditDataViewController.swift
//  FMDB_Demo
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FMDB


class EditDataViewController: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtMarks: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        print(databasePath)
        
        if (contactDB?.open())! {
            
            let insertSQL = "INSERT INTO studentmarks (name, marks) VALUES ('\(txtName.text!)', '\(txtMarks.text!)');"
            
            let result = contactDB?.executeUpdate(insertSQL,withArgumentsIn: nil)
            
            if !result! {
                
                print("Error: \(contactDB?.lastErrorMessage())")
            } else {
                print("Contact Added")
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        
        
    }
    
    /*
    
    func makeDB()
    {
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        databasePath = dirPaths[0].appendingPathComponent("StudentResult.db").path
        
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
                    let sql_statement = "CREATE TABLE IF NOT EXISTS STUDENTMARKS (ID INTEGER PRIMARY KEY AUTOINCREMENT , NAME TEXT , MARKS FLOAT)"
                    
                    if !((resultDB?.executeStatements(sql_statement))!)
                    {
                        print("Error while executing sql : \(resultDB?.lastErrorMessage())")
                    }
                    else
                    {
                        print("Table created successfully")
                    }
                    
                    resultDB?.close()
                }
                else
                {
                    print("Error while opening DB : \(resultDB?.lastErrorMessage())")
                }
            }
        }
        
    }
 
 */
    
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
