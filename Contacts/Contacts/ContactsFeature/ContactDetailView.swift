//
//  ContactDetailView.swift
//  Contacts
//
//  Created by Kavya Krishna on 05/06/25.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contacts
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text("\(contact.firstName) \(contact.lastName)")
            }
            Section(header: Text("Phone")) {
                Text(contact.phoneNumber)
            }
        }
        .navigationTitle(contact.firstName)
    }
}
