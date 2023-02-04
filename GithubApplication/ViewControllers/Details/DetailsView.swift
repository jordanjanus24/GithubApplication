//
//  DetailsView.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import SwiftUI


struct DetailsView: View {
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 200,
                        alignment: .topLeading
                    )
                    .background(Color.gray)
            }
            .padding(20)
            HStack {
                Text("Followers: 100")
                    .font(.system(
                        size:16,
                        weight: .regular,
                        design: .default)
                    )
                Text("Following: 100")
                    .font(.system(
                        size:16,
                        weight: .regular,
                        design: .default)
                    )
            }
            VStack {
                HStack {
                    Text("Name: ")
                        .font(.system(size:19,
                                                 weight: .bold,
                                                 design: .default))
                    Text("Janus Jordan")
                        .font(.system(
                                size:18,
                                weight: .regular,
                                design: .default)
                        )
                    Spacer()
                }.padding(.bottom, 10)
                HStack {
                    Text("Company: ")
                        .font(.system(size:19,
                                                 weight: .bold,
                                                 design: .default))
                    Text("Atos Syntel")
                        .font(.system(
                                size:18,
                                weight: .regular,
                                design: .default)
                        )
                    Spacer()
                }.padding(.bottom, 10)
                HStack {
                    Text("Blog: ")
                        .font(.system(size:19,
                                     weight: .bold,
                                     design: .default))
                    Text("www.apple.com")
                        .font(.system(
                                size:18,
                                weight: .regular,
                                design: .default)
                        )
                    Spacer()
                }.padding(.bottom, 10)
            }.padding(.leading, 20)
            .padding(.top, 20)
            .padding(.bottom, 20)
            HStack {
                Text("Notes: ")
                    .font(.system(size:19,
                                 weight: .bold,
                                 design: .default))
                Spacer()
            }.padding(.leading, 20)
            
            Spacer()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
