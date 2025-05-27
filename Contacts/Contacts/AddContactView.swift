//
//  AddContactView.swift
//  Contacts
//
//  Created by Kavya Krishna on 27/05/25.
//


import SwiftUI
import SwiftData

struct AddContactView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""

    var body: some View {
        content
    }
    
    private var content: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }

                Section(header: Text("Phone")) {
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newContact = Contacts(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                        modelContext.insert(newContact)
                        dismiss()
                    }
                    .disabled(firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty)
                }
            }
        }
    }
}
