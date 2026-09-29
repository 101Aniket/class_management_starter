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
- A Home dashboard with animated statistic cards, a time-zone-aware
  greeting, and quick-action tiles
- A Search screen (recent searches, empty state, mock filtering)
- A Notifications feed (read/unread state)
- A Profile screen (demonstrates a confirmation dialog and a bottom sheet)
- A finished Settings screen: theme (light/dark/system), language, and
  time zone, each persisted across restarts
- A Help & Support screen: FAQs and copyable contact details
- Full English/Hindi localization of every interface string, switchable
  instantly from Settings
- A centralized light/dark theme system
- A full reusable component library (buttons, cards, menu tiles, loaders,
  skeletons, empty/error states, snackbars, dialogs, bottom sheets/option
  pickers, search input, bottom navigation)
- Responsive layout (phone vs. tablet grid columns)
- Basic accessibility (semantic labels, 48dp touch targets, reduced-motion
  awareness, scripts that don't rely on Latin-only letter spacing)

Everything is built with **Flutter's own SDK** — no state-management or
navigation packages were introduced (see "Why no extra packages?" below).

---

## 2. Architecture

```text
lib/
├── main.dart                  # Entry point; loads settings, then runs App
├── app/
│   ├── app.dart                 # Root MaterialApp: theme + locale + initial route
│   ├── routes.dart               # Named route constants (for future flows)
│   └── theme/                     # Centralized design tokens
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart        # (also defines AppRadius)
│       └── app_theme.dart          # Builds ThemeData from the tokens above
│
├── core/
│   ├── constants/                   # Non-translated app-wide constants
│   ├── extensions/                    # BuildContext convenience extensions
│   ├── localization/                    # AppStrings (en/hi) + AppLanguage
│   ├── services/                          # InitializationService, TimeZoneService
│   ├── settings/                            # SettingsController/Storage/Scope
│   └── utils/                                 # GreetingPeriod
│
├── components/                       # Reusable, screen-agnostic widgets
│   ├── buttons/                        # Primary/Secondary/Outlined/Text/Icon
│   ├── cards/                           # AppCard, AppMenuTile + specialized cards
│   ├── dialogs/                           # ConfirmDialog
│   ├── loaders/                             # Circular/Linear/Inline loaders
│   ├── skeletons/                             # Shimmer skeleton placeholders
│   ├── inputs/                                  # AppSearchField
│   ├── navigation/                                # AppBottomNav
│   ├── feedback/                                    # AppSnackBar, AppBottomSheet
│   └── common/                                        # EmptyState, ErrorState, SectionHeader
│
├── animations/                        # Reusable animation building blocks
│   ├── app_animations.dart              # Durations/curves + reduced-motion helper
│   ├── animated_logo.dart
│   ├── fade_animation.dart
│   ├── scale_animation.dart
│   └── page_transition.dart               # Custom Navigator route transitions
│
├── screens/                            # Feature screens; compose components
│   ├── splash/
│   ├── home/                             # Also owns the bottom-nav shell (IndexedStack)
│   ├── search/
│   ├── notifications/
│   ├── profile/
│   ├── settings/                           # Theme, language, time zone
│   └── help/                                 # FAQs + contact details
│
└── models/                              # Plain data classes (no logic/network)
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
   │  SettingsController.load() — reads saved theme/language/time zone
   ▼
App (MaterialApp: theme, locale, home: SplashScreen)
   ▼
SplashScreen
   │  AnimatedLogo (fade + scale + subtle rotation)
   │  InitializationService.run() — 4 simulated phases with a linear progress bar
   ▼
HomeScreen (pushReplacement, fade transition)
   │  IndexedStack: Home | Search | Notifications | Profile
   ▼
AppBottomNav switches the visible tab without losing the other tabs' state
```

Settings are loaded **before** `runApp`, so the very first frame already
shows the user's chosen theme and language — nothing flashes and switches
a moment later.

The splash screen never jumps straight to Home — it always runs the
(currently simulated) initialization sequence first, exactly as a real app
with authentication/config loading would.

---

## 4. Components

| Component | File | Purpose |
|---|---|---|
| `PrimaryButton` / `SecondaryButton` / `AppOutlinedButton` / `AppTextButton` / `AppIconButton` | `components/buttons/app_buttons.dart` | Full button hierarchy with built-in disabled + loading states |
| `AppCard` | `components/cards/app_card.dart` | Base surface every card in the app is built from |
| `AppMenuTile` | `components/cards/app_menu_tile.dart` | Tappable icon + label (+ optional value) row; the base of every Profile/Settings/Help row |
| `DashboardStatCard` | `components/cards/dashboard_stat_card.dart` | Stat card with an animated count-up number |
| `QuickActionCard` | `components/cards/quick_action_card.dart` | Placeholder tile for future business modules |
| `AppCircularLoader` / `AppLinearLoader` / `InlineLoader` | `components/loaders/app_loader.dart` | Full loading indicator system |
| `SkeletonBox` + shape presets | `components/skeletons/skeleton_widgets.dart` | Shimmering loading placeholders |
| `EmptyState` | `components/common/empty_state.dart` | "No data" placeholder, distinct in tone from an error |
| `ErrorState` | `components/common/error_state.dart` | "Something went wrong" placeholder with retry |
| `SectionHeader` | `components/common/section_header.dart` | Small heading that groups rows (Settings, Help) |
| `ConfirmDialog` | `components/dialogs/confirm_dialog.dart` | Reusable Yes/No confirmation dialog |
| `AppSnackBar` | `components/feedback/app_snackbar.dart` | `.success()` / `.error()` / `.info()` toast helpers |
| `AppBottomSheet` | `components/feedback/app_bottom_sheet.dart` | `.showActions()` (action list) and `.showOptions()` (single-choice picker, used by theme/language/time zone) |
| `AppSearchField` | `components/inputs/app_search_field.dart` | Search input with a conditional clear button |
| `AppBottomNav` | `components/navigation/app_bottom_nav.dart` | Animated bottom navigation bar |

Every component takes plain, explicit constructor parameters (no hidden
global state), so each is usable and testable in isolation.

---

## 4a. Settings, Language & Help

**Settings** (`screens/settings/settings_screen.dart`) lets the user choose:
- **Theme** — Light / Dark / System (`ThemeMode`)
- **Language** — English or Hindi (`AppLanguage`), switching every string
  in the app immediately
- **Time zone** — a curated list of IANA zones, or "Device default"

All three are held in `SettingsController` (a `ChangeNotifier`) and
persisted with `shared_preferences` through `SettingsStorage`. The
controller is exposed to the whole widget tree via `SettingsScope`, an
`InheritedNotifier` — any widget that reads `context.settings` or
`context.strings` is rebuilt automatically the moment a setting changes,
which is what makes the theme/language/greeting update everywhere at once
with no manual `setState` plumbing.

**Adding a language:** create an `AppStrings` subclass (the abstract base
class means the compiler lists every string you still need to translate),
add one value to the `AppLanguage` enum, and — if it needs a script Flutter
doesn't ship translations for yet — check
`GlobalMaterialLocalizations.supportedLanguages`.

**Help & Support** (`screens/help/help_support_screen.dart`) shows a set of
FAQs (expandable, from `AppStrings.faqs`) and two contact options that copy
to the clipboard on tap. Opening the phone/mail app directly would need the
`url_launcher` package; copying works with only the Flutter SDK, which was
enough for this foundation.

**The dynamic greeting:** `screens/home/dashboard_header.dart` reads the
current hour in the selected time zone via `TimeZoneService.nowIn()`, maps
it to a `GreetingPeriod` (morning/afternoon/evening/night), and looks up
the wording for that period and language from `AppStrings.greeting()`. It
refreshes on a one-minute timer and rebuilds instantly if the time zone or
language changes, so it's never a hardcoded "Good Morning".

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

## 11. Third-Party Packages Used, and Why

Every animation, loading state, and layout in this project uses Flutter's
built-in `AnimationController`, `TweenAnimationBuilder`, `ShaderMask`,
`MediaQuery`, and `ChangeNotifier`/`InheritedNotifier` for the one piece of
cross-cutting shared state (`SettingsController`) — no `provider`,
`riverpod`, `bloc`, `go_router`, or shimmer package was added.

Three packages **were** added, each because a Flutter-only alternative
either doesn't exist or is clearly worse for the job (see the comment block
at the top of `pubspec.yaml` for the same explanation in context):

| Package | Why it's needed | Could Flutter's SDK do it alone? |
|---|---|---|
| `flutter_localizations` (part of the Flutter SDK) | Flutter's own widgets (date pickers, tooltips, the back-button label) need translations for whichever locale is active | This **is** the built-in mechanism — the app's own text still lives in `core/localization`, not `.arb` files, so no code generation is needed |
| `shared_preferences` | Theme, language, and time zone must survive an app restart | No — `dart:io` file APIs need a platform-specific directory path (itself only available via a plugin) and don't work on web at all |
| `timezone` | The greeting follows a *chosen* time zone, not just the device's | No — `DateTime` only knows UTC and the device's own zone; this package bundles the IANA database so daylight-saving transitions stay correct automatically, which hand-rolled fixed UTC offsets cannot do |

For anything beyond this — e.g. complex nested routing with deep links —
the recommendation in this codebase's comments is still to introduce a
package deliberately, answering the same three questions in code comments:
why it's needed, what problem it solves, and why it's better than the
simpler Flutter-only approach for that specific case.
