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
    @Query private var items: [Contacts]
    
    @State private var showingAddContact = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { contact in
                    NavigationLink {
                        Text("Phone: \(contact.phoneNumber)")
                    } label: {
                        Text("\(contact.firstName) \(contact.lastName)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Contacts.self, inMemory: true)
}
