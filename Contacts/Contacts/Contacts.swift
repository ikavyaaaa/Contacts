//
//  Item.swift
//  Contacts
//
//  Created by Kavya Krishna on 27/05/25.
//

import Foundation
import SwiftData

@Model
final class Contacts {
    var firstName: String
    var lastName: String
    var phoneNumber: String

    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
