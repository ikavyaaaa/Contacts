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
    
    @State private var searchText = ""
    @State private var showingAddContact = false
    
    private var filteredItems: [Contacts] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.firstName.localizedCaseInsensitiveContains(searchText) ||
                $0.lastName.localizedCaseInsensitiveContains(searchText) ||
                $0.phoneNumber.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        NavigationSplitView {
            List {
                Section {
                    StaticMyCardView()
                }
                
                Section(header: Text("Contacts")) {
                    ForEach(filteredItems) { contact in
                        NavigationLink {
                            ContactDetailView(contact: contact)
                        } label: {
                            ContactRowView(contact: contact)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
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

struct StaticMyCardView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("Kavya Krishna")
                    .font(.headline)
                Text("My Card")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ContactRowView: View {
    let contact: Contacts
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 36, height: 36)
                .overlay(
                    Text(initials)
                        .foregroundColor(.black)
                        .font(.subheadline)
                )
            
            Text("\(contact.firstName) \(contact.lastName)")
        }
    }
    
    private var initials: String {
        let f = contact.firstName.first.map { String($0) } ?? ""
        let l = contact.lastName.first.map { String($0) } ?? ""
        return f + l
    }
}

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
