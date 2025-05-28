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
        NavigationSplitView {
            List {
                if let myCard = items.first {
                    Section {
                        ContactCardView(contact: myCard, isMyCard: true)
                    }
                }

                Section(header: Text("Contacts")) {
                    ForEach(filteredItems) { contact in
                        NavigationLink {
                            ContactDetailView(contact: contact)
                        } label: {
                            ContactCardView(contact: contact)
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

struct ContactCardView: View {
    let contact: Contacts
    var isMyCard: Bool = false

    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 44, height: 44)
                .overlay(Text(initials).foregroundColor(.blue))

            VStack(alignment: .leading) {
                Text("\(contact.firstName) \(contact.lastName)")
                    .fontWeight(isMyCard ? .bold : .regular)
                if isMyCard {
                    Text("My Card")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 4)
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
