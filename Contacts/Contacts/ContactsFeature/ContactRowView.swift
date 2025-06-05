//
//  ContactRowView.swift
//  Contacts
//
//  Created by Kavya Krishna on 05/06/25.
//

import SwiftUI

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
