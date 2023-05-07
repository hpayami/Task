//
//  View+Extension.swift
//  Task
//
//  Created by PhD Hossein Payami on 5/7/23.
//

import Foundation
import SwiftUI
extension View {


	func safeArea() -> UIEdgeInsets {
		guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero}
		guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
		return safeArea
	}
	func screenBounds()->CGRect{
		return UIScreen.main.bounds
	}
	func endEditing(_ force: Bool) {
		UIApplication.shared.windows.forEach { $0.endEditing(force)}
	}

	func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
		background(
			GeometryReader { geometryProxy in
				Color.clear
					.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
			}
		)
		.onPreferenceChange(SizePreferenceKey.self, perform: onChange)
	}

	func embedInNavigationView() -> some View {
		return NavigationView { self }
	}

}

struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	static func reduce(value _: inout CGSize, nextValue _: () -> CGSize) {}
}


