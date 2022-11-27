//
//  CharacterTableView.swift
//  characterList
//
//  Created by Adam Ramasre on 5/3/22.
//

import UIKit
import CoreData
import Darwin


var characterList = [UltimateCharacter]()


class CharacterTableView : UITableViewController {
    
    var firstLoad = true
    
    
    func nonDeletedList() -> [UltimateCharacter]
    {
        var nonDeletedCharacterList = [UltimateCharacter]()
        for ultCharacter in characterList
        {
            if(ultCharacter.erased == false)
            {
                nonDeletedCharacterList.append(ultCharacter)
            }
        }
        return nonDeletedCharacterList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(firstLoad==true){
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"UltimateCharacter")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let ultimateCharacter = result as! UltimateCharacter
                    characterList.append(ultimateCharacter)
                }
            }
            catch{
                print("failed to fetch")
            }
            
        }
    
        
    }
    
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath:IndexPath)-> UITableViewCell{
        
        let characterCell = tableView.dequeueReusableCell(withIdentifier: "characterCellID", for: indexPath) as! CharacterCell
        //print("dequeued")
        let thisCharacter:UltimateCharacter!
        thisCharacter = nonDeletedList()[indexPath.row]

        characterCell.lblCharacterName.text = thisCharacter.characterName
        characterCell.lblOOSMove.text =  thisCharacter.fastestOOSMove
        characterCell.lblOOSFrame.text = thisCharacter.fastestOOSFrame
        characterCell.lbltipOne.text = thisCharacter.tipOne
        characterCell.lbltipTwo.text = thisCharacter.tipTwo
        characterCell.lbltipThree.text = thisCharacter.tipThree
        
        
        
        return characterCell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int)-> Int{
        
        return nonDeletedList().count
    }
    
    @IBAction func unwindFromCancel(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
        
    @IBAction func unwindFromSend(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
    @IBAction func saveFromSegue(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath:IndexPath){
        /*
        let thisCharacter:UltimateCharacter!
        thisCharacter = characterList[indexPath.row]
        
        let alertTitle = "\(thisCharacter.characterName ?? "Blank")"
        let message = "Fastest OOS: \(thisCharacter.fastestOOSMove ?? "Blank" ):\(thisCharacter.fastestOOSFrame ?? "Blank")\n \(thisCharacter.tipOne!)"
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style: UIAlertAction.Style.default, handler:nil))
        present(alert,animated:true,completion:nil)
        
         tableView.deselectRow(at: indexPath, animated: true)
        
        
        //maybe declare variable here
        
                

        
       
        print(tableView.indexPathForSelectedRow)


        
        //self.performSegue(withIdentifier:"editCharacter", sender: self)
        */
        
    }

    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editCharacter")
        {
            
            //print(tableView.indexPathForSelectedRow!) prints nil
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let characterDetail = segue.destination as? CharacterDetailVC
            
            let selectedCharacter: UltimateCharacter!
            selectedCharacter = nonDeletedList()[indexPath.row]
            characterDetail!.selectedCharacter = selectedCharacter
            
            
            characterDetail?.btnSave = "Click to Save Any Changes"
            
            characterDetail?.btnDelete = "Delete Existing Character"
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        }
        else if(segue.identifier == "newCharacter")
        {
            let characterDetail = segue.destination as? CharacterDetailVC
            
            characterDetail?.btnSave = "Click to Save a Copy"
            characterDetail?.btnDelete = "Delete New Character"
        }
    }
    
        

}
