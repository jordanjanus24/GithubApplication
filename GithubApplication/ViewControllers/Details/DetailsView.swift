//
//  DetailsView.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import SwiftUI


struct DetailsView : View  {
    
    
    @EnvironmentObject var viewModel: DetailsViewModel
    @State var note = ""
    
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
                    Text(viewModel.user?.name ?? "")
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
            HStack {
                TextEditor(text:$note)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .background(Color.gray)
                    .padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
            }.padding(20)
            Spacer()
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .onAppear(perform: {
            viewModel.fetchUser()
        })
    }
}
