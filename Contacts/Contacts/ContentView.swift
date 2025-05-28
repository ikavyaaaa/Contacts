//
//  ContentView.swift
//  Contacts
//
//  Created by Kavya Krishna on 27/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Contacts.firstName, order: .forward)])
    private var items: [Contacts]
    @State private var showingAddContact = false

    var body: some View {
        content
    }
    
    private var content: some View {
        NavigationSplitView {
            List {
                ForEach(items) { contact in
                    NavigationLink {
                        Text("Phone: \(contact.phoneNumber)")
                    } label: {
                        Text("\(contact.firstName) \(contact.lastName)")
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showingAddContact = true
                    }) {
                        Label("Add Contact", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a contact")
        }
        .sheet(isPresented: $showingAddContact) {
            AddContactView()
        }
    }
}

