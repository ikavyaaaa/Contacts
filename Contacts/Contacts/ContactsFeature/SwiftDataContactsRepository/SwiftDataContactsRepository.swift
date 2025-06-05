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

struct DummyRepository: ContactsRepository {
    func fetchContacts() -> [Contacts] { [] }
    func addContact(_ contact: Contacts) {}
}

import Foundation
import SwiftData

class SwiftDataContactsRepository: ContactsRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchContacts() -> [Contacts] {
        let descriptor = FetchDescriptor<Contacts>(
            sortBy: [SortDescriptor(\Contacts.firstName)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func addContact(_ contact: Contacts) {
        modelContext.insert(contact)
    }
}


class SeverContactsRepository: ContactsRepository {
    func fetchContacts() -> [Contacts] {
        //Call API to get
        []
    }
    
    func addContact(_ contact: Contacts) {
        //Call API to add
    }
}


class CombineContactsRepository: ContactsRepository {
    let isConnectedToInternet = false
    
    let swiftDataRepository: SwiftDataContactsRepository
    let severContactsRepository: SeverContactsRepository
    
    init(swiftDataRepository: SwiftDataContactsRepository, severContactsRepository: SeverContactsRepository) {
        self.swiftDataRepository = swiftDataRepository
        self.severContactsRepository = severContactsRepository
    }
    
    func fetchContacts() -> [Contacts] {
        let repo: ContactsRepository
        if isConnectedToInternet {
            repo = swiftDataRepository
        } else {
            repo = severContactsRepository
        }
        return repo.fetchContacts()
    }
    
    func addContact(_ contact: Contacts) {
        
    }
}
