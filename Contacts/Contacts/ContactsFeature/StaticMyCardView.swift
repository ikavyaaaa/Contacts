//
//  StaticMyCardView.swift
//  Contacts
//
//  Created by Kavya Krishna on 05/06/25.
//

import SwiftUI

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
