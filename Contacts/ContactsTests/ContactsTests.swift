//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by Kavya Krishna on 27/05/25.
//

import Testing
import SwiftData
import Foundation
@testable import Contacts

struct ContactsTests {

    @Test
    func testContactModelInitialization() {
        let contact = Contacts(firstName: "Alice", lastName: "Smith", phoneNumber: "1234567890")
        #expect(contact.firstName == "Alice")
        #expect(contact.lastName == "Smith")
        #expect(contact.phoneNumber == "1234567890")
    }

    @MainActor @Test
    func testRepositoryInsertAndFetch() throws {
        let container = try ModelContainer(for: Contacts.self)
        let context = container.mainContext
        let repository = SwiftDataContactsRepository(modelContext: context)

        let contact = Contacts(firstName: "Bob", lastName: "Jones", phoneNumber: "555-1234")
        repository.addContact(contact)

        let fetched = repository.fetchContacts()
        #expect(fetched.contains { $0.firstName == "Bob" && $0.lastName == "Jones" })
    }

    @Test
    func testViewModelFilteringLogic() {
        let contact1 = Contacts(firstName: "Alice", lastName: "Smith", phoneNumber: "1234")
        let contact2 = Contacts(firstName: "Bob", lastName: "Jones", phoneNumber: "5678")
        let repository = StaticRepository(contacts: [contact1, contact2])
        let viewModel = ContactsViewModel(repository: repository)

        viewModel.loadContacts()

        viewModel.searchText = "alice"
        let result1 = viewModel.filteredContacts()
        #expect(result1.count == 1 && result1[0].firstName == "Alice")

        viewModel.searchText = "5678"
        let result2 = viewModel.filteredContacts()
        #expect(result2.count == 1 && result2[0].phoneNumber == "5678")

        viewModel.searchText = "xyz"
        let result3 = viewModel.filteredContacts()
        #expect(result3.isEmpty)
    }
}


struct StaticRepository: ContactsRepository {
    let contacts: [Contacts]

    func fetchContacts() -> [Contacts] {
        contacts
    }

    func addContact(_ contact: Contacts) {
        // No-op for test
    }
}
