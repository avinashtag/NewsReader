//
//  UnderlineModifier.swift
//  NewsReader
//
//  Created by Avinash on 23/09/2024.
//

import SwiftUI

/// This modifier provides an animated underscore for the SegmentedControl.
struct UnderlineModifier: ViewModifier
{
	var selectedIndex: Int
	let frames: [CGRect]

	func body(content: Content) -> some View
	{
		content
			.background(
				Rectangle()
					.fill(Color.accentColor)
					.frame(width: frames[selectedIndex].width, height: 2)
					.offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
			)
			.background(
				Rectangle()
					.fill(Color.gray)
					.frame(height: 1), alignment: .bottomLeading
			)
            .animation(.default, value: true)
	}
}
