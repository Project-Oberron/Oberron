//
//  SettingsView.swift
//  Oberron
//
//  Created by Rayne on 18/08/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(NavigationService.self) var navService
    
    @State private var isVisible = false
    
    // State variables for the sliders
    @State private var narrationVolume: Double = 0.7
    @State private var soundVolume: Double = 0.4
    
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
                VStack(alignment: .leading, spacing: 40) {
                    
                    // MARK: - Audio Section
                    VStack(alignment: .leading, spacing: 24) {
                        // Section Header
                        HStack(alignment: .bottom) {
                            Text("Audio")
                                .font(.loraPrimary)
                                .foregroundStyle(.appPrimary)
                            
                            Spacer()
                            
                            Button {
                                // TODO: Play preview audio action
                            } label: {
                                (Text("Play ") + Text(Image(systemName: "play")))
                                    .underline()
                                    .font(.loraSecondary)
                                    .foregroundStyle(.appPrimary)
                            }
                        }
                        .staggeredEntrance(isVisible: isVisible)
                        
                        // Narration Control
                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                Image(systemName: "text.bubble")
                                    .font(.loraButton)
                                    .foregroundStyle(.appPrimary)
                                Text("Narration")
                                    .font(.loraFootnote)
                                    .italic()
                                    .foregroundStyle(.appSecondary)
                            }
                            .frame(width: 70) // Fixed width to align the sliders
                            
                            Slider(value: $narrationVolume)
                                .tint(.appPrimary)
                        }
                        .staggeredEntrance(isVisible: isVisible)
                        
                        // Sound Control
                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                Image(systemName: "speaker.wave.2")
                                    .font(.loraButton)
                                    .foregroundStyle(.appPrimary)
                                Text("Sound")
                                    .font(.loraFootnote)
                                    .italic()
                                    .foregroundStyle(.appSecondary)
                            }
                            .frame(width: 70)
                            
                            Slider(value: $soundVolume)
                                .tint(.appPrimary)
                        }
                        .staggeredEntrance(isVisible: isVisible)
                    }
                    
                    // MARK: - Experience Section
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Experience")
                            .font(.loraPrimary)
                            .foregroundStyle(.appPrimary)
                            .staggeredEntrance(isVisible: isVisible)
                        
                        // Settings Rows
                        ExperienceRow(title: "Font", value: "Lora", isVisible: isVisible)
                        ExperienceRow(title: "Session Duration", value: "6 Min", isVisible: isVisible)
                        ExperienceRow(title: "Theme", value: "Light", isVisible: isVisible)
                    }
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isVisible = true
        }
    }
}

// MARK: - Reusable Row Component
struct ExperienceRow: View {
    let title: String
    let value: String
    let isVisible: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.loraSecondary)
                .italic()
                .foregroundStyle(.appSecondary)
            
            Spacer()
            
            Menu {
                // TODO: Add actual picker options here
                Button("Option 1", action: {})
                Button("Option 2", action: {})
            } label: {
                (Text(value + " ") + Text(Image(systemName: "chevron.up.chevron.down")))
                    .underline()
                    .font(.loraSecondary)
                    .foregroundStyle(.appPrimary)
            }
        }
        .staggeredEntrance(isVisible: isVisible)
    }
}

#Preview {
    SettingsView()
        .environment(NavigationService())
}
