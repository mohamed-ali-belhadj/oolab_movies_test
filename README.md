# OolabMoviestest

Small iOS app that lists movies from the Wookie CodeSubmit API. Built with **SwiftUI** and **MVVM**, using **async/await**.

## Requirements
- Xcode 15+ / iOS 16+
- Swift 5.9+

## Run
1. Open the project in Xcode.
2. Pick an iOS 16+ simulator.
3. **Run**.

## API
- `GET https://wookie.codesubmit.io/movies`
- Header: `Authorization: Bearer Wookie2019`
- Configured in `DefaultMovieService`.

## Architecture & Decisions
- **MVVM**: Views stay declarative; ViewModels own state, loading, and formatting.
- **Networking**: `HTTPClient` (URLSession, async/await) + `NetworkError`.
- **Service layer**: `MovieService` isolates API details from ViewModels.
- **Parsing**: `MoviesResponse(data:)` → `Movie(dict:)` via `JSONSerialization`.  
  Handles `director` as `String` **or** `[String]`, parses `released_on` with a fixed ISO-like formatter.
- **UI**: SwiftUI grid list, pull-to-refresh, and a simple `LoadingOverlay`.

## Concurrency & Threading
- `async/await` for network calls.
- ViewModel state mutations happen on the main actor.

## Error Handling
- Maps common URLSession errors (no internet, timeout, cancelled) to `NetworkError`.
- Non-2xx responses map to `httpStatus(code)`.
