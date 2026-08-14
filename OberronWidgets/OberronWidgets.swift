import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
	func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date())
	}
	
	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
		completion(SimpleEntry(date: Date()))
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
		let timeline = Timeline(entries: [SimpleEntry(date: Date())], policy: .never)
		completion(timeline)
	}
}

struct SimpleEntry: TimelineEntry {
	let date: Date
}

struct OberronWidgetsEntryView : View {
	var entry: Provider.Entry
	
	// TODO: Widget UI
	// Can also do all widget variants if needed...
	var body: some View {
		Button(intent: StartSessionIntent()) {
			CircleWaveView()
		}
	}
}

struct OberronWidgets: Widget {
	let kind: String = "OberronWidgets"
	
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			OberronWidgetsEntryView(entry: entry)
				.containerBackground(.background, for: .widget)
		}
		// TODO: Change following others
		.configurationDisplayName("Start Session")
		.description("Quickly start an Oberron session.")
		.supportedFamilies([.systemSmall])
	}
}

#Preview(as: .systemSmall) {
	OberronWidgets()
} timeline: {
	SimpleEntry(date: .now)
}
