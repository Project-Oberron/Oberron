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
		ZStack(alignment: .topLeading) {
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
									viewModel.isPlaying ? "Stop \(Image(systemName: "stop"))" : "Play \(Image(systemName: "play"))"
								)
								.underline()
								.font(.appSecondary)
								.foregroundStyle(.appPrimary)
								.staggeredEntrance(isVisible: isVisible)
							}
							.accessibilityLabel(viewModel.isPlaying ? "Stop audio preview" : "Play audio preview")
							.accessibilityHint("Plays sample narration and ambient sounds")
							.accessibilityInputLabels([viewModel.isPlaying ? "Stop preview" : "Play preview", "Preview"])
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
									.frame(width: 70)
							}
							.accessibilityHidden(true)
							
							Slider(value: $preferences.narrationVolume, in: 0...1)
								.tint(.appPrimary)
								.accessibilityLabel("Narration Volume")
								.accessibilityValue("\(Int(preferences.narrationVolume * 100))%")
								.accessibilityInputLabels(["Narration volume", "Narration"])
								.accessibilityAdjustableAction { direction in
									switch direction {
									case .increment:
										preferences.narrationVolume = min(preferences.narrationVolume + 0.05, 1.0)
									case .decrement:
										preferences.narrationVolume = max(preferences.narrationVolume - 0.05, 0.0)
									@unknown default:
										break
									}
								}
						}
						.staggeredEntrance(isVisible: isVisible)
						
						// Sound Control (Scaled for 0...0.2 range)
						HStack(spacing: 20) {
							VStack(spacing: 8) {
								Image(systemName: "speaker.wave.2")
									.font(.appButton)
									.foregroundStyle(.appPrimary)
								Text("Sound")
									.font(.appFootnote)
									.italic()
									.foregroundStyle(.appSecondary)
									.frame(width: 70)
							}
							.accessibilityHidden(true)
							
							Slider(value: $preferences.soundVolume, in: 0...0.2)
								.tint(.appPrimary)
								.accessibilityLabel("Sound Volume")
								.accessibilityValue("\(Int((preferences.soundVolume / 0.2) * 100))%")
								.accessibilityInputLabels(["Sound volume", "Background sound", "Sound"])
								.accessibilityAdjustableAction { direction in
									switch direction {
									case .increment:
										preferences.soundVolume = min(preferences.soundVolume + 0.02, 0.2)
									case .decrement:
										preferences.soundVolume = max(preferences.soundVolume - 0.02, 0.0)
									@unknown default:
										break
									}
								}
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
				.padding(20)
				.padding(.top, 56)
			}
			
			CustomNavBar(isVisible: isVisible) {
				exitAndNavigate(to: .home)
			}
			.padding(20)
		}
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
	
	private func exitAndNavigate(to route: NavRoute) {
		isVisible = false
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			navService.navigate(to: route)
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
			.accessibilityLabel(title)
			.accessibilityValue(selection.rawValue)
			.accessibilityHint("Double-tap to select \(title.lowercased())")
			.accessibilityInputLabels([title, "\(title) options"])
		}
		.staggeredEntrance(isVisible: isVisible)
	}
}

#Preview {
	SettingsView()
		.environment(NavigationService())
}
