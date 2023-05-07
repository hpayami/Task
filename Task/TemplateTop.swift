//
//  TemplateTop.swift
//  Task
//
//  Created by PhD Hossein Payami on 5/7/23.
//

import SwiftUI

struct TemplateTop: View {
	var body: some View {

		VStack(alignment: .center){
			Image("Pattern")
				.resizable()
				.scaledToFill()
				.frame(width: screenBounds().width, height: screenBounds().height/2)
				.blur(radius: 60)
				.offset(x: -65,y: 0)
			Spacer()

		} .padding()
			.offset(x:10,y:-210)

	}
}

struct TemplateTop_Previews: PreviewProvider {
	static var previews: some View {
		TemplateTop()
	}
}
