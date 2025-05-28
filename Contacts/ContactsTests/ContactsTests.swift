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
    @Test func testCreateContact() {
        let contact = Contacts(firstName: "Alice", lastName: "Smith", phoneNumber: "1234567890")
        #expect(contact.firstName == "Alice")
        #expect(contact.lastName == "Smith")
        #expect(contact.phoneNumber == "1234567890")
    }

    @MainActor @Test func testInsertContactIntoModelContext() throws {
        let container = try ModelContainer(for: Contacts.self)
        let context = container.mainContext

        let newContact = Contacts(firstName: "Bob", lastName: "Jones", phoneNumber: "555-1234")
        context.insert(newContact)

        let contacts = try context.fetch(FetchDescriptor<Contacts>())
        #expect(contacts.contains { $0.firstName == "Bob" && $0.lastName == "Jones" })
    }

    @Test func testSaveButtonDisabledLogic() {
        let viewModel = AddContactViewModel()
        
        #expect(viewModel.isSaveDisabled)

        viewModel.firstName = "Jane"
        #expect(viewModel.isSaveDisabled)

        viewModel.lastName = "Doe"
        #expect(viewModel.isSaveDisabled)

        viewModel.phoneNumber = "444-5555"
        #expect(!viewModel.isSaveDisabled)
    }
}

@Observable
class AddContactViewModel {
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""

    var isSaveDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty
    }
}
