# SemiCircularCarousel

A SwiftUI carousel that lays cards along a semi-circular arc with depth, rotation, and swipe-to-select navigation.

## Features

- Semi-circular card layout with vertical arc offset
- 2D and 3D rotation for a stacked, physical feel
- Horizontal drag with spring animations
- Circular index wrapping (shortest path around the ring)
- Depth effects on side cards (scale, blur, saturation, brightness)
- Generic over any `Item` type, or a simple `count` initializer

## Requirements

- iOS 16.0+
- Swift 5.9+
- Xcode 15+ (demo app tested with Xcode 26.x)

## Installation

### Swift Package Manager (remote)

In Xcode: **File → Add Package Dependencies…** and enter your repository URL:

```
https://github.com/<your-username>/SemiCircularCarousel.git
```

Choose a version rule (e.g. **Up to Next Major** from `1.0.0`), then add the **SemiCircularCarousel** library product to your app target.

### Swift Package Manager (local)

1. **File → Add Package Dependencies… → Add Local…**
2. Select the folder that contains `Package.swift` (the repository root).
3. Add the **SemiCircularCarousel** product to your target.

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/<your-username>/SemiCircularCarousel.git", from: "1.0.0"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: ["SemiCircularCarousel"]
    ),
]
```

## Usage

Import the module and provide card content with a view builder.

### With a count (indices 0…<count)

```swift
import SemiCircularCarousel
import SwiftUI

struct ContentView: View {
    var body: some View {
        SemiCircularCarousel(count: 5) { index in
            RoundedRectangle(cornerRadius: 24)
                .fill(.blue.gradient)
                .overlay {
                    Text("Card \(index + 1)")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                }
        }
    }
}
```

### With your own data

```swift
struct Album: Identifiable {
    let id: String
    let title: String
}

struct ContentView: View {
    let albums: [Album]

    var body: some View {
        SemiCircularCarousel(items: albums) { album in
            AlbumCard(album: album)
        }
    }
}
```

### Layout options

| Parameter       | Default | Description                          |
|----------------|---------|--------------------------------------|
| `cardWidth`    | `220`   | Width of each card                   |
| `cardHeight`   | `350`   | Height of each card                  |
| `spacingRatio` | `0.92`  | Horizontal spacing as a ratio of width |

```swift
SemiCircularCarousel(
    count: 5,
    cardWidth: 200,
    cardHeight: 320,
    spacingRatio: 0.9
) { index in
    MyCardView(index: index)
}
```

Swipe left or right on the carousel to change the selected card. Drag distance must exceed roughly 42% of the card width to advance.

## Demo app

This repository includes a sample app:

1. Open `SemiCircularCarousel.xcodeproj` in Xcode.
2. Select the **SemiCircularCarouselDemo** scheme.
3. Run on an iPhone simulator or device.

The demo lives in `SemiCircularCarouselDemo/` and imports the local package from the repo root.

## Project structure

```
SemiCircularCarousel/
├── Package.swift
├── Sources/
│   └── SemiCircularCarousel/
│       └── SemiCircularCarousel.swift
├── SemiCircularCarouselDemo/
│   └── SemiCircularCarouselApp.swift
└── SemiCircularCarousel.xcodeproj
```

The Swift package product is **SemiCircularCarousel**. The demo app target is **SemiCircularCarouselDemo** so the app module name does not conflict with the library.

## Author

Mohd Nafishuddin

## License

Specify a license before publishing (e.g. MIT). Add a `LICENSE` file when you choose one.
