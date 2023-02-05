//
//  LabelledText.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/5/23.
//

import SwiftUI

struct LabelledText: View {
    
    var label: String
    var text: String
    var withSpacer: Bool = false
    var body: some View {
        HStack {
            Text("\(label.capitalizedSentence):")
                .font(.system(
                    size:14,
                    weight: .bold,
                    design: .default)
            )
            Text("\(text)")
                .font(.system(
                    size:16,
                    weight: .regular,
                    design: .default)
            )
            if withSpacer == true {
                Spacer()
            }
        }.padding(.bottom, 10)
    }
}
