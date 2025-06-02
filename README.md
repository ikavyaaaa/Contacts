# Contacts


## The SwiftUI-based contacts app that uses the SOLID principles from object-oriented design very effectively. Here's a breakdown of how each SOLID principle applies:

✅ S — Single Responsibility Principle (SRP)
Each class or struct should have one and only one reason to change.
ContactsViewModel: Handles UI logic like fetching, filtering, and adding contacts.
Contacts: A simple data model that represents a contact.
ContactsRepository, DummyRepository, SwiftDataContactsRepository: Each encapsulates specific data-fetching logic.
UI Views like ContactRowView, AddContactView, ContactDetailView are only responsible for UI rendering, not business logic or data persistence.
📌 Conclusion: Classes are well-separated based on their responsibilities.

✅ O — Open/Closed Principle (OCP)
Software entities should be open for extension, but closed for modification.
ContactsRepository protocol makes it easy to add new data sources (like a remote API or CoreData) without modifying existing view model logic.
You can swap out DummyRepository or SwiftDataContactsRepository without changing the ContactsViewModel.
📌 Conclusion: Behavior can be extended (by implementing the protocol), without changing the client code.

✅ L — Liskov Substitution Principle (LSP)
Derived classes must be substitutable for their base classes.
DummyRepository and SwiftDataContactsRepository both conform to ContactsRepository. The ContactsViewModel relies on this protocol and can work seamlessly with either implementation.
📌 Conclusion: All subclasses/implementations are substitutable, satisfying LSP.

✅ I — Interface Segregation Principle (ISP)
Clients should not be forced to depend on methods they do not use.
ContactsRepository defines only two methods: fetchContacts() and addContact(). These are precisely what the ViewModel needs.
There are no unused methods bloating the interface.
📌 Conclusion: The protocol is minimal and specific to the consumer's needs.

✅ D — Dependency Inversion Principle (DIP)
Depend on abstractions, not on concretions.
ContactsViewModel depends on the ContactsRepository protocol, not a concrete implementation.
This enables easy unit testing by injecting mocks like DummyRepository.
📌 Conclusion: High-level modules (view model) depend on abstractions, not low-level data implementations.



Summary Table

Principle    Followed?    How
SRP             ✅       Separated concerns between UI, business
OCP             ✅       Easily extendable via protocols
LSP             ✅       ContactsRepository implementations are int
ISP             ✅       Protocol has only what is needed
DIP             ✅       ViewModel depends on abstraction
