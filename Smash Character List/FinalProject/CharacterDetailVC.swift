//
//  CharacterDetailVC.swift
//  FinalProject
//
//  Created by Adam Ramasre on 5/3/22.
//
//
//  ViewController.swift
//  characterList
//
//  Created by Adam Ramasre on 4/29/22.
//

import UIKit
import CoreData



class CharacterDetailVC: UIViewController {
    
    
    var selectedCharacter: UltimateCharacter? = nil

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblSaveButton.setTitle(btnSave, for: .normal)
        lblDeleteButton.setTitle(btnDelete, for: .normal)
        
        
        // Do any additional setup after loading the view.
        
        tfCharacterName.text = selectedCharacter?.characterName
        tfMoveName.text = selectedCharacter?.fastestOOSMove
        tfFrame.text = selectedCharacter?.fastestOOSFrame
        tftipOne.text = selectedCharacter?.tipOne
        tftipTwo.text = selectedCharacter?.tipTwo
        tftipThree.text = selectedCharacter?.tipThree

        
    }
    
    var btnSave:String = ""
    var btnDelete:String = ""
    
    @IBOutlet weak var lblSaveButton: UIButton!
    
    @IBOutlet weak var tfCharacterName: UITextField!
    
    @IBOutlet weak var tfMoveName: UITextField!
    @IBOutlet weak var tfFrame: UITextField!
    @IBOutlet weak var tftipOne: UITextField!
    @IBOutlet weak var tftipTwo: UITextField!
    @IBOutlet weak var tftipThree: UITextField!
    
    @IBOutlet weak var lblDeleteButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedCharacter == nil)
        {
            
            let entity = NSEntityDescription.entity(forEntityName: "UltimateCharacter", in: context)
            let newCharacter = UltimateCharacter(entity: entity!, insertInto: context)
           
            newCharacter.id = characterList.count as NSNumber
            newCharacter.characterName = tfCharacterName.text
            newCharacter.fastestOOSMove = tfMoveName.text
            newCharacter.fastestOOSFrame = tfFrame.text
            newCharacter.tipOne = tftipOne.text
            newCharacter.tipTwo = tftipTwo.text
            newCharacter.tipThree = tftipThree.text
            
            do
            {
                try context.save()
                characterList.append(newCharacter)
                navigationController?.popViewController(animated: true)
                
            }
            catch
            {
                print("Could not save context")
            }
        } else{ //edit
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"UltimateCharacter")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let ultimateCharacter = result as! UltimateCharacter
                    if(ultimateCharacter == selectedCharacter)
                    {
                        ultimateCharacter.characterName = tfCharacterName.text
                        ultimateCharacter.fastestOOSMove=tfMoveName.text
                        ultimateCharacter.fastestOOSFrame=tfFrame.text
                        ultimateCharacter.tipOne=tftipOne.text
                        ultimateCharacter.tipTwo=tftipTwo.text
                        ultimateCharacter.tipThree=tftipThree.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch{
                print("failed to fetch")
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func deleteCharacter(_ sender: Any){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"UltimateCharacter")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let ultimateCharacter = result as! UltimateCharacter
                if(ultimateCharacter == selectedCharacter)
                {
                    ultimateCharacter.erased = true
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
            
        catch
        {
                print("failed to fetch")
            
        }
    }
    
    @IBAction func hideTheKeyboard(){
        self.view.endEditing(true)
    }

}


