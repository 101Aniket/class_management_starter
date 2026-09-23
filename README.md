# Class Management System — Flutter Starter Foundation

A professional Flutter **starter foundation** for a future Class Management
System. This project is not the finished product — it deliberately contains
**no** Student/Teacher/Parent/Admin/payment/attendance business logic. Its
purpose is to establish everything *around* that future logic: UI
architecture, theming, navigation, reusable components, animation patterns,
loading states, and code organization, so real modules can be added later
without restructuring the app.

---

## 1. Project Overview

The app currently demonstrates, using only mock/local data:

- An animated splash screen with a simulated initialization sequence
- A Home dashboard with animated statistic cards and quick-action tiles
- A Search screen (recent searches, empty state, mock filtering)
- A Notifications feed (read/unread state)
- A Profile screen (demonstrates a confirmation dialog and a bottom sheet)
- A centralized light/dark theme system
- A full reusable component library (buttons, cards, loaders, skeletons,
  empty/error states, snackbars, dialogs, bottom sheets, search input,
  bottom navigation)
- Responsive layout (phone vs. tablet stat-grid columns)
- Basic accessibility (semantic labels, 48dp touch targets, reduced-motion
  awareness)

Everything is built with **Flutter's own SDK** — no state-management or
navigation packages were introduced (see "Why no extra packages?" below).

---

## 2. Architecture

```text
lib/
├── main.dart                  # Entry point; binds Flutter, runs App
├── app/
│   ├── app.dart                # Root MaterialApp: theme + initial route
│   ├── routes.dart             # Named route constants
│   └── theme/                  # Centralized design tokens
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart    # (also defines AppRadius)
│       └── app_theme.dart      # Builds ThemeData from the tokens above
│
├── core/
│   ├── constants/               # App-wide constant strings/values
│   ├── utils/                   # Small standalone helpers (e.g. Debouncer)
│   ├── extensions/               # BuildContext convenience extensions
│   └── services/                 # Simulated InitializationService
│
├── components/                   # Reusable, screen-agnostic widgets
│   ├── buttons/                  # Primary/Secondary/Outlined/Text/Icon
│   ├── cards/                    # AppCard + specialized cards built on it
│   ├── dialogs/                   # ConfirmDialog
│   ├── loaders/                    # Circular/Linear/Inline loaders
│   ├── skeletons/                   # Shimmer skeleton placeholders
│   ├── inputs/                       # AppSearchField
│   ├── navigation/                    # AppBottomNav
│   ├── feedback/                       # AppSnackBar, AppBottomSheet
│   └── common/                          # EmptyState, ErrorState
│
├── animations/                    # Reusable animation building blocks
│   ├── app_animations.dart         # Centralized durations/curves + reduced-motion helper
│   ├── animated_logo.dart
│   ├── fade_animation.dart
│   ├── scale_animation.dart
│   └── page_transition.dart        # Custom Navigator route transitions
│
├── screens/                        # Feature screens; compose components
│   ├── splash/
│   ├── home/                        # Also owns the bottom-nav shell (IndexedStack)
│   ├── search/
│   ├── notifications/
│   ├── profile/
│   └── settings/
│
└── models/                          # Plain data classes (no logic/network)
```

**Why this shape?** Each layer only depends on the layers "below" it:
`screens` depend on `components`, `animations`, `models`, and `core`, but
never the other way around. `components` never import from `screens`. This
means a future Student/Teacher/Parent module can be added as a new
`screens/student/` folder that reuses every existing button, card, loader,
and theme token — without those shared pieces needing to know the new
module exists.

---

## 3. How the Application Starts

```text
main.dart
   │  WidgetsFlutterBinding.ensureInitialized()
   ▼
App (MaterialApp: theme, routes, home: SplashScreen)
   ▼
SplashScreen
   │  AnimatedLogo (fade + scale + subtle rotation)
   │  InitializationService.run() — 4 simulated steps with a linear progress bar
   ▼
HomeScreen (pushReplacement, fade transition)
   │  IndexedStack: Home | Search | Notifications | Profile
   ▼
AppBottomNav switches the visible tab without losing the other tabs' state
```

The splash screen never jumps straight to Home — it always runs the
(currently simulated) initialization sequence first, exactly as a real app
with authentication/config loading would.

---

## 4. Components

| Component | File | Purpose |
|---|---|---|
| `PrimaryButton` / `SecondaryButton` / `AppOutlinedButton` / `AppTextButton` / `AppIconButton` | `components/buttons/app_buttons.dart` | Full button hierarchy with built-in disabled + loading states |
| `AppCard` | `components/cards/app_card.dart` | Base surface every card in the app is built from |
| `DashboardStatCard` | `components/cards/dashboard_stat_card.dart` | Stat card with an animated count-up number |
| `QuickActionCard` | `components/cards/quick_action_card.dart` | Placeholder tile for future business modules |
| `AppCircularLoader` / `AppLinearLoader` / `InlineLoader` | `components/loaders/app_loader.dart` | Full loading indicator system |
| `SkeletonBox` + shape presets | `components/skeletons/skeleton_widgets.dart` | Shimmering loading placeholders |
| `EmptyState` | `components/common/empty_state.dart` | "No data" placeholder, distinct in tone from an error |
| `ErrorState` | `components/common/error_state.dart` | "Something went wrong" placeholder with retry |
| `ConfirmDialog` | `components/dialogs/confirm_dialog.dart` | Reusable Yes/No confirmation dialog |
| `AppSnackBar` | `components/feedback/app_snackbar.dart` | `.success()` / `.error()` / `.info()` toast helpers |
| `AppBottomSheet` | `components/feedback/app_bottom_sheet.dart` | Reusable modal action-list sheet |
| `AppSearchField` | `components/inputs/app_search_field.dart` | Search input with a conditional clear button |
| `AppBottomNav` | `components/navigation/app_bottom_nav.dart` | Animated bottom navigation bar |

Every component takes plain, explicit constructor parameters (no hidden
global state), so each is usable and testable in isolation.

---

## 5. Animations

| Animation | Where | Mechanism |
|---|---|---|
| Logo entrance | `animations/animated_logo.dart` | One `AnimationController` driving fade + scale + rotation together |
| Screen/card entrance | `animations/fade_animation.dart`, `scale_animation.dart` | Reusable wrapper widgets, each with its own controller and optional stagger delay |
| Page transitions | `animations/page_transition.dart` | `PageRouteBuilder` variants: slide+fade, cross-fade, scale+fade |
| Loading skeleton | `components/skeletons/skeleton_widgets.dart` | Repeating `AnimationController` driving a `ShaderMask` gradient sweep |
| Dashboard counters | `components/cards/dashboard_stat_card.dart` | `TweenAnimationBuilder` (no controller needed for a single one-shot value) |
| Bottom-nav tab feel | `components/navigation/app_bottom_nav.dart` | Implicit animations (`AnimatedScale`, `AnimatedDefaultTextStyle`) |

All non-essential animation durations are wrapped through
`AppAnimations.effectiveDuration()`, which collapses to `Duration.zero` when
the platform's "reduce motion" accessibility setting is on.

---

## 6. Running the Project

```bash
flutter pub get
flutter run
```

The first time you open this project, Flutter needs its platform folders
(`android/`, `ios/`, `web/`, etc.), which are intentionally **not** committed
to this starter (they're environment-generated boilerplate, not hand-written
source). Generate them once with:

```bash
flutter create .
```

This fills in only the missing platform folders — it will not overwrite your
existing `lib/` or `pubspec.yaml`.

---

## 7. Building Android

```bash
flutter create . --platforms=android   # once, if android/ doesn't exist yet
flutter build apk --release
```

The output APK is written to `build/app/outputs/flutter-apk/app-release.apk`.
For a distributable app bundle instead: `flutter build appbundle --release`.

## 8. Building iOS

```bash
flutter create . --platforms=ios       # once, if ios/ doesn't exist yet
flutter build ios --release
```

**iOS builds require macOS with Xcode installed** — Apple's toolchain does
not run on Windows or Linux. You will also need an Apple Developer account
and a provisioning profile/signing certificate configured in Xcode before
you can install the build on a physical device or submit to TestFlight/the
App Store. `flutter build ios --release --no-codesign` (used in this
project's CI workflow) skips signing entirely, which is enough to verify the
app compiles for iOS but not enough to run it on a device.

## 9. Continuous Integration

`.github/workflows/build.yml` runs automatically on every push/PR to `main`
(and can be triggered manually):

1. **Analyze & Test** — `dart format`, `flutter analyze`, `flutter test`.
2. **Build Android** — generates the Android platform folder if missing,
   then builds a release APK and uploads it as a workflow artifact.
3. **Build Web** — same pattern, builds a release web bundle.
4. **Build iOS** (macOS runner) — builds an unsigned release iOS binary to
   confirm iOS compilation succeeds.

The Android/Web/iOS jobs only run after the analyze/test job passes.

---

## 10. Future Expansion

This foundation is built so the following can be added as new, self-contained
modules under `screens/`, reusing every existing component/theme/animation:

```text
Student Module      Teacher Module      Parent Module
Admin Module         Super Admin Module
Attendance   Homework   Notes   Results   Progress
Meetings     Notifications      Payments  Reports
```

Suggested extension points already prepared for this:
- `QuickActionCard` taps currently show "Coming Soon" — swap in real
  navigation per action once each module exists.
- `AppRoutes` currently has one route; add named routes here as new
  top-level flows (e.g. authentication) are introduced.
- State management: nothing beyond `StatefulWidget`/local state is used yet.
  If a future module needs state shared across many unrelated widgets
  (e.g. the logged-in user, a live unread-notification count), introducing
  Provider/Riverpod at that point is reasonable — see the note in
  `pubspec.yaml` for the reasoning on when that becomes justified.
- `InitializationService` is where real startup work (auth check, cached
  data, API client setup) replaces the current simulated delays.

---

## 11. Why No Extra Third-Party Packages?

Every animation, loading state, and layout in this project uses Flutter's
built-in `AnimationController`, `TweenAnimationBuilder`, `ShaderMask`,
`MediaQuery`, and `StatefulWidget`/`ValueNotifier` — no `provider`, `riverpod`,
`bloc`, `go_router`, or shimmer package was added. For a foundation project,
every dependency is a future upgrade/maintenance cost inherited by whatever
gets built on top of it; none of these were yet *necessary* to demonstrate
the required UI/architecture. When a real need arises (e.g. cross-cutting
shared state, or complex nested routing with deep links), the recommendation
in this codebase's comments is to introduce that package deliberately, with
the three questions from the project brief answered explicitly in code
comments: why it's needed, what problem it solves, and why it's better than
the simpler Flutter-only approach for that specific case.
