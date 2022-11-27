//
//  smashCharacter.swift
//  characterList
//
//  Created by Adam Ramasre on 5/3/22.
//

import CoreData


@objc (UltimateCharacter)
class UltimateCharacter:NSManagedObject {
    @NSManaged var id:NSNumber!
    @NSManaged var characterName:String!
    @NSManaged var fastestOOSMove:String!
    @NSManaged var fastestOOSFrame:String!
    @NSManaged var tipOne:String!
    @NSManaged var tipTwo:String!
    @NSManaged var tipThree:String!
    @NSManaged var erased:Bool
    
}
