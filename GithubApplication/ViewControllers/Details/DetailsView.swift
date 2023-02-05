//
//  DetailsView.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import SwiftUI
import Combine


struct DetailsView : View  {
    
    @ObservedObject var imageLoader = ImageLoader()
    @EnvironmentObject var viewModel: DetailsViewModel
    @State var note = ""
    @State var image: UIImage? = UIImage()
    @State private var isPresentingAlert: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Image(uiImage: image ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 400,
                            alignment: .topLeading
                        )
                        .clipped()
                        .onReceive(imageLoader.$image) { image in
                            self.image = image
                        }
                        .onReceive(viewModel.didChange) { urlString in
                            imageLoader.loadImage(for: urlString)
                        }
                        .background(Color.gray.brightness(0.4))
                }
                HStack {
                    LabelledText(label: "Followers", text: "\(viewModel.user?.followers ?? 0)")
                    Spacer()
                    LabelledText(label: "Following", text: "\(viewModel.user?.following ?? 0)")
                }.padding(.leading, 20).padding(.trailing, 20).padding(.top, 15)
                VStack {
                    LabelledText(label: "Name", text: viewModel.user?.name ?? "", withSpacer: true)
                    LabelledText(label: "Company", text: viewModel.user?.company ?? "N/A", withSpacer: true)
                    LabelledText(label: "Blog", text: viewModel.user?.blog ?? "N/A", withSpacer: true)
                }.padding(.leading, 20)
                .padding(.bottom, 5)
                HStack {
                    Text("Notes: ")
                        .font(.system(size:16,
                                     weight: .bold,
                                     design: .default))
                    Spacer()
                }.padding(.leading, 20)
                VStack {
                    TextEditor(text:$note)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.gray)
                        .background(Color.gray.brightness(0.4))
                        .font(.system(size:16,
                             weight: .regular,
                             design: .default))
                        .padding(10)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1.5))
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 150,
                            maxHeight: 150,
                            alignment: .topLeading
                        )
                        .onReceive(viewModel.didChangeNote) { note in
                            self.note = note
                        }
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.saveNote(note)
                            isPresentingAlert = true
                        }, label: {
                            Text("Save")
                                .foregroundColor(Color.white)
                                .frame(width: 150, height: 40)
                                .cornerRadius(8)
                                .background(Color.blue)
                                .font(.system(size:16,
                                     weight: .regular,
                                     design: .default))
                        }).padding()
                        
                        Spacer()
                    }.frame(
                        maxWidth: .infinity,
                        maxHeight: 150,
                        alignment: .topLeading
                    )
                }.padding(.leading, 20).padding(.trailing, 20)
                Spacer()
            }.alert(isPresented: $isPresentingAlert) {
                Alert(title: Text("Github"), message: Text("Note saved."), dismissButton: .default(Text("OK")))
            }
            
        }
        .navigationTitle(viewModel.user?.name ?? viewModel.user?.login ?? "")
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
