//
//  SettingsView.swift
//  Oberron
//
//  Created by Rayne on 18/08/26.
//

import SwiftUI

struct SettingsView: View {
	@Environment(NavigationService.self) var navService
	
	@State private var viewModel = SettingsViewModel()
	@State private var isVisible = false
	@Bindable private var preferences = PreferenceService.shared
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			// Custom Navigation Bar
			HStack {
				Button {
					viewModel.stopPreview()
					navService.navigate(to: .home)
				} label: {
					Image(systemName: "arrow.left")
						.foregroundStyle(.appPrimary)
						.font(.appPrimary)
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
								.font(.appPrimary)
								.foregroundStyle(.appPrimary)
							
							Spacer()
							
							Button {
								viewModel.togglePreview()
							} label: {
								Text(
									viewModel.isPlaying
									? "Stop \(Image(systemName: "stop"))"
									: "Play \(Image(systemName: "play"))"
								)
								.underline()
								.font(.appSecondary)
								.foregroundStyle(.appPrimary)
							}
						}
						.staggeredEntrance(isVisible: isVisible)
						
						// Narration Control
						HStack(spacing: 20) {
							VStack(spacing: 8) {
								Image(systemName: "text.bubble")
									.font(.appButton)
									.foregroundStyle(.appPrimary)
								Text("Narration")
									.font(.appFootnote)
									.italic()
									.foregroundStyle(.appSecondary)
							}
							.frame(width: 70)
							
							Slider(value: $preferences.narrationVolume)
								.tint(.appPrimary)
						}
						.staggeredEntrance(isVisible: isVisible)
						
						// Sound Control
						HStack(spacing: 20) {
							VStack(spacing: 8) {
								Image(systemName: "speaker.wave.2")
									.font(.appButton)
									.foregroundStyle(.appPrimary)
								Text("Sound")
									.font(.appFootnote)
									.italic()
									.foregroundStyle(.appSecondary)
							}
							.frame(width: 70)
							
							Slider(value: $preferences.soundVolume)
								.tint(.appPrimary)
						}
						.staggeredEntrance(isVisible: isVisible)
					}
					
					// MARK: - Experience Section
					VStack(alignment: .leading, spacing: 24) {
						Text("Experience")
							.font(.appPrimary)
							.foregroundStyle(.appPrimary)
							.staggeredEntrance(isVisible: isVisible)
						
						ExperienceRow(
							title: "Font",
							selection: $preferences.selectedFont,
							isVisible: isVisible
						)
						
						ExperienceRow(
							title: "Session Duration",
							selection: $preferences.sessionDuration,
							isVisible: isVisible
						)
						
						ExperienceRow(
							title: "Theme",
							selection: $preferences.selectedTheme,
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
		.onDisappear {
			viewModel.stopPreview()
		}
		.onChange(of: preferences.narrationVolume) { _, newVolume in
			viewModel.updateNarrationVolume(newVolume)
		}
		.onChange(of: preferences.soundVolume) { _, newVolume in
			viewModel.updateSoundVolume(newVolume)
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
				.font(.appSecondary)
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
					.font(.appSecondary)
					.foregroundStyle(.appPrimary)
			}
			.id(selection)
		}
		.staggeredEntrance(isVisible: isVisible)
	}
}

#Preview {
	SettingsView()
		.environment(NavigationService())
}
