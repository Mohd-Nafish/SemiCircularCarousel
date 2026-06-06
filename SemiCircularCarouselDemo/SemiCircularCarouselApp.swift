//
//  SemiCircularCarouselApp.swift
//  SemiCircularCarouselDemo
//
//  Created by Mohd Nafishuddin on 04/06/26.
//

import SemiCircularCarousel
import SwiftUI

@main
struct SemiCircularCarouselApp: App {
    var body: some Scene {
        WindowGroup {
            CarouselDemoView()
        }
    }
}

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let symbol: String
    let temperature: String
    let colors: [Color]
}

private let destinations: [Destination] = [
    Destination(
        name: "Santorini",
        country: "Greece",
        symbol: "sun.max.fill",
        temperature: "28°",
        colors: [Color(red: 0.18, green: 0.55, blue: 0.95), Color(red: 0.08, green: 0.27, blue: 0.62)]
    ),
    Destination(
        name: "Kyoto",
        country: "Japan",
        symbol: "leaf.fill",
        temperature: "21°",
        colors: [Color(red: 0.97, green: 0.42, blue: 0.52), Color(red: 0.60, green: 0.13, blue: 0.40)]
    ),
    Destination(
        name: "Reykjavík",
        country: "Iceland",
        symbol: "snowflake",
        temperature: "4°",
        colors: [Color(red: 0.36, green: 0.78, blue: 0.85), Color(red: 0.10, green: 0.35, blue: 0.55)]
    ),
    Destination(
        name: "Marrakech",
        country: "Morocco",
        symbol: "flame.fill",
        temperature: "33°",
        colors: [Color(red: 0.98, green: 0.62, blue: 0.20), Color(red: 0.78, green: 0.24, blue: 0.12)]
    ),
    Destination(
        name: "Banff",
        country: "Canada",
        symbol: "mountain.2.fill",
        temperature: "12°",
        colors: [Color(red: 0.40, green: 0.66, blue: 0.50), Color(red: 0.10, green: 0.32, blue: 0.30)]
    ),
]

struct CarouselDemoView: View {
    var body: some View {
        ZStack {
            backgroundGradient

            VStack(spacing: 0) {
                header

                Spacer(minLength: 0)

                SemiCircularCarousel(items: destinations) { destination in
                    DestinationCard(destination: destination)
                }

                Spacer(minLength: 0)

                Text("Swipe to explore")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(.white.opacity(0.6))
                    .padding(.bottom, 24)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 6) {
            Text("DISCOVER")
                .font(.caption.weight(.bold))
                .tracking(4)
                .foregroundStyle(.white.opacity(0.55))

            Text("Where to next?")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
        .padding(.top, 72)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color(red: 0.05, green: 0.06, blue: 0.12), Color(red: 0.10, green: 0.11, blue: 0.20)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct DestinationCard: View {
    let destination: Destination

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 32, style: .continuous)
    }

    var body: some View {
        ZStack {
            cardShape
                .fill(
                    LinearGradient(
                        colors: destination.colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(alignment: .topTrailing) {
                    Image(systemName: destination.symbol)
                        .font(.system(size: 150, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.10))
                        .offset(x: 20, y: 10)
                }
                .clipShape(cardShape)
                .overlay {
                    cardShape
                        .strokeBorder(.white.opacity(0.18), lineWidth: 1)
                }

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: destination.symbol)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.18), in: Circle())

                    Spacer()

                    Text(destination.temperature)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.white)
                }

                Spacer()

                Text(destination.country.uppercased())
                    .font(.caption.weight(.semibold))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.8))

                Text(destination.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                HStack(spacing: 6) {
                    Text("Explore")
                        .font(.subheadline.weight(.semibold))
                    Image(systemName: "arrow.right")
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundStyle(destination.colors.last ?? .black)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(.white, in: Capsule())
                .padding(.top, 16)
            }
            .padding(24)
        }
        .shadow(color: (destination.colors.last ?? .black).opacity(0.5), radius: 22, x: 0, y: 16)
    }
}

#Preview {
    CarouselDemoView()
}
