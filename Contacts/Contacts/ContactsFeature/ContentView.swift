//
//  ContentView.swift
//  Contacts
//
//  Created by Kavya Krishna on 27/05/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = ContactsViewModel(repository: DummyRepository())
    @State private var showingAddContact = false
    
    var body: some View {
        content
            .onAppear {
                viewModel.repository = SwiftDataContactsRepository(modelContext: modelContext)
                viewModel.loadContacts()
            }
    }
    
    private var content: some View {
        NavigationSplitView {
            List {
                Section {
                    StaticMyCardView()
                }
                
                Section(header: Text("Contacts")) {
                    ForEach(viewModel.filteredContacts()) { contact in
                        NavigationLink {
                            ContactDetailView(contact: contact)
                        } label: {
                            ContactRowView(contact: contact)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
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
                .environmentObject(viewModel)
        }
    }
}
