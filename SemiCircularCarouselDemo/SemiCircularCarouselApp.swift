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

struct CarouselDemoView: View {
    private let cardColors: [Color] = [
        .indigo, .purple, .pink, .orange, .teal,
    ]

    var body: some View {
        VStack {

            SemiCircularCarousel(count: cardColors.count) { index in
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                cardColors[index],
                                cardColors[index].opacity(0.7),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        Text("Card \(index + 1)")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(.white)
                    }
                    .shadow(color: .black.opacity(0.2), radius: 16, y: 8)
            }
        }
    }
}

#Preview {
    CarouselDemoView()
}
