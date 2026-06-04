//
//  SemiCircularCarousel.swift
//  SemiCircularCarousel
//
//  Created by Mohd Nafishuddin on 04/06/26.
//

import SwiftUI

public struct SemiCircularCarousel<Item, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content

    @State private var selectedIndex: Int = 0
    @State private var dragOffset: CGFloat = 0

    private let cardWidth: CGFloat
    private let cardHeight: CGFloat
    private let spacingRatio: CGFloat

    public init(
        items: [Item],
        cardWidth: CGFloat = 220,
        cardHeight: CGFloat = 350,
        spacingRatio: CGFloat = 0.92,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self.spacingRatio = spacingRatio
        self.content = content
    }

    public var body: some View {
        GeometryReader { geo in
            let spacing = cardWidth * spacingRatio
            let progress = dragOffset / spacing

            ZStack {
                ForEach(items.indices, id: \.self) { index in
                    carouselCard(
                        index: index,
                        progress: progress,
                        spacing: spacing
                    )
                }
            }
            .frame(width: geo.size.width, height: cardHeight + 150)
            .clipped()
            .contentShape(Rectangle())
            .gesture(dragGesture)
        }
        .frame(height: cardHeight + 190)
    }

    private func carouselCard(
        index: Int,
        progress: CGFloat,
        spacing: CGFloat
    ) -> some View {
        let relativeIndex = circularRelativeIndex(
            index: index,
            selectedIndex: selectedIndex,
            count: items.count
        )

        let dragProgress = CGFloat(relativeIndex) + progress
        let distance = abs(dragProgress)
        let clampedProgress = max(-1.4, min(1.4, dragProgress))

        let xOffset = clampedProgress * spacing
        let yOffset = distance * 82
        let rotation = clampedProgress * 24
        let scale = max(0.9, 1 - distance * 0.05)
        let opacity = distance > 1.35 ? 0.0 : 1.0

        return content(items[index])
            .frame(width: cardWidth, height: cardHeight)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation), anchor: .bottom)
            .rotation3DEffect(
                .degrees(-clampedProgress * 12),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.7
            )
            .offset(x: xOffset, y: yOffset)
            .blur(radius: distance > 0.5 ? 1.2 : 0)
            .saturation(distance > 0.5 ? 0.75 : 1)
            .brightness(distance > 0.5 ? -0.08 : 0)
            .opacity(opacity)
            .zIndex(100 - distance)
            .animation(.interactiveSpring(response: 0.36, dampingFraction: 0.9), value: progress)
            .animation(.interactiveSpring(response: 0.48, dampingFraction: 0.86), value: selectedIndex)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation.width
            }
            .onEnded { value in
                let threshold = cardWidth * 0.42
                let dragDistance = value.translation.width

                withAnimation(.interactiveSpring(response: 0.48, dampingFraction: 0.86, blendDuration: 0.2)) {
                    if dragDistance < -threshold {
                        selectedIndex = (selectedIndex + 1) % items.count
                    } else if dragDistance > threshold {
                        selectedIndex = (selectedIndex - 1 + items.count) % items.count
                    }

                    dragOffset = 0
                }
            }
    }

    private func circularRelativeIndex(
        index: Int,
        selectedIndex: Int,
        count: Int
    ) -> Int {
        let rawDifference = index - selectedIndex
        let halfCount = count / 2

        if rawDifference > halfCount {
            return rawDifference - count
        } else if rawDifference < -halfCount {
            return rawDifference + count
        } else {
            return rawDifference
        }
    }
}

public extension SemiCircularCarousel where Item == Int {
    init(
        count: Int,
        cardWidth: CGFloat = 220,
        cardHeight: CGFloat = 350,
        spacingRatio: CGFloat = 0.92,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.init(
            items: Array(0..<count),
            cardWidth: cardWidth,
            cardHeight: cardHeight,
            spacingRatio: spacingRatio,
            content: content
        )
    }
}
