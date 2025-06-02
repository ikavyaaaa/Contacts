//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Kavya Krishna on 02/06/25.
//


import Combine

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contacts] = []
    @Published var searchText: String = ""

    private let repository: ContactsRepository

    init(repository: ContactsRepository) {
        self.repository = repository
        loadContacts()
    }

    func loadContacts() {
        contacts = repository.fetchContacts()
    }

    func filteredContacts() -> [Contacts] {
        guard !searchText.isEmpty else { return contacts }
        return contacts.filter {
            $0.firstName.localizedCaseInsensitiveContains(searchText) ||
            $0.lastName.localizedCaseInsensitiveContains(searchText) ||
            $0.phoneNumber.localizedCaseInsensitiveContains(searchText)
        }
    }

    func add(contact: Contacts) {
        repository.addContact(contact)
        loadContacts()
    }
}
