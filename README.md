# 📚 Bookly

A Flutter book-discovery app built on the **Google Books API**. Browse featured and newest programming books, open a details page, and search the catalogue live as you type.

The codebase follows **Clean Architecture** with a **feature-first** folder layout, **Cubit (BLoC)** for state management, and **`flutter_screenutil`** so every screen scales from a `375 × 812` design baseline.

---

## 📑 Table of Contents

1. [Screens & Features](#-screens--features)
2. [Architecture](#-architecture)
3. [Tech Stack & Tools](#-tech-stack--tools)
4. [Directory Structure](#-directory-structure)
5. [Responsive Design Strategy](#-responsive-design-strategy)
6. [Data Flow — End to End](#-data-flow--end-to-end)
7. [Getting Started](#-getting-started)
8. [Known Gaps / Roadmap](#-known-gaps--roadmap)

---

## ✨ Screens & Features

| Screen | What it does | Key widgets |
| --- | --- | --- |
| **Splash** | Animated logo with a sliding "Read Free Books" tagline, auto-navigates to Home after 2s | `SplashViewBody`, `SlidingText` |
| **Home** | Horizontal *Featured Books* carousel + vertical *Newest Books* list, each backed by its own Cubit | `CustomFeaturedBooksListView`, `NewestBooksListView` |
| **Book Details** | Large cover, title/author, rating, price + preview actions, "You can also like" carousel | `BookDetailsViewBody`, `BooksAction` |
| **Search** | Live search against the Google Books API, driven by `onChanged` | `CustomSearchTextField`, `SearchResultListView` |

Every async list renders three explicit states — **loading**, **success**, **failure** — via `CustomLoadingIndicator` and `CustomErrorWidget`.

---

## 🏛 Architecture

### Clean Architecture, feature-first

Rather than grouping by technical type (`all_widgets/`, `all_models/`), the project groups by **feature** (`home/`, `search/`, `splash/`). Each feature owns its full vertical slice, so a feature can be understood — or deleted — in isolation.

```
lib/
├── core/        ← shared across every feature
└── features/
    ├── splash/
    ├── home/
    │   ├── data/          ← models + repository contract & implementation
    │   └── presentation/  ← view_models (Cubits) + views + widgets
    └── search/
```

### The layers

**1. Data layer** — `features/*/data/`
- **Models** (`book_model/`) — plain Dart classes mapping the Google Books JSON (`BookResponse` → `Items` → `VolumeInfo` → `ImageLinks`, …).
- **Repository contract** (`home_repo.dart`, `search_repo.dart`) — an **abstract class** defining *what* the feature can fetch.
- **Repository implementation** (`*_repo_impl.dart`) — *how* it is fetched: calls `ApiService`, parses JSON, converts thrown `DioException`s into typed `Failure`s.

**2. Presentation layer** — `features/*/presentation/`
- **`view_models/`** — the **Cubits**. This is the **MVVM** influence: a Cubit is the ViewModel. It holds no widgets, exposes only state, and is fully unit-testable.
- **`views/`** — screen-level widgets that wire up `BlocProvider`.
- **`views/widgets/`** — small, dumb presentational widgets.

**3. Core** — `core/`
- `errors/failure.dart` — the `Failure` hierarchy and `ServerFailure.fromDioError` / `.fromResponse` mapping.
- `utils/` — `ApiService` (Dio wrapper), `AppRouter` (GoRouter config), `StylesManager`, `AssetsManager`, `constants`.
- `widgets/` — `CustomButton`, `CustomErrorWidget`, `CustomLoadingIndicator`.

### Why the dependency rule matters here

Cubits depend on the **abstract** `HomeRepo` / `SearchRepo`, never on `HomeRepoImpl`. Presentation therefore knows nothing about Dio, endpoints or JSON — swapping the remote source for a local cache means writing one new class and changing nothing else.

### Functional error handling with `dartz`

Every repository method returns `Future<Either<Failure, List<Items>>>`:

```dart
Future<Either<Failure, List<Items>>> fetchFeaturedBooks();
```

- `Left(Failure)`  → something went wrong, carrying a user-readable message
- `Right(List<Items>)` → the data

The Cubit resolves it with `.fold(...)`, which makes the error path **impossible to forget** — the compiler requires both branches. No `try/catch` leaks into the UI.

```dart
result.fold(
  (failure) => emit(FeaturedBooksFailure(failure.errorMessage)),
  (books)   => emit(FeaturedBooksSuccess(books)),
);
```

### State modelling

States are **`sealed class`es** extending `Equatable`:

```dart
sealed class FeaturedBooksState extends Equatable { ... }
final class FeaturedBooksInitial extends FeaturedBooksState {}
final class FeaturedBooksLoading extends FeaturedBooksState {}
final class FeaturedBooksSuccess extends FeaturedBooksState { final List<Items> books; }
final class FeaturedBooksFailure extends FeaturedBooksState { final String errorMessage; }
```

`sealed` gives exhaustive checking; `Equatable` prevents needless rebuilds when an identical state is re-emitted.

---

## 🛠 Tech Stack & Tools

| Concern | Package | Why it's here |
| --- | --- | --- |
| **State management** | `flutter_bloc` ^9.1.0 | Cubit — less boilerplate than full BLoC, no event classes needed |
| **Responsive UI** | `flutter_screenutil` ^5.9.3 | Scales all sizing from the `375 × 812` design baseline |
| **Networking** | `dio` ^5.8.0 | Interceptors, typed `DioException`s, richer than `http` |
| **Functional error handling** | `dartz` ^0.10.1 | `Either<Failure, T>` — errors as values, not exceptions |
| **Value equality** | `equatable` ^2.0.7 | Correct `==`/`hashCode` on states, avoids redundant rebuilds |
| **Navigation** | `go_router` ^14.8.1 | Declarative, URL-based routing; centralised in `AppRouter` |
| **Typography** | `google_fonts` ^8.2.1 | Montserrat applied app-wide via `ThemeData.textTheme` |
| **Icons** | `font_awesome_flutter` ^10.8.0 | Search + solid-star icons |
| **Linting** | `flutter_lints` ^5.0.0 | Official Flutter lint ruleset |
| **API** | Google Books API v1 | `https://www.googleapis.com/books/v1/` |

**Environment:** Dart SDK `>=3.5.3 <4.0.0` · verified on Flutter 3.41.8 (stable).

> **Dependency injection:** this project wires dependencies **manually** at the widget level — e.g. `FeaturedBooksCubit(HomeRepoImpl(ApiService(Dio())))` inside `HomeView`. There is intentionally **no `get_it` service locator** yet; see [Roadmap](#-known-gaps--roadmap).

---

## 📂 Directory Structure

```
lib/
├── main.dart                          # Entry point — ScreenUtilInit + MaterialApp.router
│
├── core/                              # Shared, feature-agnostic code
│   ├── errors/
│   │   └── failure.dart               # Failure base + ServerFailure (Dio → message mapping)
│   ├── utils/
│   │   ├── api_service.dart           # Dio wrapper, base URL + API key injection
│   │   ├── app_router.dart            # GoRouter routes & path constants
│   │   ├── assets_manager.dart        # Asset path constants
│   │   ├── constants.dart             # kPrimaryColor, durations, font family
│   │   └── styles_manager.dart        # Responsive TextStyle getters (.sp)
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_error_widget.dart
│       └── custom_loading_indicator.dart
│
└── features/
    ├── splash/
    │   └── presentation/views/
    │       ├── splash_view.dart
    │       └── widgets/{splash_view_body, sliding_text}.dart
    │
    ├── home/
    │   ├── data/
    │   │   ├── models/book_model/     # BookResponse, Items, VolumeInfo, ImageLinks, …
    │   │   └── repos/
    │   │       ├── home_repo.dart          # abstract contract
    │   │       └── home_repo_impl.dart     # Dio implementation
    │   └── presentation/
    │       ├── view_models/
    │       │   ├── featured_books/    # cubit + sealed states
    │       │   └── newest_books/      # cubit + sealed states
    │       └── views/
    │           ├── home_view.dart
    │           ├── book_details_view.dart
    │           └── widgets/           # app bars, list views, book card, rating, actions
    │
    └── search/
        ├── data/repos/{search_repo, search_repo_impl}.dart
        └── presentation/
            ├── view_models/search_books_cubit/
            └── views/
                ├── search_view.dart
                └── widgets/{custom_search_text_field, search_result_list_view, search_view_body}.dart
```

---

## 📐 Responsive Design Strategy

### Setup

`ScreenUtilInit` wraps the router app in `main.dart`, so every descendant can use the scaling extensions:

```dart
ScreenUtilInit(
  designSize: const Size(375, 812),   // iPhone X / 13 mini baseline
  minTextAdapt: true,                 // keep text legible on small screens
  splitScreenMode: true,              // sane values in split-screen
  builder: (context, child) => MaterialApp.router(...),
);
```

### Which extension to use

| Extension | Scales against | Used for |
| --- | --- | --- |
| `.w` | design **width** | horizontal padding/margins, widths, gaps in a `Row` |
| `.h` | design **height** | vertical padding, heights, gaps in a `Column` |
| `.sp` | text scale | `fontSize`, icon sizes |
| `.r` | **min** of w/h | `borderRadius`, square boxes — keeps circles circular |

Using `.r` for radii is deliberate: `.w` on a radius distorts corners on tablets, `.r` does not.

### Responsive text styles

`StylesManager` exposes **getters**, not `const` fields:

```dart
static TextStyle get textStyle18 => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );
```

A `static const` cannot call `.sp` (not a compile-time constant), and a `static final` would freeze the value at first access — stale after a rotation or split-screen resize. **Getters re-resolve on every build**, so text tracks the current scale.

### Sizing decisions made against the 375 × 812 baseline

Fixed pixel values were not merely suffixed — they were re-tuned to the design grid:

- **Spacing** normalised to a **4/8pt scale** (`4 · 8 · 12 · 16 · 24 · 32`), replacing ad-hoc `3`, `5`, `6.3`, `37`, `43`.
- **Buttons** raised `40 → 48.h`, matching the platform minimum touch target, with `FittedBox` so long labels shrink instead of overflowing.
- **Screen gutters** unified to `16.w` (Home) / `24.w` (Details, Search).
- **Percentage heights replaced with design-space values** — `MediaQuery.height * 0.25` became `200.h`, and `* 0.15` became `120.h`. These are equivalent at the baseline (`0.25 × 812 ≈ 203`) but, unlike raw percentages, stay proportionate on tall or short devices instead of stretching.
- **Icons** sized in `.sp` (`14` rating star, `22` search, `24` app bar) so they scale alongside text.
- **Overflow guards** added: book titles/authors now use `maxLines` + `TextOverflow.ellipsis` inside `Expanded`, removing a fragile `MediaQuery.width * 0.6` hard-coded width.

---

## 🔄 Data Flow — End to End

Tracing "Newest Books" from tap to pixels:

```
HomeView
  └─ BlocProvider creates NewestBooksCubit(HomeRepoImpl(ApiService(Dio())))
       └─ ..fetchNewestBooks()                      ← kicked off immediately
            │
            ├─ emit(NewestBooksLoading())           → UI: CustomLoadingIndicator
            │
            └─ HomeRepoImpl.fetchNewestBooks()
                 └─ ApiService.get(endPoint: 'volumes?q=subject:Programming&…')
                      └─ Dio → Google Books API
                           │
                           ├─ 200 → BookResponse.fromJson(data)
                           │        └─ Right(books.items ?? [])
                           │             └─ emit(NewestBooksSuccess(books))
                           │                  → UI: ListView of BookListViewItem
                           │
                           └─ DioException → ServerFailure.fromDioError(e)
                                    └─ Left(failure)
                                         └─ emit(NewestBooksFailure(msg))
                                              → UI: CustomErrorWidget
```

`BlocBuilder` in `NewestBooksListView` switches on the state and renders exactly one of the three branches.

---

## 🚀 Getting Started

**Prerequisites:** Flutter SDK (3.41+ recommended), Dart `>=3.5.3`.

```bash
git clone <repository-url>
cd bookly

flutter pub get      # install dependencies
flutter run          # launch on a connected device / emulator
```

Useful during development:

```bash
flutter analyze          # static analysis
flutter test             # run the test suite
flutter build apk        # Android release build
flutter build web        # web release build
```

---

## 🧭 Known Gaps / Roadmap

Honest notes — useful to acknowledge during a walkthrough rather than be asked about.

**Architecture**
- **No service locator.** Dependencies are built inline in `HomeView` / `SearchView`, so each view constructs its own `Dio` and `ApiService`. Introducing `get_it` would centralise this and allow a single shared `Dio` instance.
- **No `domain/` layer.** Repository contracts live in `data/` alongside their implementations. A stricter Clean Architecture would move the abstractions (and use-cases/entities) into `domain/`.

**Functionality**
- **Book Details is static.** `BookDetailsViewBody` hard-codes *"The Jungle Book" / Rudyard Kipling* and passes `imageUrl: ''`; `AppRouter` does not yet pass the tapped `Items` model through as a route `extra`.
- **Rating is hard-coded** (`4.8` / `2390`) in `BookRating`.
- **"You can also like" carousel** uses one hard-coded image URL and has **no `itemCount`**, so it scrolls infinitely. Bounding it needs a real similar-books request.
- **Search is not debounced** — every keystroke fires a request. A `Timer`-based debounce (~400 ms) would cut API traffic substantially.
- **Splash uses `push`**, so the Home screen keeps the splash in the back stack. `go` or `pushReplacement` is the intended behaviour.

**Configuration & hygiene**
- **The Google Books API key is hard-coded** in `core/utils/api_service.dart` and committed to the repository. It should move to `--dart-define` or an environment file, and the exposed key should be rotated.
- **`GT Sectra Fine` is referenced but never bundled** — `kGtSectraFine` is used in `StylesManager.textStyle30` and `BookListViewItem`, but `pubspec.yaml` declares no `fonts:` section, so it silently falls back to Montserrat.
- **`test/widget_test.dart` is still the counter template** and does not compile against this app.
- Minor lints remain: `print` calls in `failure.dart`, `PascalCase.dart` model filenames, and a direct `package:bloc` import that should be `package:flutter_bloc`.

---

## 📄 License

This project is for educational purposes. Book data is provided by the [Google Books API](https://developers.google.com/books).
