//
//  SwiftDataContactsRepository.swift
//  Contacts
//
//  Created by Kavya Krishna on 02/06/25.
//

protocol ContactsRepository {
    func fetchContacts() -> [Contacts]
    func addContact(_ contact: Contacts)
}

import SwiftData

class SwiftDataContactsRepository: ContactsRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchContacts() -> [Contacts] {
        let descriptor = FetchDescriptor<Contacts>(sortBy: [SortDescriptor(\.firstName)])
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func addContact(_ contact: Contacts) {
        modelContext.insert(contact)
    }
}
