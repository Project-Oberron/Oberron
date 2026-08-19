# Oberron

An exploration into designing a low-friction digital mental health experience for interrupting rumination and anxiety through guided attention training. The project investigates the gap between self-awareness and self-regulation: why individuals recognize they are struggling yet remain stuck in cycles of rumination, avoidance, or anxious thinking.

Through psychological research, Human-Computer Interaction (HCI) research, existing product analysis, and interviews with mental health practitioners, Oberron translates evidence-based self-regulation techniques into an accessible mobile experience. The current direction focuses on an audio-first implementation of the Attention Training Technique (ATT), allowing users to follow guided auditory instructions with minimal screen interaction. It serves as a structured self-regulation aid to help users redirect attention and regain intentional mental space.

---

## Architectural Principles

### 1. View-State Management & MVVM
* **Simple Views (View-Only):** For static, presentational, or purely visual components (e.g., `AboutView`, `SettingsView`, `HomeView`), use native SwiftUI view state (`@State`, `@Binding`, `@Environment`). Avoid boilerplate ViewModels for screens that only display layout or forward simple button actions.
* **Complex Views (MVVM):** When a feature requires asynchronous tasks, timer cycles, state machine transitions, audio synchronization, or input parsing (e.g., `ATTView` with `ATTViewModel`, `ReflectionView` with `ReflectionViewModel`), decouple state into a dedicated `ObservableObject` / `@Observable` ViewModel.
* **Responsibilities:**
  * **View:** UI declaration, animation triggers, layout modifiers, and binding to ViewModel properties.
  * **ViewModel:** Presentation state, interaction logic, coordination with Services, and formatting data for the View.

### 2. Core Services Layer
* Cross-cutting hardware and application capabilities live in `Oberron/Core/Services/`.
* **Decoupling System APIs:** Do not call low-level APIs (such as `AVFoundation` or navigation stacks) directly inside views. Inject or access services such as:
  * `AudioService`: Manages audio playback, layering, spatial cues, and audio sessions.
  * `NavigationService`: Centralizes app routing, path handling, and programmatic transitions via `NavRoute`.

### 3. Modularity & Shared UI
* Reusable animations, visual wave renderers, and custom controls live in `Oberron/UI/Shared/`.
* Domain contracts and shared route definitions live in `Oberron/Data/Domain/` to keep models decoupled from UI rendering logic.

---

## Project Structure

```text
Oberron/
├── Oberron.xcodeproj/              # Xcode project configuration and schemes
├── Oberron/                        # Main iOS App Target
│   ├── OberronApp.swift            # Application entry point (@main)
│   ├── Info.plist                  # Target configuration and audio background permissions
│   ├── Assets.xcassets/            # App icons, semantic colors, and custom gradients
│   │   ├── Colors/                 # Background, primary, secondary, surface colors
│   │   └── Gradients/              # AppGradient 1-4 definitions
│   │
│   ├── Core/                       # Foundation layer and shared services
│   │   ├── Extensions/             # SwiftUI style and component extensions
│   │   │   ├── ButtonStyleExtension.swift
│   │   │   ├── FontExtension.swift
│   │   │   └── ViewExtension.swift
│   │   ├── Services/               # Core business & system-level services
│   │   │   ├── AudioService.swift  # AVFoundation audio player & narration manager
│   │   │   └── NavigationService.swift # Navigation stack and routing controller
│   │   └── Utilities/              # Global helpers and system utilities
│   │
│   ├── Data/                       # Data entities and business domain definitions
│   │   ├── Domain/                 # Navigation routes and domain items
│   │   │   ├── AudioItem.swift     # Audio track domain model
│   │   │   └── NavRoute.swift      # Application route definitions
│   │   └── Models/                 # Persistent storage entities and schemas
│   │
│   ├── External/                   # System integrations, lifecycle, and shortcuts
│   │   ├── AppDelegate.swift       # UIApplicationDelegate adapters
│   │   ├── SceneDelegate.swift     # UIWindowScene management
│   │   ├── OberronShortcuts.swift  # App Shortcuts Provider
│   │   └── StartSessionIntent.swift# App Intent for quick session launch
│   │
│   └── UI/                         # UI layer (SwiftUI Views & ViewModels)
│       ├── ContentView.swift       # Root content router
│       ├── Features/               # Feature-based presentation modules
│       │   ├── ATT/                # Attention Training Technique session
│       │   │   ├── ATTView.swift
│       │   │   └── ATTViewModel.swift
│       │   ├── About/              # Project background and research info
│       │   │   └── AboutView.swift
│       │   ├── Home/               # Main dashboard / landing screen
│       │   │   └── HomeView.swift
│       │   ├── Reflection/         # Post-session check-in and reflection
│       │   │   ├── ReflectionView.swift
│       │   │   └── ReflectionViewModel.swift
│       │   └── Settings/           # App preferences and configurations
│       │       └── SettingsView.swift
│       └── Shared/                 # Reusable components and visual canvas effects
│           ├── CircleWaveView.swift
│           ├── TextButtonView.swift
│           ├── Wave.swift
│           └── WaveView.swift
│
├── OberronWidgets/                 # WidgetKit Target
│   ├── OberronWidgets.swift        # Widget layout and timeline provider
│   ├── OberronWidgetsBundle.swift  # Widget bundle declaration
│   ├── OberronWidgetsControl.swift # Control Center widget configurations
│   ├── AppIntent.swift             # Interactive widget intents
│   └── Assets.xcassets/            # Widget-specific color/asset catalog
│
└── Resources/                      # Static binary bundled assets
    ├── Audio/                      # Audio source files
    │   ├── Narration/              # Voice instructions (start, rapid switch, sample)
    │   └── Sound/                  # Ambient layers and auditory stimuli
    └── Font/                       # Custom typography (Lora, Lora-Italic)

```

## Code & Formatting Conventions

* **Asset & Color Tokens:** Reference colors and gradients exclusively through semantic asset definitions (`Color("AppPrimary")`, `Color("AppBackground")`) or extensions located in `Core/Extensions/`.
* **Typography:** Use custom font modifiers via `FontExtension.swift` (wrapping bundled Lora fonts) to preserve typographic hierarchy across different dynamic type sizes.
* **Separation of Concerns:**
  * Keep Views declarative: avoid multi-line algorithmic logic inside `body`.
  * Break complex views into smaller private sub-views or extracted files in `UI/Shared/`.
* **Naming Standards:**
  * Views: `[Feature]View.swift`
  * ViewModels: `[Feature]ViewModel.swift`
  * Shared UI components: `[Component]View.swift`
  * Extensions: `[ExtendedType]Extension.swift`

