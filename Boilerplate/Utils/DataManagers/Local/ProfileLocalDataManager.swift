//
//  ProfileLocalDataManager.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 04/04/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileLocalDataManager: NSObject {
    
    //TODO: Implement methods to save/read info from local database here (such as Realm)
    //TODO: Methods related to User, Profile, CompanyProfile and similar entities can be implemented here
    
    func saveProfile(_ profile: UserProfile) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(profile, update: true)
        }
    }
    
    
    
}
