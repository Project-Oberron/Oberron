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
	@Bindable private var preference = PreferenceService.shared
    
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
								Text("Play \(Image(systemName: "play"))")
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
                            
							Slider(value: $preference.narrationVolume)
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
                            
                            Slider(value: $preference.soundVolume)
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
						ExperienceRow(
							title: "Font",
							selection: $preference.selectedFont,
							isVisible: isVisible
						)
						
						ExperienceRow(
							title: "Session Duration",
							selection: $preference.sessionDuration,
							isVisible: isVisible
						)
						
						ExperienceRow(
							title: "Theme",
							selection: $preference.selectedTheme,
							isVisible: isVisible
						)
                    }
                }
            }
        }
        .padding(20)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isVisible = true
        }
    }
}

// MARK: - Reusable Row Component
struct ExperienceRow<T>: View where T: CaseIterable & Identifiable & RawRepresentable & Hashable, T.RawValue == String, T.AllCases: RandomAccessCollection {
	let title: String
	@Binding var selection: T
	let isVisible: Bool
	
	var body: some View {
		HStack {
			Text(title)
				.font(.loraSecondary)
				.italic()
				.foregroundStyle(.appSecondary)
			
			Spacer()
			
			Menu {
				Picker(title, selection: $selection) {
					ForEach(T.allCases) { option in
						Text(option.rawValue)
							.tag(option)
					}
				}
			} label: {
				Text("\(selection.rawValue) \(Image(systemName: "chevron.up.chevron.down"))")
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
