//
//  AboutView.swift
//  Oberron
//
//  Created by Rayne on 17/08/26.
//

import SwiftUI

struct AboutView: View {
    @Environment(NavigationService.self) var navService
    
    @State private var isVisible = false
    
    var body: some View {
		ZStack(alignment: .topLeading) {
            // Scrollable Content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Session Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("What is an ATT Session?")
                            .font(.appPrimary)
                            .foregroundStyle(.appPrimary)
                            .staggeredEntrance(isVisible: isVisible)
                        
                        Text("The Attention Training Technique (ATT) is an auditory exercise developed as part of Metacognitive Therapy to help manage anxiety, rumination, and overthinking.")
                            .font(.appSecondary)
                            .foregroundStyle(.appSecondary)
                            .lineSpacing(4)
                            .staggeredEntrance(isVisible: isVisible)
                        
                        Text("A session involves actively listening to different sounds around you. By progressing through selective attention, rapid attention switching, and divided attention, you train your brain to regain control over its focus. Over time, this makes it easier to shift your attention away from unhelpful thoughts and internal distress.")
                            .font(.appSecondary)
                            .foregroundStyle(.appSecondary)
                            .lineSpacing(4)
                            .staggeredEntrance(isVisible: isVisible)
						
						Text("Disclaimer: Oberron is an attention-training tool and is not a substitute for professional mental health diagnosis, therapy, or medical advice.")
							.font(.appSecondary)
							.foregroundStyle(.appSecondary)
							.italic()
							.lineSpacing(4)
							.staggeredEntrance(isVisible: isVisible)
                    }
                    
                    // Shortcuts Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Shortcuts")
                            .foregroundStyle(.appPrimary)
                            .staggeredEntrance(isVisible: isVisible)
                            .font(.appPrimary)
                        
                        DisclosureGroup {
                            Text("Long-press on your Home Screen or Lock Screen until the icons jiggle. Tap the edit button in the top left corner, tap on add widgets, search for Oberron, and tap add widget.")
                                .font(.appSecondary)
                                .foregroundStyle(.appSecondary)
                                .lineSpacing(4)
                                .padding(.vertical, 8)
                        } label: {
                            Text("Widgets")
                                .font(.appSecondary)
                        }
                        .tint(.appPrimary)
                        .foregroundStyle(.appPrimary)
                        .staggeredEntrance(isVisible: isVisible)
                        
                        DisclosureGroup {
                            Text("Open the device Settings app and navigate to 'Action Button'. Swipe to the 'Shortcut' option, tap 'Choose a Shortcut', and select Oberron, then start session.")
                                .font(.appSecondary)
                                .foregroundStyle(.appSecondary)
                                .lineSpacing(4)
                                .padding(.vertical, 8)
                        } label: {
                            Text("Action Button")
                                .font(.appSecondary)
                        }
                        .tint(.appPrimary)
                        .foregroundStyle(.appPrimary)
                        .staggeredEntrance(isVisible: isVisible)
                        
                        DisclosureGroup {
                            Text("Our app integrates directly with App Shortcuts. Simply say 'Hey Siri' followed with: 'start a session in Oberron'. You can view or customize all available voice phrases inside the system Shortcuts app.")
                                .font(.appSecondary)
                                .foregroundStyle(.appSecondary)
                                .lineSpacing(4)
                                .padding(.vertical, 8)
                        } label: {
                            Text("Siri")
                                .font(.appSecondary)
                        }
                        .tint(.appPrimary)
                        .foregroundStyle(.appPrimary)
                        .staggeredEntrance(isVisible: isVisible)
                        
                        DisclosureGroup {
                            Text("Swipe down from the top right to open Control Center. Long-press on an empty space to enter edit mode, tap 'Add a Control', search for Oberron, and drop the shortcut control into your layout.")
                                .font(.appSecondary)
                                .foregroundStyle(.appSecondary)
                                .lineSpacing(4)
                                .padding(.vertical, 8)
                        } label: {
							Text("Control Center (iOS 18+)")
								.font(.appSecondary)
                        }
                        .tint(.appPrimary)
                        .foregroundStyle(.appPrimary)
                        .staggeredEntrance(isVisible: isVisible)
                    }
                    .padding(.top, 16)
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
    }
	
	private func exitAndNavigate(to route: NavRoute) {
		isVisible = false
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			navService.navigate(to: route)
		}
	}
}

#Preview {
    AboutView()
        .environment(NavigationService())
}
