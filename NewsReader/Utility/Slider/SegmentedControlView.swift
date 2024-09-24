//
//  SegmentedControlView.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI

struct SegmentedControlView: View {
	@Binding private var selectedIndex: Int

	@State private var frames: Array<CGRect>
	@State private var backgroundFrame = CGRect.zero
	@State private var isScrollable = true
    @Binding private var rectPreferenceKey: CGRect

	private let titles: [String]

    init(selectedIndex: Binding<Int>, titles: [String], rectPreferenceKey: Binding<CGRect> = .constant(CGRectZero)) {
		self._selectedIndex = selectedIndex
		self.titles = titles
		frames = Array<CGRect>(repeating: .zero, count: titles.count)
        self._rectPreferenceKey = rectPreferenceKey
	}

	var body: some View {
		VStack {
			if isScrollable {
				ScrollView(.horizontal, showsIndicators: false) {
					SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles)
				}
			} else {
				SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable, titles: titles)
			}
		}
		.background(
			GeometryReader { geoReader in
				Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
					.onPreferenceChange(RectPreferenceKey.self) {
                    if !CGRectEqualToRect(rectPreferenceKey, $0) {
                        
                        rectPreferenceKey = $0
                        self.setBackgroundFrame(frame: rectPreferenceKey)
                    }
				}
			}
        )
	}

	private func setBackgroundFrame(frame: CGRect)
	{
		backgroundFrame = frame
		checkIsScrollable()
	}

	private func checkIsScrollable()
	{
		if frames[frames.count - 1].width > .zero
		{
			var width = CGFloat.zero

			for frame in frames
			{
				width += frame.width
			}

			if isScrollable && width <= backgroundFrame.width
			{
				isScrollable = false
			}
			else if !isScrollable && width > backgroundFrame.width
			{
				isScrollable = true
			}
		}
	}
}

private struct SegmentedControlButtonView: View {
	@Binding private var selectedIndex: Int
	@Binding private var frames: [CGRect]
	@Binding private var backgroundFrame: CGRect
	@Binding private var isScrollable: Bool

	private let titles: [String]
	let checkIsScrollable: (() -> Void)

	init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, isScrollable: Binding<Bool>, checkIsScrollable: (@escaping () -> Void), titles: [String])
	{
		_selectedIndex = selectedIndex
		_frames = frames
		_backgroundFrame = backgroundFrame
		_isScrollable = isScrollable

		self.checkIsScrollable = checkIsScrollable
		self.titles = titles
	}

	var body: some View {
		HStack(spacing: 0) {
			ForEach(titles.indices, id: \.self) { index in
				Button(action:{ selectedIndex = index })
				{
					HStack {
						Text(titles[index])
                            .font(.title3)
                            .foregroundColor(selectedIndex == index ? .white : .accentColor)
                            .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                            .background(
                                Rectangle()
                                    .fill( .clear)
                                    .clipShape(.rect(cornerRadius: 5))
                            )
                            .background(
                                Rectangle()
                                    .fill(selectedIndex == index ? Color.accentColor : .clear)
                                    .clipShape(.rect(cornerRadius: 5))
                            )
                            .animation(.default, value: true)
					}
				}
                .accessibilityIdentifier(titles[index])
				.background(
					GeometryReader { geoReader in
						Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
							.onPreferenceChange(RectPreferenceKey.self) {
								self.setFrame(index: index, frame: $0)
							}
					}
				)
			}
		}
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.accentColor, lineWidth: 4)
                .clipped()
        )
        .cornerRadius(5)
	}

	private func setFrame(index: Int, frame: CGRect) {
		self.frames[index] = frame

		checkIsScrollable()
	}
}

private struct CustomSegmentButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration
			.label
			.padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
            .background(configuration.isPressed ? .accentColor : Color.gray)
            .clipShape(.rect(cornerSize: CGSize(width: 5, height: 5), style: .continuous))
	}
}
