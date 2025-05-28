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

    @State private var newContact = Contacts(firstName: "", lastName: "", phoneNumber: "")

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("First Name", text: $newContact.firstName)
                    TextField("Last Name", text: $newContact.lastName)
                }

                Section(header: Text("Phone")) {
                    TextField("Phone Number", text: $newContact.phoneNumber)
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
                        modelContext.insert(newContact)
                        dismiss()
                    }
                    .disabled(newContact.firstName.isEmpty || newContact.lastName.isEmpty || newContact.phoneNumber.isEmpty)
                }
            }
        }
    }
}

