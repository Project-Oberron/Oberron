//
//  AboutVuew.swift
//  Oberron
//
//  Created by Rayne on 17/08/26.
//

import SwiftUI

struct AboutView: View {
    @Environment(NavigationService.self) var navService
    
    @State private var isVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Button {
                    navService.navigate(to: .home)
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.appPrimary)
                        .font(.loraPrimary)
                }
                .buttonStyle(.bounce) 
                .staggeredEntrance(isVisible: isVisible)
                
                Spacer()
            }
            .padding(.bottom, 32)
            
            // Scrollable Content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Session Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Session")
                            .font(.loraPrimary)
                            .foregroundStyle(.appPrimary)
                            .staggeredEntrance(isVisible: isVisible)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In congue nulla et sapien efficitur tempus. Praesent eleifend elit eu eros pharetra, quis tristique sem aliquam. In mattis commodo tortor, id luctus mi dictum ac.")
                            .font(.loraSecondary)
                            .italic()
                            .foregroundStyle(.appSecondary)
                            .lineSpacing(4)
                            .staggeredEntrance(isVisible: isVisible)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In congue nulla et sapien efficitur tempus. Praesent eleifend elit eu eros pharetra, quis tristique sem aliquam. In mattis commodo tortor, id luctus mi dictum ac.")
                            .font(.loraSecondary)
                            .italic()
                            .foregroundStyle(.appSecondary)
                            .lineSpacing(4)
                            .staggeredEntrance(isVisible: isVisible)
                    }
                    
                    // Reading Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reading")
                            .foregroundStyle(.appPrimary)
                            .staggeredEntrance(isVisible: isVisible)
                            .font(.loraPrimary)
                    }
                    .padding(.top, 16)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Hides default back button if inside standard NavigationStack
        .onAppear {
            isVisible = true
        }
    }
}

#Preview {
    AboutView()
        .environment(NavigationService())
}
